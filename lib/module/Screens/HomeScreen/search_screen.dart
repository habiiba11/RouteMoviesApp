import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../Core/Asset/Theme/AppColor.dart';
import '../../../bloc/search/search_bloc.dart';
import '../../../bloc/search/search_event.dart';
import '../../../bloc/search/search_state.dart';
import '../../../models/movie.dart';
import '../widgets/error_retry_widget.dart';
import '../widgets/responsive_movie_grid.dart';
import 'movie_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        context.read<SearchBloc>().add(SearchQueryChanged(query));
      }
    });
  }

  void _navigateToDetails(BuildContext context, Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MovieDetailsScreen(movie: movie),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: SafeArea(
        child: Column(
          children: [
            // Search Input Field
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF282A28),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.08),
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  cursorColor: AppColor.yellow,
                  textInputAction: TextInputAction.search,
                  onChanged: _onSearchChanged,
                  onSubmitted: (value) {
                    _debounce?.cancel();
                    context.read<SearchBloc>().add(SearchQueryChanged(value));
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: const TextStyle(color: AppColor.white, fontSize: 14),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset(
                        'Asset/Svg/search.svg',
                        width: 20,
                        height: 20,
                        colorFilter: const ColorFilter.mode(AppColor.white, BlendMode.srcIn),
                      ),
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                      icon: const Icon(Icons.clear, color: AppColor.textMuted, size: 20),
                      onPressed: () {
                        _searchController.clear();
                        context.read<SearchBloc>().add(ClearSearch());
                        setState(() {});
                      },
                    )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),
            ),

            // Search Content / Results
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColor.yellow),
                    );
                  } else if (state is SearchError) {
                    return ErrorRetryWidget(
                      message: state.message,
                      onRetry: () {
                        context.read<SearchBloc>().add(
                              SearchQueryChanged(_searchController.text),
                            );
                      },
                    );
                  } else if (state is SearchLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: Text(
                            'Found ${state.movies.length} results for "${state.query}"',
                            style: const TextStyle(
                              color: AppColor.textMuted,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ResponsiveMovieGrid(
                            movies: state.movies,
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 90),
                            onMovieTap: (movie) => _navigateToDetails(context, movie),
                          ),
                        ),
                      ],
                    );
                  } else if (state is SearchEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.movie_filter_outlined, color: AppColor.textMuted, size: 64),
                          const SizedBox(height: 12),
                          Text(
                            'No movies found for "${state.query}"',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Try searching for another movie title',
                            style: TextStyle(color: AppColor.textMuted, fontSize: 13),
                          ),
                        ],
                      ),
                    );
                  }
                  // Initial idle state
                  return Center(
                    child:
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

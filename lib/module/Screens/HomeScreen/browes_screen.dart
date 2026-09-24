import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Core/Asset/Theme/AppColor.dart';
import '../../../bloc/browse/browse_bloc.dart';
import '../../../bloc/browse/browse_event.dart';
import '../../../bloc/browse/browse_state.dart';
import '../../../models/movie.dart';
import '../widgets/error_retry_widget.dart';
import '../widgets/responsive_movie_grid.dart';
import 'movie_details_screen.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<BrowseBloc>();
    if (bloc.state is BrowseInitial) {
      bloc.add(FetchBrowseMovies());
    }
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
        child: BlocBuilder<BrowseBloc, BrowseState>(
          builder: (context, state) {
            if (state is BrowseLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColor.yellow),
              );
            } else if (state is BrowseError) {
              return ErrorRetryWidget(
                message: state.message,
                onRetry: () => context.read<BrowseBloc>().add(FetchBrowseMovies()),
              );
            } else if (state is BrowseLoaded) {
              final genresList = state.genresSet.toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 10),
                    child: Text(
                      'Browse by Genre',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),

                  // Category Tabs / Chips (from the unique Set of genres)
                  SizedBox(
                    height: 42,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: genresList.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final genre = genresList[index];
                        final isSelected = genre.toLowerCase() == state.selectedGenre.toLowerCase();

                        return ChoiceChip(
                          label: Text(genre),
                          selected: isSelected,
                          onSelected: (_) {
                            context.read<BrowseBloc>().add(SelectGenre(genre));
                          },
                          selectedColor: AppColor.yellow,
                          backgroundColor: const Color(0xFF282A28),
                          side: BorderSide(
                            color: isSelected
                                ? AppColor.yellow
                                : Colors.white.withOpacity(0.12),
                            width: 1,
                          ),
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.black : Colors.white70,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            fontSize: 13,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Movies matching selected genre
                  Expanded(
                    child: state.filteredMovies.isEmpty
                        ? Center(
                            child: Text(
                              'No movies found for ${state.selectedGenre}',
                              style: const TextStyle(color: AppColor.textMuted),
                            ),
                          )
                        : ResponsiveMovieGrid(
                            movies: state.filteredMovies,
                            padding: const EdgeInsets.fromLTRB(16, 4, 16, 90),
                            onMovieTap: (movie) => _navigateToDetails(context, movie),
                          ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
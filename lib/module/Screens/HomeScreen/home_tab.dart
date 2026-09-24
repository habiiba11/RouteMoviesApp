import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Core/Asset/Theme/AppColor.dart';
import '../../../bloc/home/home_bloc.dart';
import '../../../bloc/home/home_event.dart';
import '../../../bloc/home/home_state.dart';
import '../../../models/movie.dart';
import '../widgets/error_retry_widget.dart';
import '../widgets/movie_card.dart';
import '../widgets/section_header.dart';
import 'movie_details_screen.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<HomeBloc>();
    if (bloc.state is HomeInitial) {
      bloc.add(FetchHomeData());
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
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColor.yellow),
            );
          } else if (state is HomeError) {
            return ErrorRetryWidget(
              message: state.message,
              onRetry: () => context.read<HomeBloc>().add(FetchHomeData()),
            );
          } else if (state is HomeLoaded) {
            return RefreshIndicator(
              color: AppColor.yellow,
              backgroundColor: AppColor.gray,
              onRefresh: () async {
                context.read<HomeBloc>().add(FetchHomeData());
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Featured Hero Banner
                    if (state.featuredMovies.isNotEmpty)
                      _buildHeroBanner(context, state.featuredMovies.first),

                    const SizedBox(height: 16),

                    // Popular Movies
                    if (state.popularMovies.isNotEmpty) ...[
                      SectionHeader(
                        title: 'Popular',
                        showSeeMore: false,
                      ),
                      _buildHorizontalMovieList(context, state.popularMovies),
                    ],

                    const SizedBox(height: 20),

                    // Top Rated Movies
                    if (state.topRatedMovies.isNotEmpty) ...[
                      SectionHeader(
                        title: 'Top Rated',
                        showSeeMore: false,
                      ),
                      _buildHorizontalMovieList(context, state.topRatedMovies),
                    ],
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildHeroBanner(BuildContext context, Movie movie) {
    final size = MediaQuery.of(context).size;
    final bannerHeight = (size.height * 0.48).clamp(320.0, 520.0);

    return GestureDetector(
      onTap: () => _navigateToDetails(context, movie),
      child: Stack(
        children: [
          // Banner Image
          Container(
            height: bannerHeight,
            width: double.infinity,
            foregroundDecoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Color(0x99121312),
                  AppColor.black,
                ],
                stops: [0.3, 0.75, 1.0],
              ),
            ),
            child: movie.backgroundImage.isNotEmpty
                ? Image.network(
                    movie.backgroundImage,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(color: AppColor.gray),
                  )
                : Container(color: AppColor.gray),
          ),

          // Content Overlay
          Positioned(
            left: 20,
            right: 20,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Available Now Tag
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColor.yellow.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    'Available Now',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Title
                Text(
                  movie.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 6),

                // Rating & Genres
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star_rounded, color: AppColor.yellow, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      movie.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    if (movie.genres.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      Text(
                        '•  ${movie.genres.take(2).join(', ')}',
                        style: const TextStyle(
                          color: AppColor.textMuted,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 12),

                // Watch Button
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColor.yellow,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.yellow.withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.play_arrow_rounded, color: Colors.black, size: 20),
                      SizedBox(width: 6),
                      Text(
                        'Watch Now',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalMovieList(BuildContext context, List<Movie> movies) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final movie = movies[index];
          return MovieCard(
            movie: movie,
            width: 125,
            height: 195,
            onTap: () => _navigateToDetails(context, movie),
          );
        },
      ),
    );
  }
}

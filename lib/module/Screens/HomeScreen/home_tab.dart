import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Core/Asset/Theme/AppColor.dart';
import '../../../bloc/home/home_bloc.dart';
import '../../../bloc/home/home_event.dart';
import '../../../bloc/home/home_state.dart';
import '../../../models/movie.dart';
import '../../../repository/movie_repository.dart';
import '../widgets/movie_card.dart';
import '../widgets/section_header.dart';
import 'movie_details_screen.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late PageController _heroController;
  int _currentHeroIndex = 1;

  @override
  void initState() {
    super.initState();
    _heroController = PageController(
      viewportFraction: 0.65,
      initialPage: _currentHeroIndex,
    );
    final bloc = context.read<HomeBloc>();
    if (bloc.state is HomeInitial) {
      bloc.add(FetchHomeData());
    }
  }

  @override
  void dispose() {
    _heroController.dispose();
    super.dispose();
  }

  void _navigateToDetails(BuildContext context, Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MovieDetails(movie: movie),
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
            // If error, fall back to sample movies so the UI is always accessible
            return _buildContent(
              context,
              MovieRepository.sampleFeaturedMovies,
              MovieRepository.sampleActionMovies,
            );
          } else if (state is HomeLoaded) {
            final featured = state.featuredMovies.isNotEmpty
                ? state.featuredMovies
                : MovieRepository.sampleFeaturedMovies;
            final popular = state.popularMovies.isNotEmpty
                ? state.popularMovies
                : MovieRepository.sampleActionMovies;
            return _buildContent(context, featured, popular);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    List<Movie> featuredMovies,
    List<Movie> actionMovies,
  ) {
    final activeIndex = _currentHeroIndex.clamp(0, featuredMovies.length - 1);
    final activeMovie = featuredMovies[activeIndex];

    return RefreshIndicator(
      color: AppColor.yellow,
      backgroundColor: AppColor.gray,
      onRefresh: () async {
        context.read<HomeBloc>().add(FetchHomeData());
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section with dynamic Movie Backdrop & Carousel
            Stack(
              children: [
                // Atmospheric Backdrop image with smooth gradient
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 520,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      _buildBackdropImage(activeMovie),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.65),
                              Colors.black.withValues(alpha: 0.40),
                              AppColor.black,
                            ],
                            stops: const [0.0, 0.65, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Hero Content
                Column(
                  children: [
                    // Available Now Header
                    SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 14, bottom: 8),
                        child: Center(
                          child: Text(
                            'Available Now',
                            style: GoogleFonts.greatVibes(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.w400,
                              shadows: const [
                                Shadow(
                                  color: Colors.black87,
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // 3D Carousel
                    _buildHeroCarousel(context, featuredMovies),

                    const SizedBox(height: 14),

                    // Script "Watch Now" (Tappable CTA)
                    GestureDetector(
                      onTap: () => _navigateToDetails(context, activeMovie),
                      child: Text(
                        'Watch Now',
                        style: GoogleFonts.greatVibes(
                          color: Colors.white,
                          fontSize: 42,
                          fontWeight: FontWeight.w400,
                          shadows: const [
                            Shadow(
                              color: Colors.black,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Action Section Header
            SectionHeader(
              title: 'Action',
              showSeeMore: true,
              onSeeMore: () {
                // Navigate to browse or search action
              },
            ),

            // Action Movies Horizontal List
            _buildActionMovieList(context, actionMovies),
          ],
        ),
      ),
    );
  }

  Widget _buildBackdropImage(Movie movie) {
    final backdropUrl = movie.backgroundImage.isNotEmpty
        ? movie.backgroundImage
        : (movie.largeCoverImage.isNotEmpty
            ? movie.largeCoverImage
            : movie.posterUrl);

    if (backdropUrl.startsWith('http')) {
      return Image.network(
        backdropUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => Container(color: AppColor.black),
      );
    } else if (backdropUrl.isNotEmpty) {
      return Image.asset(
        backdropUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => Container(color: AppColor.black),
      );
    }
    return Container(color: AppColor.black);
  }

  Widget _buildHeroCarousel(BuildContext context, List<Movie> movies) {
    return SizedBox(
      height: 350,
      child: PageView.builder(
        controller: _heroController,
        itemCount: movies.length,
        onPageChanged: (index) => setState(() => _currentHeroIndex = index),
        itemBuilder: (context, index) {
          final movie = movies[index];
          final isActive = index == _currentHeroIndex;

          return AnimatedScale(
            scale: isActive ? 1.0 : 0.84,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            child: AnimatedOpacity(
              opacity: isActive ? 1.0 : 0.45,
              duration: const Duration(milliseconds: 250),
              child: _buildHeroCard(context, movie, isActive),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeroCard(BuildContext context, Movie movie, bool isActive) {
    final posterUrl = movie.largeCoverImage.isNotEmpty
        ? movie.largeCoverImage
        : (movie.mediumCoverImage.isNotEmpty
            ? movie.mediumCoverImage
            : movie.backgroundImage);

    return GestureDetector(
      onTap: () => _navigateToDetails(context, movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isActive ? 0.7 : 0.4),
                blurRadius: isActive ? 18 : 8,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Poster Image
                posterUrl.startsWith('http')
                    ? Image.network(
                        posterUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Container(color: AppColor.gray),
                      )
                    : Image.asset(
                        posterUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Container(color: AppColor.gray),
                      ),

                // Rating badge (Top-Left: "7.7 ★")
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xB3121312),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          movie.rating > 0
                              ? movie.rating.toStringAsFixed(1)
                              : '7.7',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.star, color: AppColor.yellow, size: 13),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionMovieList(BuildContext context, List<Movie> movies) {
    return SizedBox(
      height: 195,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final movie = movies[index];
          return MovieCard(
            movie: movie,
            width: 124,
            height: 185,
            showTitle: false,
            onTap: () => _navigateToDetails(context, movie),
          );
        },
      ),
    );
  }
}
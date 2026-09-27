import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final PageController _heroController = PageController(viewportFraction: 0.62);
  int _currentHeroIndex = 0;

  @override
  void initState() {
    super.initState();
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
        builder: (_) => MovieDetailsScreen(movie: movie),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
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
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
                        child: Text(
                          'Home',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      // Featured Hero Carousel
                      if (state.featuredMovies.isNotEmpty)
                        _buildHeroCarousel(context, state.featuredMovies),

                      const SizedBox(height: 20),

                      // Popular / Action Movies
                      if (state.popularMovies.isNotEmpty) ...[
                        const SectionHeader(
                          title: 'Action',
                          showSeeMore: true,
                        ),
                        _buildHorizontalMovieList(context, state.popularMovies),
                      ],
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildHeroCarousel(BuildContext context, List<Movie> movies) {
    final size = MediaQuery.of(context).size;
    final bannerHeight = (size.height * 0.55).clamp(420.0, 620.0);

    return SizedBox(
      height: bannerHeight,
      child: PageView.builder(
        controller: _heroController,
        itemCount: movies.length,
        onPageChanged: (index) => setState(() => _currentHeroIndex = index),
        itemBuilder: (context, index) {
          final movie = movies[index];
          final isActive = index == _currentHeroIndex;
          return AnimatedScale(
            scale: isActive ? 1.0 : 0.88,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            child: AnimatedOpacity(
              opacity: isActive ? 1.0 : 0.45,
              duration: const Duration(milliseconds: 250),
              child: _buildHeroCard(context, movie),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeroCard(BuildContext context, Movie movie) {
    return GestureDetector(
      onTap: () => _navigateToDetails(context, movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // Faint watermark title behind the poster
            Positioned(
              top: 44,
              child: Text(
                movie.title,
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.06),
                  fontSize: 64,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ),

            // Script "Available Now"
            Text(
              'Available Now',
              style: GoogleFonts.greatVibes(
                color: Colors.white,
                fontSize: 30,
              ),
            ),

            // Poster card
            Positioned(
              top: 56,
              left: 0,
              right: 0,
              child: SizedBox(
                height: (MediaQuery.of(context).size.height * 0.55 * 0.62)
                    .clamp(220.0, 340.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      movie.backgroundImage.isNotEmpty
                          ? Image.network(
                        movie.backgroundImage,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Container(color: AppColor.gray),
                      )
                          : Container(color: AppColor.gray),

                      // Bottom gradient + tagline
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.85),
                              ],
                            ),
                          ),
                          child: const Text(
                            'TIME IS THE ENEMY',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                              letterSpacing: 3,
                            ),
                          ),
                        ),
                      ),

                      // Rating badge
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                movie.rating.toStringAsFixed(1),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 2),
                              const Icon(Icons.star,
                                  color: AppColor.yellow, size: 12),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Script "Watch Now" (tappable)
            Positioned(
              bottom: 0,
              child: GestureDetector(
                onTap: () => _navigateToDetails(context, movie),
                child: Text(
                  'Watch Now',
                  style: GoogleFonts.greatVibes(
                    color: Colors.white,
                    fontSize: 38,
                  ),
                ),
              ),
            ),
          ],
        ),
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
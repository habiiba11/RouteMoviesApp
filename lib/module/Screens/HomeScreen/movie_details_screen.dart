import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Core/Asset/Theme/AppColor.dart';
import '../../../bloc/details/movie_details_bloc.dart';
import '../../../bloc/details/movie_details_event.dart';
import '../../../bloc/details/movie_details_state.dart';
import '../../../bloc/history/history_bloc.dart';
import '../../../bloc/history/history_event.dart';
import '../../../bloc/watchlist/watchlist_bloc.dart';
import '../../../bloc/watchlist/watchlist_event.dart';
import '../../../bloc/watchlist/watchlist_state.dart';
import '../../../models/movie.dart';
import '../../../models/movie_details.dart';
import '../widgets/movie_card.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Record visit to History
    context.read<HistoryBloc>().add(RecordMovieVisit(widget.movie));

    // Fetch details & suggestions if movie has an id
    if (widget.movie.id > 0) {
      context.read<MovieDetailsBloc>().add(LoadMovieDetails(widget.movie.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;
    final size = MediaQuery.of(context).size;
    final backdropHeight = (size.height * 0.42).clamp(280.0, 480.0);

    return Scaffold(
      backgroundColor: AppColor.black,
      body: CustomScrollView(
        slivers: [
          // App Bar with Backdrop Image
          SliverAppBar(
            expandedHeight: backdropHeight,
            pinned: true,
            backgroundColor: AppColor.black,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              // Watchlist Favorite Icon
              BlocBuilder<WatchlistBloc, WatchlistState>(
                builder: (context, state) {
                  final isFav = state is WatchlistLoaded && state.isFavorite(movie.id);

                  return IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFav ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                        color: isFav ? AppColor.yellow : Colors.white,
                        size: 22,
                      ),
                    ),
                    onPressed: () {
                      context.read<WatchlistBloc>().add(ToggleWatchlist(movie));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 1),
                          backgroundColor: AppColor.gray,
                          content: Text(
                            isFav
                                ? 'Removed from Watch List'
                                : 'Added to Watch List',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  movie.backgroundImage.isNotEmpty
                      ? Image.network(
                          movie.backgroundImage,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(color: AppColor.gray),
                        )
                      : Container(color: AppColor.gray),

                  // Dark gradient overlay
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0x66000000),
                          Colors.transparent,
                          AppColor.black,
                        ],
                        stops: [0.0, 0.4, 1.0],
                      ),
                    ),
                  ),

                  // Play Button Icon in Center
                  Center(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColor.yellow.withOpacity(0.9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.yellow.withOpacity(0.4),
                            blurRadius: 16,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.play_arrow_rounded, color: Colors.black, size: 36),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content body
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Rating, Year, Runtime
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColor.yellow.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColor.yellow, width: 0.8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star_rounded, color: AppColor.yellow, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              movie.rating > 0 ? movie.rating.toStringAsFixed(1) : 'N/A',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (movie.year > 0) ...[
                        const SizedBox(width: 12),
                        Text(
                          movie.year.toString(),
                          style: const TextStyle(color: AppColor.textMuted, fontSize: 14),
                        ),
                      ],
                      if (movie.runtime > 0) ...[
                        const SizedBox(width: 12),
                        Text(
                          '${movie.runtime} min',
                          style: const TextStyle(color: AppColor.textMuted, fontSize: 14),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Genres Chips
                  if (movie.genres.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: movie.genres.map((g) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF282A28),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white12),
                          ),
                          child: Text(
                            g,
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        );
                      }).toList(),
                    ),

                  const SizedBox(height: 20),

                  // Description / Summary
                  const Text(
                    'Overview',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.descriptionFull.isNotEmpty
                        ? movie.descriptionFull
                        : (movie.summary.isNotEmpty
                            ? movie.summary
                            : 'No summary available for this movie.'),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Bloc builder for Cast, Screenshots & Suggestions
                  BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
                    builder: (context, state) {
                      if (state is MovieDetailsLoading) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(24),
                            child: CircularProgressIndicator(color: AppColor.yellow),
                          ),
                        );
                      } else if (state is MovieDetailsLoaded) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Cast Section
                            if (state.details.cast.isNotEmpty) ...[
                              const Text(
                                'Cast',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              _buildCastList(state.details.cast),
                              const SizedBox(height: 24),
                            ],

                            // Screenshots Section
                            if (state.details.screenshots.isNotEmpty) ...[
                              const Text(
                                'Screenshots',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              _buildScreenshotsList(state.details.screenshots),
                              const SizedBox(height: 24),
                            ],

                            // Similar / Suggested Movies
                            if (state.suggestions.isNotEmpty) ...[
                              const Text(
                                'Similar Movies',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              _buildSuggestionsList(context, state.suggestions),
                              const SizedBox(height: 32),
                            ],
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCastList(List<CastMember> cast) {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: cast.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final member = cast[index];
          return SizedBox(
            width: 72,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColor.gray,
                  backgroundImage: member.profilePhoto.isNotEmpty
                      ? NetworkImage(member.profilePhoto)
                      : null,
                  child: member.profilePhoto.isEmpty
                      ? const Icon(Icons.person, color: AppColor.textMuted)
                      : null,
                ),
                const SizedBox(height: 6),
                Text(
                  member.name,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white70, fontSize: 11),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildScreenshotsList(List<String> screenshots) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: screenshots.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              screenshots[index],
              width: 180,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 180,
                color: AppColor.gray,
                child: const Icon(Icons.broken_image, color: AppColor.textMuted),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSuggestionsList(BuildContext context, List<Movie> suggestions) {
    return SizedBox(
      height: 195,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: suggestions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final movie = suggestions[index];
          return MovieCard(
            movie: movie,
            width: 120,
            height: 190,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MovieDetailsScreen(movie: movie),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../models/movie.dart';
import 'movie_card.dart';

class ResponsiveMovieGrid extends StatelessWidget {
  final List<Movie> movies;
  final void Function(Movie movie)? onMovieTap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry padding;

  const ResponsiveMovieGrid({
    super.key,
    required this.movies,
    this.onMovieTap,
    this.physics,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        int crossAxisCount;
        if (width >= 1200) {
          crossAxisCount = 6;
        } else if (width >= 900) {
          crossAxisCount = 5;
        } else if (width >= 600) {
          crossAxisCount = 4;
        } else if (width >= 380) {
          crossAxisCount = 3;
        } else {
          crossAxisCount = 2;
        }

        return GridView.builder(
          padding: padding,
          physics: physics,
          shrinkWrap: physics is NeverScrollableScrollPhysics,
          itemCount: movies.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 12,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            final movie = movies[index];
            return MovieCard(
              movie: movie,
              onTap: () => onMovieTap?.call(movie),
            );
          },
        );
      },
    );
  }
}

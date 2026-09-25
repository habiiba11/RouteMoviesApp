import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieGrid extends StatelessWidget {
  final List<Movie> movies;
  final void Function(Movie)? onTap;

  const MovieGrid({super.key, required this.movies, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: movies.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.68,
      ),
      itemBuilder: (context, index) {
        final movie = movies[index];
        return GestureDetector(
          onTap: () => onTap?.call(movie),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              movie.posterUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey.shade800,
                child: const Icon(Icons.movie, color: Colors.white38),
              ),
            ),
          ),
        );
      },
    );
  }
}
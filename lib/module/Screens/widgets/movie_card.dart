import 'package:flutter/material.dart';
import '../../../Core/Asset/Theme/AppColor.dart';
import '../../../models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final bool showRating;

  const MovieCard({
    super.key,
    required this.movie,
    this.onTap,
    this.width,
    this.height,
    this.showRating = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColor.gray,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Poster Image
            _buildPosterImage(),

            // Gradient overlay at bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 60,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black87,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Rating Badge (Top Left)
            if (showRating && movie.rating > 0)
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColor.yellow.withOpacity(0.4), width: 0.5),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star_rounded, color: AppColor.yellow, size: 14),
                      const SizedBox(width: 3),
                      Text(
                        movie.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Title & Year (Bottom)
            Positioned(
              left: 8,
              right: 8,
              bottom: 6,
              child: Text(
                movie.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPosterImage() {
    final url = movie.mediumCoverImage.isNotEmpty
        ? movie.mediumCoverImage
        : (movie.largeCoverImage.isNotEmpty ? movie.largeCoverImage : movie.posterUrl);

    if (url.startsWith('http')) {
      return Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildPlaceholder(),
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColor.yellow.withOpacity(0.7),
              ),
            ),
          );
        },
      );
    } else if (url.isNotEmpty) {
      return Image.asset(
        url,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildPlaceholder(),
      );
    }
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColor.gray,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.movie_outlined, color: AppColor.textMuted, size: 32),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                movie.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: AppColor.textMuted, fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

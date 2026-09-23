import 'package:flutter/material.dart';
import '/models/movie.dart';
import '/theme.dart';
import '/widgets/movie_grid.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  final List<String> _genres = ['Action', 'Adventure', 'Animation', 'Comedy', 'Drama'];
  String _selected = 'Action';

  @override
  Widget build(BuildContext context) {
    final filtered =
    dummyMovies.where((m) => m.genres.contains(_selected)).toList();
    final movies = filtered.isEmpty ? dummyMovies : filtered;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Browse',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _genres.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final genre = _genres[index];
                final isSelected = genre == _selected;
                return ChoiceChip(
                  label: Text(genre),
                  selected: isSelected,
                  onSelected: (_) => setState(() => _selected = genre),
                  selectedColor: AppColors.accent,
                  backgroundColor: const Color(0xFF1F1F1F),
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.black : Colors.white70,
                    fontWeight: FontWeight.w600,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(child: MovieGrid(movies: movies)),
        ],
      ),
    );
  }
}
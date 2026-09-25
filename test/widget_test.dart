import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:routemovie/models/movie.dart';
import 'package:routemovie/module/Screens/MainNavigation/widgets/custom_bottom_nav_bar.dart';

void main() {
  group('Movie Model & Logic Tests', () {
    test('Movie fromJson and toJson serialization', () {
      final jsonMap = {
        'id': 12345,
        'title': 'Inception',
        'year': 2010,
        'rating': 8.8,
        'runtime': 148,
        'genres': ['Action', 'Sci-Fi', 'Thriller'],
        'summary': 'A mind-bending thriller.',
        'description_full': 'Full description of Inception.',
        'medium_cover_image': 'https://example.com/poster.jpg',
        'background_image': 'https://example.com/bg.jpg',
      };

      final movie = Movie.fromJson(jsonMap);

      expect(movie.id, 12345);
      expect(movie.title, 'Inception');
      expect(movie.rating, 8.8);
      expect(movie.genres.length, 3);
      expect(movie.posterUrl, 'https://example.com/poster.jpg');

      final serialized = movie.toJson();
      expect(serialized['title'], 'Inception');
      expect(serialized['rating'], 8.8);
    });

    test('Genre deduplication using Set<String>', () {
      final movies = [
        const Movie(title: 'Movie 1', genres: ['Action', 'Adventure']),
        const Movie(title: 'Movie 2', genres: ['Action', 'Comedy']),
        const Movie(title: 'Movie 3', genres: ['Adventure', 'Drama']),
      ];

      // Loop on the movie list and get all genres and save it to Set to remove duplicates
      final Set<String> genresSet = <String>{};
      for (final movie in movies) {
        genresSet.addAll(movie.genres);
      }

      // Verify no duplicates
      expect(genresSet.length, 4);
      expect(genresSet.contains('Action'), true);
      expect(genresSet.contains('Adventure'), true);
      expect(genresSet.contains('Comedy'), true);
      expect(genresSet.contains('Drama'), true);

      // Verify filtering for each tab
      final actionMovies = movies.where((m) => m.genres.contains('Action')).toList();
      expect(actionMovies.length, 2);

      final comedyMovies = movies.where((m) => m.genres.contains('Comedy')).toList();
      expect(comedyMovies.length, 1);
    });
  });

  group('Navigation Bar Widget Tests', () {
    testWidgets('CustomBottomNavBar displays all 4 tabs and responds to tap', (tester) async {
      int selectedIndex = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: CustomBottomNavBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                selectedIndex = index;
              },
            ),
          ),
        ),
      );

      // Verify icons exist
      expect(find.byIcon(Icons.home_rounded), findsOneWidget);
      expect(find.byIcon(Icons.search_rounded), findsOneWidget);
      expect(find.byIcon(Icons.explore_rounded), findsOneWidget);
      expect(find.byIcon(Icons.person_rounded), findsOneWidget);

      // Tap on search tab (index 1)
      await tester.tap(find.byIcon(Icons.search_rounded));
      await tester.pumpAndSettle();

      expect(selectedIndex, 1);
    });
  });
}

import '../Core/Services/local_storage_service.dart';
import '../Core/Services/yts_api_service.dart';
import '../models/movie.dart';
import '../models/movie_details.dart';

class MovieRepository {
  final YtsApiService _apiService;
  final LocalStorageService _storageService;

  MovieRepository({
    required YtsApiService apiService,
    required LocalStorageService storageService,
  })  : _apiService = apiService,
        _storageService = storageService;

  // Curated sample movies matching the design
  static const List<Movie> sampleFeaturedMovies = [
    Movie(
      id: 101,
      title: 'Baby Driver',
      year: 2017,
      rating: 7.7,
      runtime: 113,
      genres: ['Action', 'Crime'],
      summary: 'After being coerced into working for a crime boss, a young getaway driver finds himself taking part in a heist doomed to fail.',
      mediumCoverImage: 'https://image.tmdb.org/t/p/w500/rmnQ9jKW72bHu8ZKlZvTGb2neAe.jpg',
      largeCoverImage: 'https://image.tmdb.org/t/p/w780/rmnQ9jKW72bHu8ZKlZvTGb2neAe.jpg',
      backgroundImage: 'https://image.tmdb.org/t/p/original/rmnQ9jKW72bHu8ZKlZvTGb2neAe.jpg',
    ),
    Movie(
      id: 102,
      title: '1917',
      year: 2019,
      rating: 7.7,
      runtime: 119,
      genres: ['Action', 'Drama', 'War'],
      summary: 'April 6th, 1917. As an entire regiment marches towards a tactical trap, two British soldiers are tasked with delivering an impossible message to save 1,600 men.',
      mediumCoverImage: 'https://image.tmdb.org/t/p/w500/iZf0KyrE25z1sage4SYFLCCrMi9.jpg',
      largeCoverImage: 'https://image.tmdb.org/t/p/w780/iZf0KyrE25z1sage4SYFLCCrMi9.jpg',
      backgroundImage: 'https://image.tmdb.org/t/p/original/AuGiPiGMYMkSosOJ3bq7CcAJnvO.jpg',
    ),
    Movie(
      id: 103,
      title: 'Captain America: The First Avenger',
      year: 2011,
      rating: 7.7,
      runtime: 124,
      genres: ['Action', 'Adventure', 'Sci-Fi'],
      summary: 'Steve Rogers, a rejected military soldier, transforms into Captain America after taking a dose of a Super-Soldier serum.',
      mediumCoverImage: 'Asset/AppImage/film2.png',
      largeCoverImage: 'Asset/AppImage/film2.png',
      backgroundImage: 'Asset/AppImage/film2.png',
    ),
  ];

  static const List<Movie> sampleActionMovies = [
    Movie(
      id: 201,
      title: 'Captain America: The First Avenger',
      year: 2011,
      rating: 7.7,
      runtime: 124,
      genres: ['Action', 'Adventure'],
      mediumCoverImage: 'Asset/AppImage/film2.png',
      largeCoverImage: 'Asset/AppImage/film2.png',
      backgroundImage: 'Asset/AppImage/film2.png',
    ),
    Movie(
      id: 202,
      title: 'The Dark Knight',
      year: 2008,
      rating: 7.7,
      runtime: 152,
      genres: ['Action', 'Crime', 'Drama'],
      summary: 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests.',
      mediumCoverImage: 'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
      largeCoverImage: 'https://image.tmdb.org/t/p/w780/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
      backgroundImage: 'https://image.tmdb.org/t/p/original/nMKdUUepR0i5zn0y1T4CsSB5chy.jpg',
    ),
    Movie(
      id: 203,
      title: 'Black Widow',
      year: 2021,
      rating: 7.7,
      runtime: 134,
      genres: ['Action', 'Adventure', 'Sci-Fi'],
      mediumCoverImage: 'Asset/AppImage/film1.png',
      largeCoverImage: 'Asset/AppImage/film1.png',
      backgroundImage: 'Asset/AppImage/film1.png',
    ),
    Movie(
      id: 204,
      title: 'Avengers: Endgame',
      year: 2019,
      rating: 8.4,
      runtime: 181,
      genres: ['Action', 'Adventure', 'Drama'],
      mediumCoverImage: 'Asset/AppImage/film3.png',
      largeCoverImage: 'Asset/AppImage/film3.png',
      backgroundImage: 'Asset/AppImage/film3.png',
    ),
    Movie(
      id: 205,
      title: 'Captain America: Civil War',
      year: 2016,
      rating: 7.8,
      runtime: 147,
      genres: ['Action', 'Sci-Fi'],
      mediumCoverImage: 'Asset/AppImage/film4.png',
      largeCoverImage: 'Asset/AppImage/film4.png',
      backgroundImage: 'Asset/AppImage/film4.png',
    ),
  ];

  // --- Home Tab Data ---

  Future<List<Movie>> getFeaturedMovies() async {
    try {
      final list = await _apiService.fetchMovies(limit: 5, sortBy: 'like_count', orderBy: 'desc');
      return list.isNotEmpty ? list : sampleFeaturedMovies;
    } catch (_) {
      return sampleFeaturedMovies;
    }
  }

  Future<List<Movie>> getPopularMovies() async {
    try {
      final list = await _apiService.fetchMovies(limit: 15, genre: 'Action', sortBy: 'download_count', orderBy: 'desc');
      return list.isNotEmpty ? list : sampleActionMovies;
    } catch (_) {
      return sampleActionMovies;
    }
  }

  // --- Search Tab Data ---

  Future<List<Movie>> searchMovies(String query) async {
    return _apiService.fetchMovies(queryTerm: query, limit: 30);
  }

  // --- Browse Tab Data ---

  Future<List<Movie>> getMoviesForBrowse({String? genre}) async {
    return _apiService.fetchMovies(
      genre: genre,
      limit: 40,
      sortBy: 'rating',
      orderBy: 'desc',
    );
  }

  // --- Details & Suggestions ---

  Future<MovieDetails> getMovieDetails(int movieId) async {
    return _apiService.fetchMovieDetails(movieId);
  }

  Future<List<Movie>> getMovieSuggestions(int movieId) async {
    return _apiService.fetchMovieSuggestions(movieId);
  }

  // --- Watchlist (Favorites) Local Storage ---

  List<Movie> getWatchlist() => _storageService.getWatchlist();

  Future<bool> addToWatchlist(Movie movie) => _storageService.addToWatchlist(movie);

  Future<bool> removeFromWatchlist(int movieId) => _storageService.removeFromWatchlist(movieId);

  bool isInWatchlist(int movieId) => _storageService.isInWatchlist(movieId);

  // --- History Local Storage ---

  List<Movie> getHistory() => _storageService.getHistory();

  Future<bool> addToHistory(Movie movie) => _storageService.addToHistory(movie);

  Future<bool> clearHistory() => _storageService.clearHistory();
}
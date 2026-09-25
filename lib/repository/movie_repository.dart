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

  // --- Home Tab Data ---

  Future<List<Movie>> getFeaturedMovies() async {
    return _apiService.fetchMovies(limit: 5, sortBy: 'like_count', orderBy: 'desc');
  }

  Future<List<Movie>> getPopularMovies() async {
    return _apiService.fetchMovies(limit: 15, sortBy: 'download_count', orderBy: 'desc');
  }

  Future<List<Movie>> getTopRatedMovies() async {
    return _apiService.fetchMovies(limit: 15, sortBy: 'rating', orderBy: 'desc');
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

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/movie.dart';

class LocalStorageService {
  static const String _watchlistKey = 'user_watchlist_movies';
  static const String _historyKey = 'user_history_movies';

  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  static Future<LocalStorageService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return LocalStorageService(prefs);
  }

  // --- Watchlist (Favorites) ---

  List<Movie> getWatchlist() {
    final raw = _prefs.getStringList(_watchlistKey);
    if (raw == null) return [];
    try {
      return raw.map((item) => Movie.fromJson(json.decode(item))).toList();
    } catch (_) {
      return [];
    }
  }

  Future<bool> addToWatchlist(Movie movie) async {
    final list = getWatchlist();
    if (!list.any((m) => m.id == movie.id)) {
      list.insert(0, movie);
      return _saveWatchlist(list);
    }
    return true;
  }

  Future<bool> removeFromWatchlist(int movieId) async {
    final list = getWatchlist();
    list.removeWhere((m) => m.id == movieId);
    return _saveWatchlist(list);
  }

  bool isInWatchlist(int movieId) {
    final list = getWatchlist();
    return list.any((m) => m.id == movieId);
  }

  Future<bool> _saveWatchlist(List<Movie> movies) {
    final raw = movies.map((m) => json.encode(m.toJson())).toList();
    return _prefs.setStringList(_watchlistKey, raw);
  }

  // --- History (Visited Movies) ---

  List<Movie> getHistory() {
    final raw = _prefs.getStringList(_historyKey);
    if (raw == null) return [];
    try {
      return raw.map((item) => Movie.fromJson(json.decode(item))).toList();
    } catch (_) {
      return [];
    }
  }

  Future<bool> addToHistory(Movie movie) async {
    final list = getHistory();
    // Remove if already in history so we can push to front
    list.removeWhere((m) => m.id == movie.id);
    list.insert(0, movie);
    // Keep max 50 recent items
    if (list.length > 50) {
      list.removeRange(50, list.length);
    }
    final raw = list.map((m) => json.encode(m.toJson())).toList();
    return _prefs.setStringList(_historyKey, raw);
  }

  Future<bool> clearHistory() {
    return _prefs.remove(_historyKey);
  }
}

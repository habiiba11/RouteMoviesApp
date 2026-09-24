import '../../models/movie.dart';

abstract class WatchlistState {}

class WatchlistInitial extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistLoaded extends WatchlistState {
  final List<Movie> movies;
  WatchlistLoaded(this.movies);

  bool isFavorite(int movieId) {
    return movies.any((m) => m.id == movieId);
  }
}

import '../../models/movie.dart';

abstract class WatchlistEvent {}

class LoadWatchlist extends WatchlistEvent {}

class ToggleWatchlist extends WatchlistEvent {
  final Movie movie;
  ToggleWatchlist(this.movie);
}

class RemoveFromWatchlist extends WatchlistEvent {
  final int movieId;
  RemoveFromWatchlist(this.movieId);
}

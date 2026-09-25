import '../../models/movie.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<Movie> movies;
  HistoryLoaded(this.movies);
}

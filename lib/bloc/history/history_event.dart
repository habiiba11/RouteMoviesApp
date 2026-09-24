import '../../models/movie.dart';

abstract class HistoryEvent {}

class LoadHistory extends HistoryEvent {}

class RecordMovieVisit extends HistoryEvent {
  final Movie movie;
  RecordMovieVisit(this.movie);
}

class ClearHistory extends HistoryEvent {}

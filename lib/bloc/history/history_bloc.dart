import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/movie_repository.dart';
import 'history_event.dart';
import 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final MovieRepository _repository;

  HistoryBloc({required MovieRepository repository})
      : _repository = repository,
        super(HistoryInitial()) {
    on<LoadHistory>(_onLoadHistory);
    on<RecordMovieVisit>(_onRecordMovieVisit);
    on<ClearHistory>(_onClearHistory);
  }

  void _onLoadHistory(LoadHistory event, Emitter<HistoryState> emit) {
    final movies = _repository.getHistory();
    emit(HistoryLoaded(movies));
  }

  Future<void> _onRecordMovieVisit(
    RecordMovieVisit event,
    Emitter<HistoryState> emit,
  ) async {
    await _repository.addToHistory(event.movie);
    final updated = _repository.getHistory();
    emit(HistoryLoaded(updated));
  }

  Future<void> _onClearHistory(
    ClearHistory event,
    Emitter<HistoryState> emit,
  ) async {
    await _repository.clearHistory();
    emit(HistoryLoaded(const []));
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/movie_repository.dart';
import 'watchlist_event.dart';
import 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final MovieRepository _repository;

  WatchlistBloc({required MovieRepository repository})
      : _repository = repository,
        super(WatchlistInitial()) {
    on<LoadWatchlist>(_onLoadWatchlist);
    on<ToggleWatchlist>(_onToggleWatchlist);
    on<RemoveFromWatchlist>(_onRemoveFromWatchlist);
  }

  void _onLoadWatchlist(LoadWatchlist event, Emitter<WatchlistState> emit) {
    final movies = _repository.getWatchlist();
    emit(WatchlistLoaded(movies));
  }

  Future<void> _onToggleWatchlist(
    ToggleWatchlist event,
    Emitter<WatchlistState> emit,
  ) async {
    final movie = event.movie;
    final isFav = _repository.isInWatchlist(movie.id);
    if (isFav) {
      await _repository.removeFromWatchlist(movie.id);
    } else {
      await _repository.addToWatchlist(movie);
    }
    final updated = _repository.getWatchlist();
    emit(WatchlistLoaded(updated));
  }

  Future<void> _onRemoveFromWatchlist(
    RemoveFromWatchlist event,
    Emitter<WatchlistState> emit,
  ) async {
    await _repository.removeFromWatchlist(event.movieId);
    final updated = _repository.getWatchlist();
    emit(WatchlistLoaded(updated));
  }
}

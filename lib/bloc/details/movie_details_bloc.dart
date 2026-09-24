import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/movie_repository.dart';
import 'movie_details_event.dart';
import 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final MovieRepository _repository;

  MovieDetailsBloc({required MovieRepository repository})
      : _repository = repository,
        super(MovieDetailsInitial()) {
    on<LoadMovieDetails>(_onLoadMovieDetails);
  }

  Future<void> _onLoadMovieDetails(
    LoadMovieDetails event,
    Emitter<MovieDetailsState> emit,
  ) async {
    emit(MovieDetailsLoading());
    try {
      final results = await Future.wait([
        _repository.getMovieDetails(event.movieId),
        _repository.getMovieSuggestions(event.movieId),
      ]);

      final details = results[0];
      final suggestions = results[1];

      emit(MovieDetailsLoaded(
        details: details as dynamic,
        suggestions: suggestions as dynamic,
      ));
    } catch (e) {
      emit(MovieDetailsError(e.toString()));
    }
  }
}

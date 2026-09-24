import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/movie.dart';
import '../../repository/movie_repository.dart';
import 'browse_event.dart';
import 'browse_state.dart';

class BrowseBloc extends Bloc<BrowseEvent, BrowseState> {
  final MovieRepository _repository;

  BrowseBloc({required MovieRepository repository})
      : _repository = repository,
        super(BrowseInitial()) {
    on<FetchBrowseMovies>(_onFetchBrowseMovies);
    on<SelectGenre>(_onSelectGenre);
  }

  Future<void> _onFetchBrowseMovies(
    FetchBrowseMovies event,
    Emitter<BrowseState> emit,
  ) async {
    emit(BrowseLoading());
    try {
      final movies = await _repository.getMoviesForBrowse();

      // Loop on the movie list and get all genres and save it to Set to remove duplicates
      final Set<String> genresSet = <String>{};
      for (final movie in movies) {
        for (final genre in movie.genres) {
          final clean = genre.trim();
          if (clean.isNotEmpty) {
            genresSet.add(clean);
          }
        }
      }

      // Default fallback if no genres returned
      if (genresSet.isEmpty) {
        genresSet.addAll(['Action', 'Adventure', 'Animation', 'Comedy', 'Drama', 'Fantasy', 'Sci-Fi']);
      }

      final selectedGenre = genresSet.first;
      final filteredMovies = movies
          .where((m) => m.genres.any((g) => g.toLowerCase() == selectedGenre.toLowerCase()))
          .toList();

      emit(BrowseLoaded(
        allMovies: movies,
        genresSet: genresSet,
        selectedGenre: selectedGenre,
        filteredMovies: filteredMovies.isNotEmpty ? filteredMovies : movies,
      ));
    } catch (e) {
      emit(BrowseError(e.toString()));
    }
  }

  Future<void> _onSelectGenre(
    SelectGenre event,
    Emitter<BrowseState> emit,
  ) async {
    if (state is BrowseLoaded) {
      final current = state as BrowseLoaded;
      final genre = event.genre;

      var filtered = current.allMovies
          .where((m) => m.genres.any((g) => g.toLowerCase() == genre.toLowerCase()))
          .toList();

      if (filtered.isEmpty) {
        // If not in local pool, fetch movies for this specific genre from API
        try {
          final apiMovies = await _repository.getMoviesForBrowse(genre: genre);
          if (apiMovies.isNotEmpty) {
            filtered = apiMovies;
          }
        } catch (_) {}
      }

      emit(current.copyWith(
        selectedGenre: genre,
        filteredMovies: filtered,
      ));
    }
  }
}

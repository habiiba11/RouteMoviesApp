import '../../models/movie.dart';

abstract class BrowseState {}

class BrowseInitial extends BrowseState {}

class BrowseLoading extends BrowseState {}

class BrowseLoaded extends BrowseState {
  final List<Movie> allMovies;
  final Set<String> genresSet;
  final String selectedGenre;
  final List<Movie> filteredMovies;

  BrowseLoaded({
    required this.allMovies,
    required this.genresSet,
    required this.selectedGenre,
    required this.filteredMovies,
  });

  BrowseLoaded copyWith({
    List<Movie>? allMovies,
    Set<String>? genresSet,
    String? selectedGenre,
    List<Movie>? filteredMovies,
  }) {
    return BrowseLoaded(
      allMovies: allMovies ?? this.allMovies,
      genresSet: genresSet ?? this.genresSet,
      selectedGenre: selectedGenre ?? this.selectedGenre,
      filteredMovies: filteredMovies ?? this.filteredMovies,
    );
  }
}

class BrowseError extends BrowseState {
  final String message;
  BrowseError(this.message);
}

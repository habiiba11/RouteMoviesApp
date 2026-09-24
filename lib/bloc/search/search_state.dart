import '../../models/movie.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Movie> movies;
  final String query;

  SearchLoaded({required this.movies, required this.query});
}

class SearchEmpty extends SearchState {
  final String query;
  SearchEmpty(this.query);
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}

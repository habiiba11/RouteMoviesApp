import '../../models/movie.dart';
import '../../models/movie_details.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsLoaded extends MovieDetailsState {
  final MovieDetails details;
  final List<Movie> suggestions;

  MovieDetailsLoaded({
    required this.details,
    required this.suggestions,
  });
}

class MovieDetailsError extends MovieDetailsState {
  final String message;
  MovieDetailsError(this.message);
}

abstract class MovieDetailsEvent {}

class LoadMovieDetails extends MovieDetailsEvent {
  final int movieId;
  LoadMovieDetails(this.movieId);
}

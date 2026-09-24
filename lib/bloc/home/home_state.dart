import '../../models/movie.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Movie> featuredMovies;
  final List<Movie> popularMovies;
  final List<Movie> topRatedMovies;

  HomeLoaded({
    required this.featuredMovies,
    required this.popularMovies,
    required this.topRatedMovies,
  });
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

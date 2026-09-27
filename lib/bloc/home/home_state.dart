import '../../models/movie.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Movie> featuredMovies;
  final List<Movie> popularMovies;

  HomeLoaded({
    required this.featuredMovies,
    required this.popularMovies,
  });
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
import '../models/movie.dart';

final List<Movie> historyMovies = [
  Movie(
    id: 1,
    title: '1917',
    rating: 7.7,
    mediumCoverImage: 'Assets/AppImage/917.jpg',
    genres: ['Action', 'Drama', 'War'],
  ),
  Movie(
    id: 2,
    title: 'Hobbs & Shaw',
    rating: 7.7,
    mediumCoverImage: 'Assets/AppImage/hobbs.jpg',
    genres: ['Action', 'Adventure'],
  ),
  Movie(
    id: 3,
    title: 'Black Widow',
    rating: 7.7,
    mediumCoverImage: 'Assets/AppImage/widow1.jpg',
    genres: ['Action', 'Sci-Fi'],
  ),
  Movie(
    id: 4,
    title: 'The Avengers',
    rating: 7.7,
    mediumCoverImage: 'Assets/AppImage/avengers.jpg',
    genres: ['Action', 'Sci-Fi'],
  ),
  Movie(
    id: 5,
    title: 'Black Panther',
    rating: 7.7,
    mediumCoverImage: 'Assets/AppImage/panther.jpg',
    genres: ['Action', 'Adventure'],
  ),
];

final List<Movie> dummyMovies = historyMovies;

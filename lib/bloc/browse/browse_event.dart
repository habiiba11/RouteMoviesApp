abstract class BrowseEvent {}

class FetchBrowseMovies extends BrowseEvent {}

class SelectGenre extends BrowseEvent {
  final String genre;
  SelectGenre(this.genre);
}

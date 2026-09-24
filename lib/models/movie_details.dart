import 'movie.dart';

class CastMember {
  final String name;
  final String characterName;
  final String profilePhoto;
  final String imdbCode;

  const CastMember({
    required this.name,
    this.characterName = '',
    this.profilePhoto = '',
    this.imdbCode = '',
  });

  factory CastMember.fromJson(Map<String, dynamic> json) {
    return CastMember(
      name: json['name']?.toString() ?? '',
      characterName: json['character_name']?.toString() ?? '',
      profilePhoto: json['url_small_image']?.toString() ?? '',
      imdbCode: json['imdb_code']?.toString() ?? '',
    );
  }
}

class MovieDetails {
  final Movie movie;
  final int likeCount;
  final String trailerCode;
  final List<String> screenshots;
  final List<CastMember> cast;

  const MovieDetails({
    required this.movie,
    this.likeCount = 0,
    this.trailerCode = '',
    this.screenshots = const [],
    this.cast = const [],
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    final movieObj = Movie.fromJson(json);

    List<String> screenshots = [];
    for (int i = 1; i <= 3; i++) {
      final shot = json['large_screenshot_image$i']?.toString() ??
          json['medium_screenshot_image$i']?.toString();
      if (shot != null && shot.isNotEmpty) {
        screenshots.add(shot);
      }
    }

    List<CastMember> castList = [];
    if (json['cast'] is List) {
      castList = (json['cast'] as List)
          .map((c) => CastMember.fromJson(c as Map<String, dynamic>))
          .toList();
    }

    return MovieDetails(
      movie: movieObj,
      likeCount: json['like_count'] is int
          ? json['like_count']
          : int.tryParse(json['like_count']?.toString() ?? '0') ?? 0,
      trailerCode: json['yt_trailer_code']?.toString() ?? '',
      screenshots: screenshots,
      cast: castList,
    );
  }
}

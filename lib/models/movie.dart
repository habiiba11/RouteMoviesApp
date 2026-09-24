class Movie {
  final int id;
  final String title;
  final int year;
  final double rating;
  final int runtime;
  final List<String> genres;
  final String summary;
  final String descriptionFull;
  final String mediumCoverImage;
  final String largeCoverImage;
  final String backgroundImage;

  // Backward compatibility getters & fields
  String get posterUrl => mediumCoverImage.isNotEmpty ? mediumCoverImage : largeCoverImage;
  String get image => posterUrl;
  String get ratingString => rating.toString();

  const Movie({
    this.id = 0,
    required this.title,
    this.year = 0,
    this.rating = 0.0,
    this.runtime = 0,
    this.genres = const [],
    this.summary = '',
    this.descriptionFull = '',
    this.mediumCoverImage = '',
    this.largeCoverImage = '',
    this.backgroundImage = '',
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    var rawGenres = json['genres'];
    List<String> parsedGenres = [];
    if (rawGenres is List) {
      parsedGenres = rawGenres.map((e) => e.toString()).toList();
    }

    double parsedRating = 0.0;
    if (json['rating'] != null) {
      if (json['rating'] is num) {
        parsedRating = (json['rating'] as num).toDouble();
      } else {
        parsedRating = double.tryParse(json['rating'].toString()) ?? 0.0;
      }
    }

    final coverMed = json['medium_cover_image']?.toString() ??
        json['posterUrl']?.toString() ??
        json['image']?.toString() ??
        '';

    final coverLg = json['large_cover_image']?.toString() ?? coverMed;

    return Movie(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      title: json['title']?.toString() ?? 'Unknown',
      year: json['year'] is int ? json['year'] : int.tryParse(json['year']?.toString() ?? '0') ?? 0,
      rating: parsedRating,
      runtime: json['runtime'] is int ? json['runtime'] : int.tryParse(json['runtime']?.toString() ?? '0') ?? 0,
      genres: parsedGenres,
      summary: json['summary']?.toString() ?? '',
      descriptionFull: json['description_full']?.toString() ?? json['summary']?.toString() ?? '',
      mediumCoverImage: coverMed,
      largeCoverImage: coverLg,
      backgroundImage: json['background_image_original']?.toString() ??
          json['background_image']?.toString() ??
          coverLg,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'year': year,
      'rating': rating,
      'runtime': runtime,
      'genres': genres,
      'summary': summary,
      'description_full': descriptionFull,
      'medium_cover_image': mediumCoverImage,
      'large_cover_image': largeCoverImage,
      'background_image': backgroundImage,
      'posterUrl': posterUrl,
      'image': image,
    };
  }

  // Legacy compatibility helpers
  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie.fromJson(map);
  }

  Map<String, dynamic> toMap() => toJson();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Movie &&
          runtimeType == other.runtimeType &&
          (id != 0 && other.id != 0 ? id == other.id : title == other.title);

  @override
  int get hashCode => id != 0 ? id.hashCode : title.hashCode;
}

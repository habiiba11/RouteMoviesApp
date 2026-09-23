class Movie {
  final String title;
  final String posterUrl;
  final String rating;
  final String image;

  Movie({required this.title, required this.rating, required this.image, required this.posterUrl});

  factory Movie.fromMap(Map<String, String> map) {
    return Movie(
      title: map['title']!,
      rating: map['rating']!,
      image: map['image']!,
    );
  }

  Map<String, String> toMap() {
    return {'title': title, 'rating': rating, 'image': image};
  }
}

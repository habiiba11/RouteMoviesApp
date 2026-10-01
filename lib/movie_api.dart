import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:routemovie/models/movie.dart';
import 'package:routemovie/models/movie_details.dart';

class MovieApi {
  static const _base = 'https://yts.am/api/v2';

  static Future<MovieDetails> details(int id) async {
    final res = await http.get(Uri.parse(
        '$_base/movie_details.json?movie_id=$id&with_images=true&with_cast=true'));
    if (res.statusCode != 200) throw Exception('Failed to load movie');
    return MovieDetails.fromJson(jsonDecode(res.body)['data']['movie']);
  }

  static Future<List<Movie>> suggestions(int id) async {
    final res = await http
        .get(Uri.parse('$_base/movie_suggestions.json?movie_id=$id'));
    if (res.statusCode != 200) throw Exception('Failed to load suggestions');
    final list = jsonDecode(res.body)['data']['movies'] as List? ?? [];
    return list.map((e) => Movie.fromJson(e)).toList();
  }
}
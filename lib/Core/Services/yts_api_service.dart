import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Network/api_constants.dart';
import '../../models/movie.dart';
import '../../models/movie_details.dart';

class YtsApiService {
  final http.Client _client;

  YtsApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<Movie>> fetchMovies({
    int page = 1,
    int limit = 20,
    String? queryTerm,
    String? genre,
    String? sortBy,
    String? orderBy,
  }) async {
    final queryParams = <String, String>{
      'page': page.toString(),
      'limit': limit.toString(),
    };

    if (queryTerm != null && queryTerm.trim().isNotEmpty) {
      queryParams['query_term'] = queryTerm.trim();
    }
    if (genre != null && genre.trim().isNotEmpty && genre != 'All') {
      queryParams['genre'] = genre.trim();
    }
    if (sortBy != null && sortBy.isNotEmpty) {
      queryParams['sort_by'] = sortBy;
    }
    if (orderBy != null && orderBy.isNotEmpty) {
      queryParams['order_by'] = orderBy;
    }

    final uri = Uri.parse(ApiConstants.listMoviesEndpoint)
        .replace(queryParameters: queryParams);

    final response = await _client.get(uri).timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'ok' && data['data'] != null) {
        final moviesJson = data['data']['movies'];
        if (moviesJson is List) {
          return moviesJson
              .map((m) => Movie.fromJson(m as Map<String, dynamic>))
              .toList();
        }
      }
      return [];
    } else {
      throw Exception('Failed to load movies: HTTP ${response.statusCode}');
    }
  }

  Future<MovieDetails> fetchMovieDetails(int movieId) async {
    final uri = Uri.parse(ApiConstants.movieDetailsEndpoint).replace(
      queryParameters: {
        'movie_id': movieId.toString(),
        'with_images': 'true',
        'with_cast': 'true',
      },
    );

    final response = await _client.get(uri).timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'ok' && data['data'] != null && data['data']['movie'] != null) {
        return MovieDetails.fromJson(data['data']['movie'] as Map<String, dynamic>);
      }
      throw Exception('Movie details not found');
    } else {
      throw Exception('Failed to load movie details: HTTP ${response.statusCode}');
    }
  }

  Future<List<Movie>> fetchMovieSuggestions(int movieId) async {
    final uri = Uri.parse(ApiConstants.movieSuggestionsEndpoint).replace(
      queryParameters: {'movie_id': movieId.toString()},
    );

    final response = await _client.get(uri).timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'ok' && data['data'] != null) {
        final moviesJson = data['data']['movies'];
        if (moviesJson is List) {
          return moviesJson
              .map((m) => Movie.fromJson(m as Map<String, dynamic>))
              .toList();
        }
      }
      return [];
    } else {
      throw Exception('Failed to load movie suggestions: HTTP ${response.statusCode}');
    }
  }
}

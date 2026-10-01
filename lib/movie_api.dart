import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieApi {
  static const _base = 'https://yts.mx/api/v2';

  static Future<Map<String, dynamic>> details(int id) async {
    final res = await http.get(Uri.parse(
        '$_base/movie_details.json?movie_id=$id&with_images=true&with_cast=true'));
    if (res.statusCode != 200) throw Exception('Failed to load movie');
    return jsonDecode(res.body)['data']['movie'];
  }

  static Future<List<dynamic>> suggestions(int id) async {
    final res = await http
        .get(Uri.parse('$_base/movie_suggestions.json?movie_id=$id'));
    if (res.statusCode != 200) throw Exception('Failed to load suggestions');
    return jsonDecode(res.body)['data']['movies'] ?? [];
  }
}
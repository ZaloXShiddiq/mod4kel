import 'dart:convert';
import 'package:http/http.dart' as http;

/// A simple service class for performing HTTP GET requests using the
/// `http` package.  It measures response times for educational
/// purposes and returns both the parsed data and the elapsed
/// milliseconds.
class ApiHttpService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  /// Fetches a single post from the JSONPlaceholder API and returns
  /// the parsed JSON along with the time taken to receive the
  /// response.  Throws an exception if the request fails.
  Future<Map<String, dynamic>> fetchPosts() async {
    final stopwatch = Stopwatch()..start();
    try {
      final response = await http.get(Uri.parse('$baseUrl/posts/1'));

      stopwatch.stop();
      // ignore: avoid_print
      print('[HTTP] Response time: ${stopwatch.elapsedMilliseconds} ms');

      if (response.statusCode == 200) {
        return {
          'data': jsonDecode(response.body),
          'time': stopwatch.elapsedMilliseconds,
        };
      } else {
        throw Exception('Failed to load data (status: ${response.statusCode})');
      }
    } catch (e) {
      stopwatch.stop();
      // ignore: avoid_print
      print('[HTTP] Error: $e');
      rethrow;
    }
  }
}
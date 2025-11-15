import 'package:dio/dio.dart';

/// A service class utilizing the Dio HTTP client to perform GET
/// requests.  The class sets sensible timeouts and logs requests and
/// responses for debugging purposes.
class ApiDioService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  ApiDioService() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // ignore: avoid_print
          print('[DIO] Request → ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // ignore: avoid_print
          print('[DIO] Response ← ${response.statusCode}');
          return handler.next(response);
        },
        onError: (e, handler) {
          // ignore: avoid_print
          print('[DIO] Error ✖ ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }

  /// Fetches a single post from the JSONPlaceholder API using Dio
  /// and returns both the parsed data and the time taken to receive
  /// the response.
  Future<Map<String, dynamic>> fetchPosts() async {
    final stopwatch = Stopwatch()..start();
    try {
      final response = await dio.get('/posts/1');
      stopwatch.stop();
      // ignore: avoid_print
      print('[DIO] Response time: ${stopwatch.elapsedMilliseconds} ms');
      return {
        'data': response.data,
        'time': stopwatch.elapsedMilliseconds,
      };
    } catch (e) {
      stopwatch.stop();
      // ignore: avoid_print
      print('[DIO] Error: $e');
      rethrow;
    }
  }
}
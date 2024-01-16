import 'package:dio/dio.dart';

class DioService {
  late Dio _dio;
  final String _apiKey =
      'vcfVhekWrB7MXCq2dehWg31ZtvyR2VB2A077hRS5M3TYQPZbLw0vnPKQ';

  DioService() {
    _dio = Dio();
    _configureDio();
  }

  void _configureDio() {
    _dio.options.baseUrl =
        'https://api.pexels.com/v1'; // Replace with your API base URL
    _dio.options.connectTimeout = const Duration(seconds: 5); // 5 seconds
    _dio.options.receiveTimeout = const Duration(seconds: 5); // 5 seconds

    _dio.options.headers = {
      'Content-Type':
          'application/json', // Adjust content type based on your API requirements
      'Authorization': _apiKey, // Replace with your actual access token
    };

    // You can add interceptors, headers, etc., as needed
    // Example:
    // _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // You can add other HTTP methods (post, put, delete) as needed
}

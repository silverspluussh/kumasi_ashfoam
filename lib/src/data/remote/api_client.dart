import 'package:dio/dio.dart';

class ApiClient {
  late final Dio _dio;
  static const String _baseUrl = 'https://api.ashfoam.com/v1';

  ApiClient({Dio? dio}) {
    _dio = dio ??
        Dio(
          BaseOptions(
            baseUrl: _baseUrl,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            contentType: 'application/json',
            responseType: ResponseType.json,
          ),
        );

    // Add interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add auth token if needed
          // options.headers['Authorization'] = 'Bearer $token';
          return handler.next(options);
        },
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.delete<T>(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// Sign in user with email and password
  Future<Response<Map<String, dynamic>>> signIn({
    required String email,
    required String password,
  }) {
    return _dio.post<Map<String, dynamic>>(
      '/auth/signin',
      data: {
        'email': email,
        'password': password,
      },
    );
  }

  /// Sign out user
  Future<Response<Map<String, dynamic>>> signOut() {
    return _dio.post<Map<String, dynamic>>(
      '/auth/signout',
    );
  }

  /// Refresh authentication token
  Future<Response<Map<String, dynamic>>> refreshToken({
    required String refreshToken,
  }) {
    return _dio.post<Map<String, dynamic>>(
      '/auth/refresh',
      data: {
        'refresh_token': refreshToken,
      },
    );
  }
}

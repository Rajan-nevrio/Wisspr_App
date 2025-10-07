import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../resources/local_storage.dart';

/// Custom exception classes for API errors
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? errorCode;

  ApiException(this.message, {this.statusCode, this.errorCode});

  @override
  String toString() => 'ApiException: $message';
}

class NetworkException extends ApiException {
  NetworkException(super.message);
}

class ServerException extends ApiException {
  ServerException(super.message, {super.statusCode, super.errorCode});
}

class TimeoutException extends ApiException {
  final Duration? timeoutDuration;

  TimeoutException(super.message, {this.timeoutDuration});

  @override
  String toString() =>
      'TimeoutException: $message${timeoutDuration != null ? ' (Timeout: ${timeoutDuration!.inSeconds}s)' : ''}';
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(super.message) : super(statusCode: 401);
}

class ForbiddenException extends ApiException {
  ForbiddenException(super.message) : super(statusCode: 403);
}

class NotFoundException extends ApiException {
  NotFoundException(super.message) : super(statusCode: 404);
}

class ValidationException extends ApiException {
  ValidationException(super.message) : super(statusCode: 422);
}

/// API Service class that handles all HTTP operations with proper exception handling
class ApiService {
  static const Duration _defaultTimeout = Duration(seconds: 30);
  static const String _contentType = 'application/json';
  static const String _acceptHeader = 'application/json';

  final Duration timeout;
  final Map<String, String> defaultHeaders;
  final LocalStorage _localStorage = LocalStorage();

  ApiService({
    this.timeout = _defaultTimeout,
    Map<String, String>? defaultHeaders,
  }) : defaultHeaders = {
         'Content-Type': _contentType,
         'Accept': _acceptHeader,
         ...?defaultHeaders,
       };

  /// GET request with exception handling
  Future<Map<String, dynamic>> get(
    String apiUrl, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    bool parseJson = true,
  }) async {
    try {
      final uri = _buildUri(apiUrl, queryParameters);
      final requestHeaders = await _buildHeaders(headers);

      final response = await http
          .get(uri, headers: requestHeaders)
          .timeout(
            timeout,
            onTimeout: () {
              throw TimeoutException(
                'GET request to $apiUrl timed out after ${timeout.inSeconds} seconds',
                timeoutDuration: timeout,
              );
            },
          );

      return _handleResponse(response, parseJson: parseJson);
    } on SocketException {
      throw NetworkException(
        'No internet connection. Please check your network settings.',
      );
    } on HttpException catch (e) {
      throw NetworkException('HTTP error occurred: ${e.message}');
    } on FormatException catch (e) {
      throw ApiException('Invalid response format: ${e.message}');
    } on TimeoutException {
      rethrow;
    }
  }

  /// POST request with exception handling
  Future<Map<String, dynamic>> post(
    String apiUrl, {
    Map<String, dynamic>? body,
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    bool parseJson = true,
  }) async {
    try {
      final uri = _buildUri(apiUrl, queryParameters);
      final requestHeaders = await _buildHeaders(headers);
      final requestBody = body != null ? jsonEncode(body) : null;

      final response = await http
          .post(uri, headers: requestHeaders, body: requestBody)
          .timeout(
            timeout,
            onTimeout: () {
              throw TimeoutException(
                'POST request to $apiUrl timed out after ${timeout.inSeconds} seconds',
                timeoutDuration: timeout,
              );
            },
          );

      return _handleResponse(response, parseJson: parseJson);
    } on SocketException {
      throw NetworkException(
        'No internet connection. Please check your network settings.',
      );
    } on HttpException catch (e) {
      throw NetworkException('HTTP error occurred: ${e.message}');
    } on FormatException catch (e) {
      throw ApiException('Invalid response format: ${e.message}');
    } on TimeoutException {
      rethrow;
    }
  }

  /// DELETE request with exception handling
  Future<Map<String, dynamic>> delete(
    String endpoint, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    bool parseJson = true,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParameters);
      final requestHeaders = await _buildHeaders(headers);

      final response = await http
          .delete(uri, headers: requestHeaders)
          .timeout(
            timeout,
            onTimeout: () {
              throw TimeoutException(
                'DELETE request to $endpoint timed out after ${timeout.inSeconds} seconds',
                timeoutDuration: timeout,
              );
            },
          );

      return _handleResponse(response, parseJson: parseJson);
    } on SocketException {
      throw NetworkException(
        'No internet connection. Please check your network settings.',
      );
    } on HttpException catch (e) {
      throw NetworkException('HTTP error occurred: ${e.message}');
    } on FormatException catch (e) {
      throw ApiException('Invalid response format: ${e.message}');
    } on TimeoutException {
      rethrow;
    }
  }

  /// PUT request with exception handling
  Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    bool parseJson = true,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParameters);
      final requestHeaders = await _buildHeaders(headers);
      final requestBody = body != null ? jsonEncode(body) : null;

      final response = await http
          .put(uri, headers: requestHeaders, body: requestBody)
          .timeout(
            timeout,
            onTimeout: () {
              throw TimeoutException(
                'PUT request to $endpoint timed out after ${timeout.inSeconds} seconds',
                timeoutDuration: timeout,
              );
            },
          );

      return _handleResponse(response, parseJson: parseJson);
    } on SocketException {
      throw NetworkException(
        'No internet connection. Please check your network settings.',
      );
    } on HttpException catch (e) {
      throw NetworkException('HTTP error occurred: ${e.message}');
    } on FormatException catch (e) {
      throw ApiException('Invalid response format: ${e.message}');
    } on TimeoutException {
      rethrow;
    }
  }

  /// PATCH request with exception handling
  Future<Map<String, dynamic>> patch(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    bool parseJson = true,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParameters);
      final requestHeaders = await _buildHeaders(headers);
      final requestBody = body != null ? jsonEncode(body) : null;

      final response = await http
          .patch(uri, headers: requestHeaders, body: requestBody)
          .timeout(
            timeout,
            onTimeout: () {
              throw TimeoutException(
                'PATCH request to $endpoint timed out after ${timeout.inSeconds} seconds',
                timeoutDuration: timeout,
              );
            },
          );

      return _handleResponse(response, parseJson: parseJson);
    } on SocketException {
      throw NetworkException(
        'No internet connection. Please check your network settings.',
      );
    } on HttpException catch (e) {
      throw NetworkException('HTTP error occurred: ${e.message}');
    } on FormatException catch (e) {
      throw ApiException('Invalid response format: ${e.message}');
    } on TimeoutException {
      rethrow;
    }
  }

  /// Build headers with proper Bearer token formatting and automatic token injection
  Future<Map<String, String>> _buildHeaders(
    Map<String, String>? additionalHeaders,
  ) async {
    final headers = <String, String>{...defaultHeaders};

    try {
      final token = await _localStorage.getAccessToken();
      if (token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      debugPrint('Failed to get access token:-----> $e');
    }

    if (headers.containsKey('Authorization')) {
      final authValue = headers['Authorization']!;
      if (!authValue.startsWith('Bearer ')) {
        headers['Authorization'] = 'Bearer ${authValue.replaceFirst('Bearer ', '')}';
      }
    }

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    return headers;
  }

  /// Build URI with query parameters
  Uri _buildUri(String url, Map<String, String>? queryParameters) {
    final uri = Uri.parse(url);
    if (queryParameters != null && queryParameters.isNotEmpty) {
      return uri.replace(queryParameters: queryParameters);
    }
    return uri;
  }

  /// Handle HTTP response and throw appropriate exceptions
  Map<String, dynamic> _handleResponse(
    http.Response response, {
    bool parseJson = true,
  }) {
    final statusCode = response.statusCode;

    switch (statusCode) {
      case 200:
      case 201:
        return _parseResponse(response, parseJson);
      case 400:
        throw ValidationException('Bad request: ${response.body}');
      case 401:
        throw UnauthorizedException('Unauthorized: Please login again');
      case 403:
        throw ForbiddenException(
          'Forbidden: You do not have permission to access this resource',
        );
      case 404:
        throw NotFoundException('Resource not found');
      case 422:
        throw ValidationException('Validation error: ${response.body}');
      case 500:
        throw ServerException('Internal server error', statusCode: statusCode);
      case 502:
        throw ServerException('Bad gateway', statusCode: statusCode);
      case 503:
        throw ServerException('Service unavailable', statusCode: statusCode);
      case 504:
        throw ServerException('Gateway timeout', statusCode: statusCode);
      default:
        if (statusCode >= 400 && statusCode < 500) {
          throw ApiException(
            'Client error: ${response.body}',
            statusCode: statusCode,
          );
        } else if (statusCode >= 500) {
          throw ServerException(
            'Server error: ${response.body}',
            statusCode: statusCode,
          );
        } else {
          throw ApiException(
            'Unexpected status code: $statusCode',
            statusCode: statusCode,
          );
        }
    }
  }

  /// Parse response body
  Map<String, dynamic> _parseResponse(http.Response response, bool parseJson) {
    if (!parseJson) {
      return {'data': response.body};
    }

    try {
      if (response.body.isEmpty) {
        return {};
      }
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      throw ApiException('Failed to parse JSON response: $e');
    }
  }
}

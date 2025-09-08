import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;

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
  String toString() => 'TimeoutException: $message${timeoutDuration != null ? ' (Timeout: ${timeoutDuration!.inSeconds}s)' : ''}';
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

  final String baseUrl;
  final Duration timeout;
  final Map<String, String> defaultHeaders;

  ApiService({
    required this.baseUrl,
    this.timeout = _defaultTimeout,
    Map<String, String>? defaultHeaders,
  }) : defaultHeaders = {
          'Content-Type': _contentType,
          'Accept': _acceptHeader,
          ...?defaultHeaders,
        };

  /// GET request with exception handling
  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    bool parseJson = true,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParameters);
      final requestHeaders = _buildHeaders(headers);

      final response = await http
          .get(uri, headers: requestHeaders)
          .timeout(timeout, onTimeout: () {
            throw TimeoutException(
              'GET request to $endpoint timed out after ${timeout.inSeconds} seconds',
              timeoutDuration: timeout,
            );
          });

      return _handleResponse(response, parseJson: parseJson);
    } on SocketException {
      throw NetworkException('No internet connection. Please check your network settings.');
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
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    bool parseJson = true,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParameters);
      final requestHeaders = _buildHeaders(headers);
      final requestBody = body != null ? jsonEncode(body) : null;

      final response = await http
          .post(uri, headers: requestHeaders, body: requestBody)
          .timeout(timeout, onTimeout: () {
            throw TimeoutException(
              'POST request to $endpoint timed out after ${timeout.inSeconds} seconds',
              timeoutDuration: timeout,
            );
          });

      return _handleResponse(response, parseJson: parseJson);
    } on SocketException {
      throw NetworkException('No internet connection. Please check your network settings.');
    } on HttpException catch (e) {
      throw NetworkException('HTTP error occurred: ${e.message}');
    } on FormatException catch (e) {
      throw ApiException('Invalid response format: ${e.message}');
    } on TimeoutException {
      rethrow; // Re-throw our custom timeout exception
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
      final requestHeaders = _buildHeaders(headers);

      final response = await http
          .delete(uri, headers: requestHeaders)
          .timeout(timeout, onTimeout: () {
            throw TimeoutException(
              'DELETE request to $endpoint timed out after ${timeout.inSeconds} seconds',
              timeoutDuration: timeout,
            );
          });

      return _handleResponse(response, parseJson: parseJson);
    } on SocketException {
      throw NetworkException('No internet connection. Please check your network settings.');
    } on HttpException catch (e) {
      throw NetworkException('HTTP error occurred: ${e.message}');
    } on FormatException catch (e) {
      throw ApiException('Invalid response format: ${e.message}');
    } on TimeoutException {
      rethrow; // Re-throw our custom timeout exception
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
      final requestHeaders = _buildHeaders(headers);
      final requestBody = body != null ? jsonEncode(body) : null;

      final response = await http
          .put(uri, headers: requestHeaders, body: requestBody)
          .timeout(timeout, onTimeout: () {
            throw TimeoutException(
              'PUT request to $endpoint timed out after ${timeout.inSeconds} seconds',
              timeoutDuration: timeout,
            );
          });

      return _handleResponse(response, parseJson: parseJson);
    } on SocketException {
      throw NetworkException('No internet connection. Please check your network settings.');
    } on HttpException catch (e) {
      throw NetworkException('HTTP error occurred: ${e.message}');
    } on FormatException catch (e) {
      throw ApiException('Invalid response format: ${e.message}');
    } on TimeoutException {
      rethrow; // Re-throw our custom timeout exception
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
      final requestHeaders = _buildHeaders(headers);
      final requestBody = body != null ? jsonEncode(body) : null;

      final response = await http
          .patch(uri, headers: requestHeaders, body: requestBody)
          .timeout(timeout, onTimeout: () {
            throw TimeoutException(
              'PATCH request to $endpoint timed out after ${timeout.inSeconds} seconds',
              timeoutDuration: timeout,
            );
          });

      return _handleResponse(response, parseJson: parseJson);
    } on SocketException {
      throw NetworkException('No internet connection. Please check your network settings.');
    } on HttpException catch (e) {
      throw NetworkException('HTTP error occurred: ${e.message}');
    } on FormatException catch (e) {
      throw ApiException('Invalid response format: ${e.message}');
    } on TimeoutException {
      rethrow; // Re-throw our custom timeout exception
    }
  }

  /// Build headers with proper Bearer token formatting
  Map<String, String> _buildHeaders(Map<String, String>? additionalHeaders) {
    final headers = <String, String>{...defaultHeaders};
    
    // Ensure Bearer token is properly formatted
    if (headers.containsKey('Authorization')) {
      final authValue = headers['Authorization']!;
      if (!authValue.startsWith('Bearer ')) {
        headers['Authorization'] = 'Bearer ${authValue.replaceFirst('Bearer ', '')}';
      }
    }
    
    // Add any additional headers
    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }
    
    return headers;
  }

  /// Build URI with query parameters
  Uri _buildUri(String endpoint, Map<String, String>? queryParameters) {
    final uri = Uri.parse('$baseUrl$endpoint');
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

    // Handle different status codes
    switch (statusCode) {
      case 200:
      case 201:
        return _parseResponse(response, parseJson);
      case 400:
        throw ValidationException('Bad request: ${response.body}');
      case 401:
        throw UnauthorizedException('Unauthorized: Please login again');
      case 403:
        throw ForbiddenException('Forbidden: You do not have permission to access this resource');
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
          throw ApiException('Client error: ${response.body}', statusCode: statusCode);
        } else if (statusCode >= 500) {
          throw ServerException('Server error: ${response.body}', statusCode: statusCode);
        } else {
          throw ApiException('Unexpected status code: $statusCode', statusCode: statusCode);
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

  /// Add authentication token to headers with proper Bearer formatting
  void setAuthToken(String token) {
    // Remove any existing "Bearer " prefix to avoid duplication
    final cleanToken = token.startsWith('Bearer ') 
        ? token.substring(7) 
        : token;
    defaultHeaders['Authorization'] = 'Bearer $cleanToken';
  }

  /// Remove authentication token from headers
  void clearAuthToken() {
    defaultHeaders.remove('Authorization');
  }

  /// Add custom header
  void addHeader(String key, String value) {
    defaultHeaders[key] = value;
  }

  /// Remove custom header
  void removeHeader(String key) {
    defaultHeaders.remove(key);
  }

  /// Get current timeout duration
  Duration get currentTimeout => timeout;

  /// Check if authentication token is set
  bool get hasAuthToken => defaultHeaders.containsKey('Authorization');

  /// Get current authentication token (without Bearer prefix)
  String? get authToken {
    final authHeader = defaultHeaders['Authorization'];
    if (authHeader != null && authHeader.startsWith('Bearer ')) {
      return authHeader.substring(7);
    }
    return authHeader;
  }

  /// Make a request with custom timeout
  Future<Map<String, dynamic>> getWithCustomTimeout(
    String endpoint, {
    Duration? customTimeout,
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    bool parseJson = true,
  }) async {
    final effectiveTimeout = customTimeout ?? timeout;
    
    try {
      final uri = _buildUri(endpoint, queryParameters);
      final requestHeaders = _buildHeaders(headers);

      final response = await http
          .get(uri, headers: requestHeaders)
          .timeout(effectiveTimeout, onTimeout: () {
            throw TimeoutException(
              'GET request to $endpoint timed out after ${effectiveTimeout.inSeconds} seconds',
              timeoutDuration: effectiveTimeout,
            );
          });

      return _handleResponse(response, parseJson: parseJson);
    } on SocketException {
      throw NetworkException('No internet connection. Please check your network settings.');
    } on HttpException catch (e) {
      throw NetworkException('HTTP error occurred: ${e.message}');
    } on FormatException catch (e) {
      throw ApiException('Invalid response format: ${e.message}');
    } on TimeoutException {
      rethrow;
    }
  }
}

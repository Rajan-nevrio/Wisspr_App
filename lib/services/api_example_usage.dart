import 'api_service.dart';

/// Example usage of the ApiService class
class ApiExampleUsage {
  // Initialize the API service with your base URL
  static final ApiService _apiService = ApiService(
    baseUrl: 'https://api.example.com/v1', // Replace with your actual API base URL
    timeout: const Duration(seconds: 30),
    defaultHeaders: {
      'User-Agent': 'WissprApp/1.0.0',
      // Add any other default headers you need
    },
  );

  /// Example: GET request to fetch user data
  static Future<Map<String, dynamic>> fetchUserData(String userId) async {
    try {
      final response = await _apiService.get(
        '/users/$userId',
        queryParameters: {
          'include': 'profile,settings',
        },
      );
      return response;
    } on NetworkException catch (e) {
      // Handle network errors (no internet, etc.)
      print('Network error: ${e.message}');
      rethrow;
    } on UnauthorizedException catch (e) {
      // Handle authentication errors
      print('Unauthorized: ${e.message}');
      // Redirect to login screen or refresh token
      rethrow;
    } on NotFoundException catch (e) {
      // Handle resource not found
      print('User not found: ${e.message}');
      rethrow;
    } on ApiException catch (e) {
      // Handle other API errors
      print('API error: ${e.message}');
      rethrow;
    }
  }

  /// Example: POST request to create a new user
  static Future<Map<String, dynamic>> createUser(Map<String, dynamic> userData) async {
    try {
      final response = await _apiService.post(
        '/users',
        body: userData,
        headers: {
          'X-Request-ID': DateTime.now().millisecondsSinceEpoch.toString(),
        },
      );
      return response;
    } on ValidationException catch (e) {
      // Handle validation errors
      print('Validation error: ${e.message}');
      rethrow;
    } on NetworkException catch (e) {
      print('Network error: ${e.message}');
      rethrow;
    } on ApiException catch (e) {
      print('API error: ${e.message}');
      rethrow;
    }
  }

  /// Example: DELETE request to remove a user
  static Future<Map<String, dynamic>> deleteUser(String userId) async {
    try {
      final response = await _apiService.delete(
        '/users/$userId',
        headers: {
          'X-Request-ID': DateTime.now().millisecondsSinceEpoch.toString(),
        },
      );
      return response;
    } on UnauthorizedException catch (e) {
      print('Unauthorized: ${e.message}');
      rethrow;
    } on ForbiddenException catch (e) {
      print('Forbidden: ${e.message}');
      rethrow;
    } on NotFoundException catch (e) {
      print('User not found: ${e.message}');
      rethrow;
    } on NetworkException catch (e) {
      print('Network error: ${e.message}');
      rethrow;
    } on ApiException catch (e) {
      print('API error: ${e.message}');
      rethrow;
    }
  }

  /// Example: PUT request to update user data
  static Future<Map<String, dynamic>> updateUser(String userId, Map<String, dynamic> userData) async {
    try {
      final response = await _apiService.put(
        '/users/$userId',
        body: userData,
      );
      return response;
    } on ValidationException catch (e) {
      print('Validation error: ${e.message}');
      rethrow;
    } on UnauthorizedException catch (e) {
      print('Unauthorized: ${e.message}');
      rethrow;
    } on NetworkException catch (e) {
      print('Network error: ${e.message}');
      rethrow;
    } on ApiException catch (e) {
      print('API error: ${e.message}');
      rethrow;
    }
  }

  /// Example: PATCH request to partially update user data
  static Future<Map<String, dynamic>> patchUser(String userId, Map<String, dynamic> userData) async {
    try {
      final response = await _apiService.patch(
        '/users/$userId',
        body: userData,
      );
      return response;
    } on ValidationException catch (e) {
      print('Validation error: ${e.message}');
      rethrow;
    } on UnauthorizedException catch (e) {
      print('Unauthorized: ${e.message}');
      rethrow;
    } on NetworkException catch (e) {
      print('Network error: ${e.message}');
      rethrow;
    } on ApiException catch (e) {
      print('API error: ${e.message}');
      rethrow;
    }
  }

  /// Example: Setting authentication token
  static void setAuthToken(String token) {
    _apiService.setAuthToken(token);
  }

  /// Example: Clearing authentication token
  static void clearAuthToken() {
    _apiService.clearAuthToken();
  }

  /// Example: Adding custom headers
  static void addCustomHeader(String key, String value) {
    _apiService.addHeader(key, value);
  }

  /// Example: Making a request with custom timeout
  static Future<Map<String, dynamic>> fetchDataWithCustomTimeout() async {
    // Create a new instance with custom timeout
    final customApiService = ApiService(
      baseUrl: 'https://api.example.com/v1',
      timeout: const Duration(seconds: 60), // Custom timeout
    );

    try {
      final response = await customApiService.get('/data');
      return response;
    } on TimeoutException catch (e) {
      print('Request timed out: ${e.message}');
      print('Timeout duration: ${e.timeoutDuration?.inSeconds}s');
      rethrow;
    } on ApiException catch (e) {
      print('API error: ${e.message}');
      rethrow;
    }
  }

  /// Example: Enhanced timeout handling with retry logic
  static Future<Map<String, dynamic>> fetchDataWithRetry({
    int maxRetries = 3,
    Duration? customTimeout,
  }) async {
    int retryCount = 0;
    
    while (retryCount < maxRetries) {
      try {
        final response = await _apiService.getWithCustomTimeout(
          '/data',
          customTimeout: customTimeout ?? const Duration(seconds: 15),
        );
        return response;
      } on TimeoutException catch (e) {
        retryCount++;
        print('Attempt $retryCount failed: ${e.message}');
        
        if (retryCount >= maxRetries) {
          throw TimeoutException(
            'Request failed after $maxRetries attempts. Last timeout: ${e.message}',
            timeoutDuration: e.timeoutDuration,
          );
        }
        
        // Wait before retrying (exponential backoff)
        await Future.delayed(Duration(seconds: retryCount * 2));
      } on ApiException catch (e) {
        print('Non-timeout error: ${e.message}');
        rethrow; // Don't retry for non-timeout errors
      }
    }
    
    throw ApiException('Unexpected error in retry logic');
  }

  /// Example: Bearer token handling
  static void demonstrateBearerTokenHandling() {
    // Set token with Bearer prefix
    _apiService.setAuthToken('Bearer your-jwt-token-here');
    print('Token set: ${_apiService.authToken}');
    print('Has auth token: ${_apiService.hasAuthToken}');
    
    // Set token without Bearer prefix (will be added automatically)
    _apiService.setAuthToken('your-jwt-token-here');
    print('Token set: ${_apiService.authToken}');
    
    // Clear token
    _apiService.clearAuthToken();
    print('Has auth token after clear: ${_apiService.hasAuthToken}');
  }

  /// Example: Timeout exception handling with detailed information
  static Future<void> handleTimeoutExceptions() async {
    try {
      // Make a request that might timeout
      final response = await _apiService.get('/slow-endpoint');
      print('Response: $response');
    } on TimeoutException catch (e) {
      print('Timeout occurred:');
      print('  Message: ${e.message}');
      print('  Timeout Duration: ${e.timeoutDuration?.inSeconds}s');
      print('  Current API timeout: ${_apiService.currentTimeout.inSeconds}s');
      
      // Handle timeout based on duration
      if (e.timeoutDuration != null && e.timeoutDuration!.inSeconds < 10) {
        print('Short timeout - might be a network issue');
      } else {
        print('Long timeout - server might be slow');
      }
    } on ApiException catch (e) {
      print('Other API error: ${e.message}');
    }
  }
}

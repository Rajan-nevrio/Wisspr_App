import 'api_service.dart';

/// Test examples demonstrating the enhanced API service functionality
class ApiServiceTestExample {
  static final ApiService _apiService = ApiService(
    baseUrl: 'https://jsonplaceholder.typicode.com',
    timeout: const Duration(seconds: 10),
  );

  /// Test timeout handling
  static Future<void> testTimeoutHandling() async {
    print('=== Testing Timeout Handling ===');
    
    try {
      // This will likely timeout due to short duration
      final response = await _apiService.getWithCustomTimeout(
        '/posts/1',
        customTimeout: const Duration(milliseconds: 100), // Very short timeout
      );
      print('Response: $response');
    } on TimeoutException catch (e) {
      print('✅ Timeout caught successfully:');
      print('  Message: ${e.message}');
      print('  Duration: ${e.timeoutDuration?.inMilliseconds}ms');
    } catch (e) {
      print('❌ Unexpected error: $e');
    }
  }

  /// Test Bearer token handling
  static void testBearerTokenHandling() {
    print('\n=== Testing Bearer Token Handling ===');
    
    // Test setting token with Bearer prefix
    _apiService.setAuthToken('Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...');
    print('✅ Token with Bearer prefix set: ${_apiService.authToken}');
    print('   Has auth token: ${_apiService.hasAuthToken}');
    
    // Test setting token without Bearer prefix
    _apiService.setAuthToken('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...');
    print('✅ Token without Bearer prefix set: ${_apiService.authToken}');
    print('   Has auth token: ${_apiService.hasAuthToken}');
    
    // Test clearing token
    _apiService.clearAuthToken();
    print('✅ Token cleared: ${_apiService.hasAuthToken}');
  }

  /// Test successful API call
  static Future<void> testSuccessfulApiCall() async {
    print('\n=== Testing Successful API Call ===');
    
    try {
      final response = await _apiService.get('/posts/1');
      print('✅ API call successful:');
      print('  Title: ${response['title']}');
      print('  User ID: ${response['userId']}');
    } on TimeoutException catch (e) {
      print('❌ Timeout: ${e.message}');
    } on ApiException catch (e) {
      print('❌ API Error: ${e.message}');
    }
  }

  /// Test error handling for different status codes
  static Future<void> testErrorHandling() async {
    print('\n=== Testing Error Handling ===');
    
    try {
      // This should return 404
      final response = await _apiService.get('/nonexistent-endpoint');
      print('Response: $response');
    } on NotFoundException catch (e) {
      print('✅ 404 Not Found caught: ${e.message}');
    } on ApiException catch (e) {
      print('❌ Other API error: ${e.message}');
    }
  }

  /// Test custom headers
  static Future<void> testCustomHeaders() async {
    print('\n=== Testing Custom Headers ===');
    
    try {
      final response = await _apiService.get(
        '/posts/1',
        headers: {
          'X-Custom-Header': 'test-value',
          'X-Request-ID': DateTime.now().millisecondsSinceEpoch.toString(),
        },
      );
      print('✅ Request with custom headers successful');
    } on ApiException catch (e) {
      print('❌ Error with custom headers: ${e.message}');
    }
  }

  /// Test query parameters
  static Future<void> testQueryParameters() async {
    print('\n=== Testing Query Parameters ===');
    
    try {
      final response = await _apiService.get(
        '/posts',
        queryParameters: {
          'userId': '1',
          '_limit': '3',
        },
      );
      print('✅ Query parameters test successful');
      print('  Number of posts: ${(response as List).length}');
    } on ApiException catch (e) {
      print('❌ Error with query parameters: ${e.message}');
    }
  }

  /// Run all tests
  static Future<void> runAllTests() async {
    print('🚀 Starting API Service Tests\n');
    
    testBearerTokenHandling();
    await testSuccessfulApiCall();
    await testErrorHandling();
    await testCustomHeaders();
    await testQueryParameters();
    await testTimeoutHandling();
    
    print('\n✅ All tests completed!');
  }
}

/// Example usage in your app
void main() async {
  await ApiServiceTestExample.runAllTests();
}

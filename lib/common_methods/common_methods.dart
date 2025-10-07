import 'dart:io';
import 'package:flutter/foundation.dart';

class CommonMethods {
  /// Method used to print the GET apis data.
  void printGetResponse({required String url, required var response}) {
    debugPrint("API Url:----> $url");
    debugPrint("API Response:----> $response");
  }

  /// Method used to print the POST apis data.
  void printPostResponse({
    required String url,
    required Map<String, String> requestBody,
    required var response,
  }) {
    debugPrint("API Url:----> $url");
    debugPrint("API Request Body:----> $requestBody");
    debugPrint("API Response:----> $response");
  }

  /// Method used to check the device platform.
  String getPlatform() {
    if (kIsWeb) return 'web';
    if (Platform.isAndroid) return 'android';
    if (Platform.isIOS) return 'ios';
    if (Platform.isWindows) return 'windows';
    if (Platform.isLinux) return 'linux';
    if (Platform.isMacOS) return 'macos';
    return 'unknown';
  }
}

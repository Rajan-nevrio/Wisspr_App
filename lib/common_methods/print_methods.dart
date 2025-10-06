import 'package:flutter/cupertino.dart';

class CommonMethods{

  /// Method used to print the GET apis data.
  void printGetResponse({required String url, required var response}) {
    debugPrint("API Url:----> $url");
    debugPrint("API Response:----> $response");
  }

  /// Method used to print the POST apis data.
  void printPostResponse({required String url, required Map<String, String> requestBody, required var response}) {
    debugPrint("API Url:----> $url");
    debugPrint("API Request Body:----> $requestBody");
    debugPrint("API Response:----> $response");
  }

}
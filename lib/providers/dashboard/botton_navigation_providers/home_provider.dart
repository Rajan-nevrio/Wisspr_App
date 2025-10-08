import 'package:flutter/cupertino.dart';
import 'package:wisspr_app/common_methods/common_methods.dart';
import 'package:wisspr_app/services/api_service.dart';
import 'package:wisspr_app/services/api_url.dart';

class HomeProvider with ChangeNotifier{
  final ApiService _apiService = ApiService(timeout: const Duration(seconds: 10));
  CommonMethods commonMethods = CommonMethods();

  /// Method used to get the videos.
  Future<void> getVideoMethod() async {
    Map<String, dynamic>? reply;
    try {
      reply = await _apiService.get(ApiUrl.getVideo);
      if (reply["status"]) {
      } else {
        debugPrint("${reply["msg"]}");
      }
    } catch (e) {
      debugPrint("Failed to get video:----> $e");
    } finally {
      commonMethods.printGetResponse(url: ApiUrl.getVideo, response: reply);
    }
  }

  /// Method used to get the banner.
  Future<void> getBannerMethod() async {
    Map<String, dynamic>? reply;
    try {
      reply = await _apiService.get(ApiUrl.getBanners);
      if (reply["status"]) {
      } else {
        debugPrint("${reply["msg"]}");
      }
    } catch (e) {
      debugPrint("Failed to get banner:----> $e");
    } finally {
      commonMethods.printGetResponse(url: ApiUrl.getBanners, response: reply);
    }
  }
}
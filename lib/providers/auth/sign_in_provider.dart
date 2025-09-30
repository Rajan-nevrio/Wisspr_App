import 'package:flutter/material.dart';
import 'package:wisspr_app/resources/local_storage.dart';
import '../../routes/navigation_helper.dart';

class SignUpProvider with ChangeNotifier {
  LocalStorage storage = LocalStorage();
  bool _isGoogleLoader = false;
  bool _isAppleLoader = false;

  bool get isGoogleLoader => _isGoogleLoader;
  bool get isAppleLoader => _isAppleLoader;

  /// Method used to google login.
  Future<void> handleGoogleLogin(BuildContext context) async {
    if(_isGoogleLoader || _isAppleLoader) return;

    _isGoogleLoader = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      debugPrint('------> Google login pressed');
      await storage.saveAccessToken("user_access_token");

      if (context.mounted) {
        NavigationHelper.goToHome(context);
      }
      
    } catch (error) {
      debugPrint('Failed to Google login:-----> $error');
    } finally {
      _isGoogleLoader = false;
      notifyListeners();
    }
  }

  /// Method used to apple login.
  Future<void> handleAppleLogin(BuildContext context) async {
    if(_isAppleLoader || _isGoogleLoader) return;

    _isAppleLoader = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      debugPrint('------> Apple login pressed');
      await storage.saveAccessToken("user_access_token");

      if (context.mounted) {
        NavigationHelper.goToHome(context);
      }
      
    } catch (error) {
      debugPrint('Failed to Apple login:-----> $error');
    } finally {
      _isAppleLoader = false;
      notifyListeners();
    }
  }
}
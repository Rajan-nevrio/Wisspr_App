import 'package:flutter/material.dart';
import 'app_routes.dart';

class NavigationHelper {
  NavigationHelper._();

  /// Navigate to home screen
  static Future<T?> goToHome<T extends Object?>(BuildContext context) {
    return AppRoutes.pushReplacement<T, dynamic>(context, AppRoutes.home);
  }

  /// Navigate to splash screen
  static Future<T?> goToSplash<T extends Object?>(BuildContext context) {
    return AppRoutes.pushAndClearStack<T>(context, AppRoutes.splash);
  }

  /// Navigate to intro screen
  static Future<T?> goToIntro<T extends Object?>(BuildContext context) {
    return AppRoutes.pushReplacement<T, dynamic>(context, AppRoutes.intro);
  }

  /// Navigate to signup screen
  static Future<T?> goToSignIn<T extends Object?>(BuildContext context) {
    return AppRoutes.pushReplacement<T, dynamic>(context, AppRoutes.signIn);
  }

  /// Navigate to signup screen
  static Future<T?> goToMyAccount<T extends Object?>(BuildContext context) {
    return AppRoutes.push(context, AppRoutes.myAccount);
  }

  /// Navigate to setting screen
  static Future<T?> goToSetting<T extends Object?>(BuildContext context) {
    return AppRoutes.push(context, AppRoutes.settingScreen);
  }

  /// Navigate to setting screen
  static Future<T?> goToNotificationSetting<T extends Object?>(BuildContext context) {
    return AppRoutes.push(context, AppRoutes.notificationSettingScreen);
  }

  /// Navigate to sign-in screen and remove all previous routes
  static Future<T?> logout<T extends Object?>(BuildContext context) {
    return AppRoutes.pushAndClearStack(context, AppRoutes.signIn);
  }

}

import 'package:flutter/material.dart';
import 'app_routes.dart';

/// Navigation helper class with convenient methods for app navigation
class NavigationHelper {
  // Private constructor to prevent instantiation
  NavigationHelper._();

  // ========================================
  // BASIC NAVIGATION
  // ========================================

  /// Navigate to home screen
  static Future<T?> goToHome<T extends Object?>(BuildContext context) {
    return AppRoutes.pushReplacement<T, dynamic>(context, AppRoutes.home);
  }

  /// Navigate to main navigation screen
  static Future<T?> goToMainNavigation<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.mainNavigation);
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
  static Future<T?> goToSignup<T extends Object?>(BuildContext context) {
    return AppRoutes.pushReplacement<T, dynamic>(context, AppRoutes.signup);
  }

  /// Navigate to responsive example
  static Future<T?> goToResponsive<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.responsive);
  }

  /// Navigate to shared preferences example
  static Future<T?> goToSharedPreferences<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.sharedPreferences);
  }

  /// Navigate to route example
  static Future<T?> goToRouteExample<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.routeExample);
  }

  // ========================================
  // AUTHENTICATION NAVIGATION
  // ========================================

  /// Navigate to login screen
  static Future<T?> goToLogin<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.login);
  }

  /// Navigate to register screen
  static Future<T?> goToRegister<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.register);
  }

  /// Navigate to forgot password screen
  static Future<T?> goToForgotPassword<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.forgotPassword);
  }

  /// Navigate to reset password screen
  static Future<T?> goToResetPassword<T extends Object?>(
    BuildContext context, {
    String? token,
  }) {
    return AppRoutes.push<T>(
      context,
      AppRoutes.resetPassword,
      arguments: {'token': token},
    );
  }

  /// Navigate to verify email screen
  static Future<T?> goToVerifyEmail<T extends Object?>(
    BuildContext context, {
    String? email,
  }) {
    return AppRoutes.push<T>(
      context,
      AppRoutes.verifyEmail,
      arguments: {'email': email},
    );
  }

  // ========================================
  // PROFILE NAVIGATION
  // ========================================

  /// Navigate to profile screen
  static Future<T?> goToProfile<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.profile);
  }

  /// Navigate to edit profile screen
  static Future<T?> goToEditProfile<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.editProfile);
  }

  /// Navigate to change password screen
  static Future<T?> goToChangePassword<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.changePassword);
  }

  /// Navigate to settings screen
  static Future<T?> goToSettings<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.settings);
  }

  /// Navigate to privacy policy screen
  static Future<T?> goToPrivacyPolicy<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.privacyPolicy);
  }

  /// Navigate to terms of service screen
  static Future<T?> goToTermsOfService<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.termsOfService);
  }

  // ========================================
  // FEATURE NAVIGATION
  // ========================================

  /// Navigate to dashboard screen
  static Future<T?> goToDashboard<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.dashboard);
  }

  /// Navigate to notifications screen
  static Future<T?> goToNotifications<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.notifications);
  }

  /// Navigate to search screen
  static Future<T?> goToSearch<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.search);
  }

  /// Navigate to favorites screen
  static Future<T?> goToFavorites<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.favorites);
  }

  /// Navigate to history screen
  static Future<T?> goToHistory<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.history);
  }

  // ========================================
  // CONTENT NAVIGATION
  // ========================================

  /// Navigate to content list screen
  static Future<T?> goToContentList<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.contentList);
  }

  /// Navigate to content detail screen
  static Future<T?> goToContentDetail<T extends Object?>(
    BuildContext context, {
    required String contentId,
    String? title,
  }) {
    return AppRoutes.push<T>(
      context,
      AppRoutes.contentDetail,
      arguments: {
        'contentId': contentId,
        'title': title,
      },
    );
  }

  /// Navigate to create content screen
  static Future<T?> goToCreateContent<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.createContent);
  }

  /// Navigate to edit content screen
  static Future<T?> goToEditContent<T extends Object?>(
    BuildContext context, {
    required String contentId,
  }) {
    return AppRoutes.push<T>(
      context,
      AppRoutes.editContent,
      arguments: {'contentId': contentId},
    );
  }

  // ========================================
  // MEDIA NAVIGATION
  // ========================================

  /// Navigate to gallery screen
  static Future<T?> goToGallery<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.gallery);
  }

  /// Navigate to camera screen
  static Future<T?> goToCamera<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.camera);
  }

  /// Navigate to image viewer screen
  static Future<T?> goToImageViewer<T extends Object?>(
    BuildContext context, {
    required String imageUrl,
    String? imageTitle,
  }) {
    return AppRoutes.push<T>(
      context,
      AppRoutes.imageViewer,
      arguments: {
        'imageUrl': imageUrl,
        'imageTitle': imageTitle,
      },
    );
  }

  /// Navigate to video player screen
  static Future<T?> goToVideoPlayer<T extends Object?>(
    BuildContext context, {
    required String videoUrl,
    String? videoTitle,
  }) {
    return AppRoutes.push<T>(
      context,
      AppRoutes.videoPlayer,
      arguments: {
        'videoUrl': videoUrl,
        'videoTitle': videoTitle,
      },
    );
  }

  // ========================================
  // COMMUNICATION NAVIGATION
  // ========================================

  /// Navigate to messages screen
  static Future<T?> goToMessages<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.messages);
  }

  /// Navigate to chat screen
  static Future<T?> goToChat<T extends Object?>(
    BuildContext context, {
    required String chatId,
    required String userName,
  }) {
    return AppRoutes.push<T>(
      context,
      AppRoutes.chat,
      arguments: {
        'chatId': chatId,
        'userName': userName,
      },
    );
  }

  /// Navigate to contacts screen
  static Future<T?> goToContacts<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.contacts);
  }

  /// Navigate to call screen
  static Future<T?> goToCall<T extends Object?>(
    BuildContext context, {
    required String contactId,
    String? contactName,
  }) {
    return AppRoutes.push<T>(
      context,
      AppRoutes.call,
      arguments: {
        'contactId': contactId,
        'contactName': contactName,
      },
    );
  }

  // ========================================
  // UTILITY NAVIGATION
  // ========================================

  /// Navigate to about screen
  static Future<T?> goToAbout<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.about);
  }

  /// Navigate to help screen
  static Future<T?> goToHelp<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.help);
  }

  /// Navigate to feedback screen
  static Future<T?> goToFeedback<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.feedback);
  }

  /// Navigate to support screen
  static Future<T?> goToSupport<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.support);
  }

  /// Navigate to debug screen
  static Future<T?> goToDebug<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.debug);
  }

  // ========================================
  // ERROR NAVIGATION
  // ========================================

  /// Navigate to not found screen
  static Future<T?> goToNotFound<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.notFound);
  }

  /// Navigate to error screen
  static Future<T?> goToError<T extends Object?>(
    BuildContext context, {
    String? errorMessage,
  }) {
    return AppRoutes.push<T>(
      context,
      AppRoutes.error,
      arguments: {'errorMessage': errorMessage},
    );
  }

  /// Navigate to maintenance screen
  static Future<T?> goToMaintenance<T extends Object?>(BuildContext context) {
    return AppRoutes.push<T>(context, AppRoutes.maintenance);
  }

  // ========================================
  // NAVIGATION UTILITIES
  // ========================================

  /// Go back to previous screen
  static void goBack<T extends Object?>(BuildContext context, [T? result]) {
    AppRoutes.pop<T>(context, result);
  }

  /// Go back to specific route
  static void goBackTo(BuildContext context, String routeName) {
    AppRoutes.popUntil(context, routeName);
  }

  /// Go back to home screen
  static void goBackToHome(BuildContext context) {
    AppRoutes.popUntil(context, AppRoutes.home);
  }

  /// Go back to root screen
  static void goBackToRoot(BuildContext context) {
    AppRoutes.popToRoot(context);
  }

  /// Check if can go back
  static bool canGoBack(BuildContext context) {
    return Navigator.canPop(context);
  }

  // ========================================
  // MODAL NAVIGATION
  // ========================================

  /// Show bottom sheet
  static Future<T?> showBottomSheet<T extends Object?>(
    BuildContext context,
    Widget child, {
    bool isDismissible = true,
    bool enableDrag = true,
    bool isScrollControlled = false,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      builder: (context) => child,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: isScrollControlled,
    );
  }

  /// Hide loading dialog
  static void hideLoadingDialog(BuildContext context) {
    Navigator.pop(context);
  }

  // ========================================
  // ROUTE VALIDATION
  // ========================================

  /// Check if route exists
  static bool routeExists(String routeName) {
    return AppRoutes.routeExists(routeName);
  }

  /// Get current route name
  static String? getCurrentRouteName(BuildContext context) {
    return ModalRoute.of(context)?.settings.name;
  }

  /// Get current route arguments
  static Object? getCurrentRouteArguments(BuildContext context) {
    return ModalRoute.of(context)?.settings.arguments;
  }
}

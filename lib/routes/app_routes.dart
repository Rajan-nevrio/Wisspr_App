import 'package:flutter/material.dart';
import 'package:wisspr_app/resources/dimension_spacing/vertical_spacing.dart';
import '../commom_widgets/customer_text/marcellus_font_type_text.dart';
import '../commom_widgets/customer_text/satoshi_font_type_text.dart';
import '../resources/app_strings.dart';
import '../screens/auth/my_account_screen.dart';
import '../screens/auth/splash_screen.dart';
import '../screens/auth/intro_screen.dart';
import '../screens/auth/sign_in_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/sub_profile/notification_setting_screen.dart';
import '../screens/sub_profile/setting_screen.dart';
import '../screens/sub_profile/order_history_screen.dart';
import '../screens/sub_profile/subscription_screen.dart';
import '../screens/sub_profile/your_payment_screen.dart';

class AppRoutes {
  AppRoutes._();

  /// Main app routes
  static const String splash = '/';
  static const String intro = '/intro';
  static const String signIn = '/signIn';
  static const String home = '/home';
  static const String myAccount = '/myAccount';
  static const String settingScreen = '/settingScreen';
  static const String notificationSettingScreen = '/notificationSettingScreen';
  static const String yourPaymentScreen = '/yourPaymentScreen';
  static const String subscriptionScreen = '/subscriptionScreen';
  static const String myOrderScreen = '/myOrderScreen';

  /// Generate routes for the app
  static Map<String, WidgetBuilder> get routes => {
    splash: (context) => const SplashScreen(),
    intro: (context) => const IntroScreen(),
    home: (context) => const BottomNavigationScreen(),
    myAccount: (context) => const MyAccountScreen(),
    settingScreen: (context) => const SettingScreen(),
    notificationSettingScreen: (context) => const NotificationSettingScreen(),
    myOrderScreen: (context) => const OrderHistoryScreen(),
    subscriptionScreen: (context) => const SubscriptionScreen(),
    yourPaymentScreen: (context) => const YourPaymentScreen(),
  };

  /// Generate routes with arguments support
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: settings,
        );

      case intro:
        return MaterialPageRoute(
          builder: (context) => const IntroScreen(),
          settings: settings,
        );

      case signIn:
        return MaterialPageRoute(
          builder: (context) => const SignInScreen(),
          settings: settings,
        );

      case home:
        return MaterialPageRoute(
          builder: (context) => const BottomNavigationScreen(),
          settings: settings,
        );

      case myAccount:
        return MaterialPageRoute(
          builder: (context) => const MyAccountScreen(),
          settings: settings,
        );

      case settingScreen:
        return MaterialPageRoute(
          builder: (context) => const SettingScreen(),
          settings: settings,
        );

      case notificationSettingScreen:
        return MaterialPageRoute(
          builder: (context) => const NotificationSettingScreen(),
          settings: settings,
        );

      case myOrderScreen:
        return MaterialPageRoute(
          builder: (context) => const OrderHistoryScreen(),
          settings: settings,
        );

      case subscriptionScreen:
        return MaterialPageRoute(
          builder: (context) => const SubscriptionScreen(),
          settings: settings,
        );

      case yourPaymentScreen:
        return MaterialPageRoute(
          builder: (context) => const YourPaymentScreen(),
          settings: settings,
        );

      /// Default route
      default:
        return MaterialPageRoute(
          builder: (context) => _PlaceholderScreen(title: AppStrings.pageNotFound),
          settings: settings,
        );
    }
  }

  /// Navigate to a route
  static Future<T?> push<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamed<T>(context, routeName, arguments: arguments);
  }

  /// Navigate to a route and replace current
  static Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
    TO? result,
  }) {
    return Navigator.pushReplacementNamed<T, TO>(
      context,
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  /// Navigate to a route and clear stack
  static Future<T?> pushAndClearStack<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamedAndRemoveUntil<T>(
      context,
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  /// Navigate to a route and remove until
  static Future<T?> pushAndRemoveUntil<T extends Object?>(
    BuildContext context,
    String routeName,
    RoutePredicate predicate, {
    Object? arguments,
  }) {
    return Navigator.pushNamedAndRemoveUntil<T>(
      context,
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  /// Pop current route
  static void pop<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.pop<T>(context, result);
  }

  /// Pop until specific route
  static void popUntil(BuildContext context, String routeName) {
    Navigator.popUntil(context, ModalRoute.withName(routeName));
  }

  /// Pop to root
  static void popToRoot(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  /// Check if route exists
  static bool routeExists(String routeName) {
    return routes.containsKey(routeName);
  }

  /// Get all available routes
  static List<String> getAllRoutes() {
    return routes.keys.toList();
  }
}

/// Placeholder widget for routes that haven't been implemented yet
class _PlaceholderScreen extends StatelessWidget {
  final String title;

  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: MText(
          msg: AppStrings.unknownScreen,
          textColor: Theme.of(context).colorScheme.primary,
          textSize: 20,
          textWeight: FontWeight.w500,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.construction,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
              VerticalSpacing(height: 16),
              MText(
                msg: title,
                textColor: Theme.of(context).colorScheme.primary,
                textAlign: TextAlign.center,
              ),
              VerticalSpacing(height: 16),
              SText(
                msg: AppStrings.thisScreenIsInderConstruction,
                textColor: Theme.of(context).colorScheme.tertiary,
                textSize: 15,
                textAlign: TextAlign.center,
              ),
              VerticalSpacing(height: 25),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: SText(
                  msg: AppStrings.goBack,
                  textColor: Theme.of(context).colorScheme.tertiary,
                  textSize: 15,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

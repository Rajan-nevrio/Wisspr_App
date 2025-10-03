import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisspr_app/providers/auth/sign_in_provider.dart';
import 'package:wisspr_app/providers/auth/splash_provider.dart';
import 'package:wisspr_app/providers/auth/my_account_provider.dart';
import 'package:wisspr_app/providers/dashboard/dashboard_provider.dart';
import 'package:wisspr_app/providers/dashboard/botton_navigation_providers/profile_provider.dart';
import 'package:wisspr_app/providers/sub_profile/notification_setting_provider.dart';
import 'package:wisspr_app/resources/app_strings.dart';
import 'commom_widgets/customer_text/marcellus_font_type_text.dart';
import 'theme/app_theme.dart';
import 'utils/shared_preferences_helper.dart';
import 'utils/performance_helper.dart';
import 'routes/app_routes.dart';
import 'providers/auth/intro_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

String appVersion = "Version 1.0";
String serverBaseUrl = "https://wisspr.nevrio.tech/api";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrintRebuildDirtyWidgets = false;
  await SharedPreferencesHelper.init();
  PerformanceHelper.startMonitoring();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => IntroProvider()),
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => MyAccountProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => NotificationSettingProvider()),
        ChangeNotifierProvider(create: (_) => DashBoardProvider()),
      ],
      child: MaterialApp(
        theme: AppTheme.whiteTheme,
        initialRoute: AppRoutes.splash,
        routes: AppRoutes.routes,
        onGenerateRoute: AppRoutes.generateRoute,
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return RepaintBoundary(child: child!);
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: Center(
                child: MText(
                  msg: AppStrings.pageNotFound,
                  textSize: 22,
                  textColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
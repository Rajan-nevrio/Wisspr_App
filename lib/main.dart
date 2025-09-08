import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'utils/shared_preferences_helper.dart';
import 'utils/performance_helper.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrintRebuildDirtyWidgets = false;
  await SharedPreferencesHelper.init();
  PerformanceHelper.startMonitoring();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
      },
    );
  }
}

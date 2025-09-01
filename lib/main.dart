import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/responsive_home_page.dart';
import 'theme/responsive_theme.dart';
import 'theme/theme_notifier.dart';
import 'services/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize local storage
  await LocalStorageService.init();
  
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);
    
    return MaterialApp(
      title: 'Responsive Flutter App',
      debugShowCheckedModeBanner: false,
      theme: ResponsiveTheme.getLightTheme(context),
      darkTheme: ResponsiveTheme.getDarkTheme(context),
      themeMode: themeMode,
      home: const ResponsiveHomePage(),
    ); 
  }
}

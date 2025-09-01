// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:wisspr_app/main.dart';
import 'package:wisspr_app/theme/theme_provider.dart';

void main() {
  testWidgets('App can be created without errors', (WidgetTester tester) async {
    // This test just verifies that the app can be created without throwing exceptions
    // It's a basic smoke test to ensure the app structure is valid
    
    // Create the app with provider and pump it
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: const MyApp(),
      ),
    );
    
    // If we get here without exceptions, the test passes
    // The test framework will catch any build errors automatically
  });
}

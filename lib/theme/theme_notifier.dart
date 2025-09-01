import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_notifier.g.dart';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  ThemeMode build() => ThemeMode.system;
  
  void setThemeMode(ThemeMode mode) {
    state = mode;
  }
  
  void toggleTheme() {
    if (state == ThemeMode.light) {
      state = ThemeMode.dark;
    } else if (state == ThemeMode.dark) {
      state = ThemeMode.light;
    } else {
      // If system, toggle to light
      state = ThemeMode.light;
    }
  }
  
  bool get isDarkMode {
    if (state == ThemeMode.system) {
      return WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
    }
    return state == ThemeMode.dark;
  }
  
  // Get current theme-aware colors
  Color getBackgroundColor(BuildContext context) {
    return state == ThemeMode.dark 
        ? const Color(0xFF000000) // darkBackground
        : const Color(0xFFF8F9FA); // lightBackground
  }
  
  Color getSurfaceColor(BuildContext context) {
    return state == ThemeMode.dark 
        ? const Color(0xFF1A1A1A) // darkSurface
        : const Color(0xFFFFFFFF); // lightSurface
  }
  
  Color getTextPrimaryColor(BuildContext context) {
    return state == ThemeMode.dark 
        ? const Color(0xFFFFFFFF) // darkTextPrimary
        : const Color(0xFF212529); // lightTextPrimary
  }
  
  Color getTextSecondaryColor(BuildContext context) {
    return state == ThemeMode.dark 
        ? const Color(0xFFCCCCCC) // darkTextSecondary
        : const Color(0xFF6C757D); // lightTextSecondary
  }
  
  Color getTextInactiveColor(BuildContext context) {
    return state == ThemeMode.dark 
        ? const Color(0xFF666666) // darkTextInactive
        : const Color(0xFFADB5BD); // lightTextInactive
  }
  
  Color getNavigationBarColor(BuildContext context) {
    return state == ThemeMode.dark 
        ? const Color(0xFF2A2A2A) // darkNavigationBar
        : const Color(0xFFE9ECEF); // lightNavigationBar
  }
  
  // Get accent colors
  Color get primaryGold => const Color(0xFFFFD700);
  Color get accentRed => const Color(0xFFFF4444);
}


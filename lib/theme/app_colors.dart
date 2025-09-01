import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryGold = Color(0xFFFFD700);
  static const Color primaryGoldDark = Color(0xFFB8860B);
  static const Color accentRed = Color(0xFFFF4444);
  static const Color accentRedDark = Color(0xFFCC3333);

  static const Color darkBackground = Color(0xFF000000);
  static const Color darkSurface = Color(0xFF1A1A1A);
  static const Color darkNavigationBar = Color(0xFF2A2A2A);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFCCCCCC);
  static const Color darkTextInactive = Color(0xFF666666);

  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightNavigationBar = Color(0xFFE9ECEF);
  static const Color lightTextPrimary = Color(0xFF212529);
  static const Color lightTextSecondary = Color(0xFF6C757D);
  static const Color lightTextInactive = Color(0xFFADB5BD);

  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? darkBackground 
        : lightBackground;
  }
  
  static Color getSurfaceColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? darkSurface 
        : lightSurface;
  }
  
  static Color getTextPrimaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? darkTextPrimary 
        : lightTextPrimary;
  }
  
  static Color getTextSecondaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? darkTextSecondary 
        : lightTextSecondary;
  }
  
  static Color getTextInactiveColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? darkTextInactive 
        : lightTextInactive;
  }
  
  static Color getNavigationBarColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? darkNavigationBar 
        : lightNavigationBar;
  }
}

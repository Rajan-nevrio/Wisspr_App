import 'package:flutter/material.dart';

class AppTheme {
  static const Color _white = Color(0xFFFFFFFF);
  static const Color _black = Color(0xFF0D0D0C);
  static const Color _lightBlack = Color(0xFF2C2C2C);
  static const Color _grey = Color(0xFF999793);
  static const Color _red = Color(0xFFE52E2E);
  static const Color _darkGold = Color(0xFFCC9F29);
  static const Color _gold = Color(0xFFFFD859);
  static const Color _green = Color(0xFF089908);
  static const Color _lightGrey = Color(0xFFBFBDB8);
  static const Color _lighterGrey = Color(0xFFE6E4DD);
  static const Color _transparent = Color(0x00000000);

  /// White theme.
  static ThemeData get whiteTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      surface: _lightBlack,
      primary: _white,
      secondary: _lightGrey,
      tertiary: _grey,
      shadow: _transparent,
      onSecondary: _lighterGrey,
      secondaryFixed: _darkGold,
      primaryFixed: _gold,
      error: _red,
      scrim: _green,
    ),
    scaffoldBackgroundColor: _black,
  );
}

import 'package:flutter/material.dart';
import '../utils/responsive_dimensions.dart';
import 'app_colors.dart';

class ResponsiveTheme {
  static ThemeData getLightTheme(BuildContext context) {
    ResponsiveDimensions.init(context);
    
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(

        surface: AppColors.lightSurface,
        primary: AppColors.primaryGold,
        secondary: AppColors.accentRed,

        onSurface: AppColors.lightTextPrimary,
        onPrimary: AppColors.lightTextPrimary,
        onSecondary: AppColors.lightTextPrimary,
        error: AppColors.accentRed,
        onError: AppColors.lightTextPrimary,
      ),
      
      // Responsive text theme
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: ResponsiveDimensions.h1Size,
          fontWeight: FontWeight.bold,
          height: 1.2,
          color: AppColors.lightTextPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: ResponsiveDimensions.h2Size,
          fontWeight: FontWeight.w600,
          height: 1.3,
          color: AppColors.lightTextPrimary,
        ),
        displaySmall: TextStyle(
          fontSize: ResponsiveDimensions.h3Size,
          fontWeight: FontWeight.w600,
          height: 1.4,
          color: AppColors.lightTextPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: ResponsiveDimensions.bodySize,
          height: 1.5,
          color: AppColors.lightTextPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: ResponsiveDimensions.bodySize * 0.9,
          height: 1.5,
          color: AppColors.lightTextSecondary,
        ),
        labelLarge: TextStyle(
          fontSize: ResponsiveDimensions.buttonTextSize,
          fontWeight: FontWeight.w600,
          color: AppColors.lightTextPrimary,
        ),
        labelMedium: TextStyle(
          fontSize: ResponsiveDimensions.captionSize,
          color: AppColors.lightTextSecondary,
        ),
      ),
      
      // Responsive app bar theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: ResponsiveDimensions.isMobile,
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        titleTextStyle: TextStyle(
          fontSize: ResponsiveDimensions.h3Size,
          fontWeight: FontWeight.w600,
          color: AppColors.lightTextPrimary,
        ),
        toolbarHeight: ResponsiveDimensions.appBarHeight,
      ),
      
      // Responsive card theme
      cardTheme: CardThemeData(
        elevation: 2,
        color: AppColors.lightSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ResponsiveDimensions.cardRadius),
        ),
        margin: EdgeInsets.all(ResponsiveDimensions.getPadding(2)),
      ),
      
      // Responsive button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGold,
          foregroundColor: AppColors.lightTextPrimary,
          minimumSize: Size(
            ResponsiveDimensions.getWidth(40),
            ResponsiveDimensions.buttonHeight,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveDimensions.getPadding(2)),
          ),
          textStyle: TextStyle(
            fontSize: ResponsiveDimensions.buttonTextSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryGold,
          side: BorderSide(color: AppColors.primaryGold),
          minimumSize: Size(
            ResponsiveDimensions.getWidth(40),
            ResponsiveDimensions.buttonHeight,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveDimensions.getPadding(2)),
          ),
          textStyle: TextStyle(
            fontSize: ResponsiveDimensions.buttonTextSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryGold,
          minimumSize: Size(
            ResponsiveDimensions.getWidth(20),
            ResponsiveDimensions.buttonHeight,
          ),
          textStyle: TextStyle(
            fontSize: ResponsiveDimensions.buttonTextSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Responsive input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveDimensions.getPadding(2)),
          borderSide: BorderSide(color: AppColors.lightTextInactive),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveDimensions.getPadding(2)),
          borderSide: BorderSide(color: AppColors.lightTextInactive),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveDimensions.getPadding(2)),
          borderSide: BorderSide(color: AppColors.primaryGold),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: ResponsiveDimensions.getPadding(3),
          vertical: ResponsiveDimensions.getPadding(2),
        ),
        labelStyle: TextStyle(
          fontSize: ResponsiveDimensions.bodySize,
          color: AppColors.lightTextSecondary,
        ),
        hintStyle: TextStyle(
          fontSize: ResponsiveDimensions.bodySize,
          color: AppColors.lightTextInactive,
        ),
      ),
      
      // Responsive icon theme
      iconTheme: IconThemeData(
        size: ResponsiveDimensions.iconSize,
        color: AppColors.lightTextSecondary,
      ),
      
      // Responsive divider theme
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: ResponsiveDimensions.getHeight(2),
        color: AppColors.lightTextInactive,
      ),
      
      // Responsive list tile theme
      listTileTheme: ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(
          horizontal: ResponsiveDimensions.getPadding(3),
          vertical: ResponsiveDimensions.getPadding(1),
        ),
        minVerticalPadding: ResponsiveDimensions.getPadding(1),
        textColor: AppColors.lightTextPrimary,
        iconColor: AppColors.lightTextSecondary,
      ),
      
      // Scaffold background
      scaffoldBackgroundColor: AppColors.lightBackground,
      
      // Bottom navigation bar theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightNavigationBar,
        selectedItemColor: AppColors.primaryGold,
        unselectedItemColor: AppColors.lightTextInactive,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
  
  static ThemeData getDarkTheme(BuildContext context) {
    ResponsiveDimensions.init(context);
    
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        surface: AppColors.darkSurface,
        primary: AppColors.primaryGold,
        secondary: AppColors.accentRed,
        onSurface: AppColors.darkTextPrimary,
        onPrimary: AppColors.darkTextPrimary,
        onSecondary: AppColors.darkTextPrimary,
        error: AppColors.accentRed,
        onError: AppColors.darkTextPrimary,
      ),
      
      // Responsive text theme for dark mode
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: ResponsiveDimensions.h1Size,
          fontWeight: FontWeight.bold,
          height: 1.2,
          color: AppColors.darkTextPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: ResponsiveDimensions.h2Size,
          fontWeight: FontWeight.w600,
          height: 1.3,
          color: AppColors.darkTextPrimary,
        ),
        displaySmall: TextStyle(
          fontSize: ResponsiveDimensions.h3Size,
          fontWeight: FontWeight.w600,
          height: 1.4,
          color: AppColors.darkTextPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: ResponsiveDimensions.bodySize,
          height: 1.5,
          color: AppColors.darkTextPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: ResponsiveDimensions.bodySize * 0.9,
          height: 1.5,
          color: AppColors.darkTextSecondary,
        ),
        labelLarge: TextStyle(
          fontSize: ResponsiveDimensions.buttonTextSize,
          fontWeight: FontWeight.w600,
          color: AppColors.darkTextPrimary,
        ),
        labelMedium: TextStyle(
          fontSize: ResponsiveDimensions.captionSize,
          color: AppColors.darkTextSecondary,
        ),
      ),
      
      // Responsive app bar theme for dark mode
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: ResponsiveDimensions.isMobile,
        backgroundColor: AppColors.darkSurface,
        foregroundColor: AppColors.darkTextPrimary,
        titleTextStyle: TextStyle(
          fontSize: ResponsiveDimensions.h3Size,
          fontWeight: FontWeight.w600,
          color: AppColors.darkTextPrimary,
        ),
        toolbarHeight: ResponsiveDimensions.appBarHeight,
      ),
      
      // Responsive card theme for dark mode
      cardTheme: CardThemeData(
        elevation: 2,
        color: AppColors.darkSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ResponsiveDimensions.cardRadius),
        ),
        margin: EdgeInsets.all(ResponsiveDimensions.getPadding(2)),
      ),
      
      // Responsive button themes for dark mode
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGold,
          foregroundColor: AppColors.darkTextPrimary,
          minimumSize: Size(
            ResponsiveDimensions.getWidth(40),
            ResponsiveDimensions.buttonHeight,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveDimensions.getPadding(2)),
          ),
          textStyle: TextStyle(
            fontSize: ResponsiveDimensions.buttonTextSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryGold,
          side: BorderSide(color: AppColors.primaryGold),
          minimumSize: Size(
            ResponsiveDimensions.getWidth(40),
            ResponsiveDimensions.buttonHeight,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveDimensions.getPadding(2)),
          ),
          textStyle: TextStyle(
            fontSize: ResponsiveDimensions.buttonTextSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryGold,
          minimumSize: Size(
            ResponsiveDimensions.getWidth(20),
            ResponsiveDimensions.buttonHeight,
          ),
          textStyle: TextStyle(
            fontSize: ResponsiveDimensions.buttonTextSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Responsive input decoration theme for dark mode
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveDimensions.getPadding(2)),
          borderSide: BorderSide(color: AppColors.darkTextInactive),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveDimensions.getPadding(2)),
          borderSide: BorderSide(color: AppColors.darkTextInactive),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveDimensions.getPadding(2)),
          borderSide: BorderSide(color: AppColors.primaryGold),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: ResponsiveDimensions.getPadding(3),
          vertical: ResponsiveDimensions.getPadding(2),
        ),
        labelStyle: TextStyle(
          fontSize: ResponsiveDimensions.bodySize,
          color: AppColors.darkTextSecondary,
        ),
        hintStyle: TextStyle(
          fontSize: ResponsiveDimensions.bodySize,
          color: AppColors.darkTextInactive,
        ),
      ),
      
      // Responsive icon theme for dark mode
      iconTheme: IconThemeData(
        size: ResponsiveDimensions.iconSize,
        color: AppColors.darkTextSecondary,
      ),
      
      // Responsive divider theme for dark mode
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: ResponsiveDimensions.getHeight(2),
        color: AppColors.darkTextInactive,
      ),
      
      // Responsive list tile theme for dark mode
      listTileTheme: ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(
          horizontal: ResponsiveDimensions.getPadding(3),
          vertical: ResponsiveDimensions.getPadding(1),
        ),
        minVerticalPadding: ResponsiveDimensions.getPadding(1),
        textColor: AppColors.darkTextPrimary,
        iconColor: AppColors.darkTextSecondary,
      ),
      
      // Scaffold background
      scaffoldBackgroundColor: AppColors.darkBackground,
      
      // Bottom navigation bar theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkNavigationBar,
        selectedItemColor: AppColors.primaryGold,
        unselectedItemColor: AppColors.darkTextInactive,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}

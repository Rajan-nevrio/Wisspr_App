import 'package:flutter/material.dart';

class ResponsiveDimensions {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;
  static late double statusBarHeight;
  static late double bottomPadding;
  static late double topPadding;
  static late double textScaleFactor;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _safeAreaHorizontal = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical = _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
    statusBarHeight = _mediaQueryData.padding.top;
    bottomPadding = _mediaQueryData.padding.bottom;
    topPadding = _mediaQueryData.padding.top;
    textScaleFactor = _mediaQueryData.textScaleFactor;
  }

  // Responsive font sizes
  static double getFontSize(double size) {
    return size * blockSizeHorizontal * 0.5;
  }

  // Responsive padding and margins
  static double getPadding(double size) {
    return size * blockSizeHorizontal * 0.5;
  }

  static double getMargin(double size) {
    return size * blockSizeHorizontal * 0.5;
  }

  // Responsive height and width
  static double getHeight(double size) {
    return size * blockSizeVertical;
  }

  static double getWidth(double size) {
    return size * blockSizeHorizontal;
  }

  // Safe area aware dimensions
  static double getSafeHeight(double size) {
    return size * safeBlockVertical;
  }

  static double getSafeWidth(double size) {
    return size * safeBlockHorizontal;
  }

  // Device type detection
  static bool get isMobile => screenWidth < 600;
  static bool get isTablet => screenWidth >= 600 && screenWidth < 1200;
  static bool get isDesktop => screenWidth >= 1200;

  // Orientation detection
  static bool get isPortrait => screenHeight > screenWidth;
  static bool get isLandscape => screenWidth > screenHeight;

  // Common responsive values
  static double get appBarHeight => getHeight(8);
  static double get bottomNavHeight => getHeight(10);
  static double get cardRadius => getWidth(2);
  static double get buttonHeight => getHeight(6);
  static double get iconSize => getWidth(6);
  
  // Text sizes
  static double get h1Size => getFontSize(8);
  static double get h2Size => getFontSize(6);
  static double get h3Size => getFontSize(5);
  static double get bodySize => getFontSize(4);
  static double get captionSize => getFontSize(3);
  static double get buttonTextSize => getFontSize(4);
}

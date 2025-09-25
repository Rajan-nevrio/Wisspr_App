import 'package:flutter/material.dart';

class ResponsiveDimensions {
  static final ResponsiveDimensions _instance = ResponsiveDimensions._internal();
  factory ResponsiveDimensions() => _instance;
  ResponsiveDimensions._internal();

  late double screenWidth;
  late double screenHeight;
  late double _widthScale;
  late double _heightScale;
  late double _fontScale;
  bool _isInitialized = false;

  /// Base design (reference: iPhone 12 Pro)
  static const double _baseWidth = 390.0;
  static const double _baseHeight = 844.0;

  void init(BuildContext context) {
    if (_isInitialized) return;

    final mq = MediaQuery.of(context);
    screenWidth = mq.size.width;
    screenHeight = mq.size.height;

    _widthScale = screenWidth / _baseWidth;
    _heightScale = screenHeight / _baseHeight;
    _fontScale = (_widthScale + _heightScale) / 2;

    _isInitialized = true;
  }

  double width(double value) => value * _widthScale;
  double height(double value) => value * _heightScale;
  double fontSize(double value) => value * _fontScale;
}

/// Easy extension
extension ResponsiveExtension on BuildContext {
  ResponsiveDimensions get responsive => ResponsiveDimensions()..init(this);
}

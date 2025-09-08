import 'package:flutter/material.dart';

class ResponsiveDimensions {
  // Singleton pattern to ensure single instance
  static final ResponsiveDimensions _instance = ResponsiveDimensions._internal();
  factory ResponsiveDimensions() => _instance;
  ResponsiveDimensions._internal();

  // Screen dimensions
  late double screenWidth;
  late double screenHeight;
  late double devicePixelRatio;
  late Orientation orientation;

  // Cached scaling factors for performance
  late double _widthScale;
  late double _heightScale;
  late double _fontScale;
  late bool _isInitialized = false;

  // Base dimensions for reference (iPhone 12 Pro dimensions as base)
  static const double _baseWidth = 390.0;
  static const double _baseHeight = 844.0;

  // Initialize with MediaQuery
  void init(BuildContext context) {
    if (_isInitialized) return; // Avoid re-initialization
    
    final mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
    devicePixelRatio = mediaQuery.devicePixelRatio;
    orientation = mediaQuery.orientation;
    
    // Pre-calculate scaling factors
    _widthScale = screenWidth / _baseWidth;
    _heightScale = screenHeight / _baseHeight;
    _fontScale = (_widthScale + _heightScale) / 2;
    _isInitialized = true;
  }

  // Width scaling factor
  double get widthScale => _widthScale;

  // Height scaling factor
  double get heightScale => _heightScale;

  // Font scale factor (average of width and height scale)
  double get fontScale => _fontScale;

  // Responsive width (scales with screen width)
  double width(double width) => width * widthScale;

  // Responsive height (scales with screen height)
  double height(double value) => value * heightScale;

  // Responsive font size (scales with average of width and height)
  double fontSize(double size) => size * fontScale;

  // Responsive padding (scales with screen width)
  double padding(double value) => value * widthScale;

  // Responsive margin (scales with screen width)
  double margin(double value) => value * widthScale;

  // Responsive border radius (scales with screen width)
  double radius(double value) => value * widthScale;

  // Responsive icon size (scales with screen width)
  double iconSize(double value) => value * widthScale;

  // Responsive spacing (scales with screen width)
  double spacing(double value) => value * widthScale;

  // Get responsive EdgeInsets
  EdgeInsets paddingAll(double padding) => EdgeInsets.all(this.padding(padding));
  EdgeInsets paddingHorizontal(double padding) => EdgeInsets.symmetric(horizontal: this.padding(padding));
  EdgeInsets paddingVertical(double padding) => EdgeInsets.symmetric(vertical: this.padding(padding));
  EdgeInsets paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => EdgeInsets.only(
    left: padding(left),
    top: padding(top),
    right: padding(right),
    bottom: padding(bottom),
  );

  // Get responsive SizedBox
  SizedBox sizedBox({double? width, double? height}) => SizedBox(
    width: width != null ? this.width(width) : null,
    height: height != null ? this.height(height) : null,
  );

  // Get responsive BorderRadius
  BorderRadius borderRadius(double radius) => BorderRadius.circular(this.radius(radius));
  BorderRadius borderRadiusOnly({
    double topLeft = 0,
    double topRight = 0,
    double bottomLeft = 0,
    double bottomRight = 0,
  }) => BorderRadius.only(
    topLeft: Radius.circular(radius(topLeft)),
    topRight: Radius.circular(radius(topRight)),
    bottomLeft: Radius.circular(radius(bottomLeft)),
    bottomRight: Radius.circular(radius(bottomRight)),
  );

  // Device type detection
  bool get isTablet => screenWidth >= 768;
  bool get isPhone => screenWidth < 768;
  bool get isSmallPhone => screenWidth < 360;
  bool get isLargePhone => screenWidth >= 414;

  // Orientation helpers
  bool get isPortrait => orientation == Orientation.portrait;
  bool get isLandscape => orientation == Orientation.landscape;

  // Safe area helpers (requires context)
  double safeAreaTop(BuildContext context) => MediaQuery.of(context).padding.top;
  double safeAreaBottom(BuildContext context) => MediaQuery.of(context).padding.bottom;
  double safeAreaLeft(BuildContext context) => MediaQuery.of(context).padding.left;
  double safeAreaRight(BuildContext context) => MediaQuery.of(context).padding.right;

  // Common responsive dimensions
  static const double _xs = 4.0;
  static const double _sm = 8.0;
  static const double _md = 16.0;
  static const double _lg = 24.0;
  static const double _xl = 32.0;
  static const double _xxl = 48.0;

  // Predefined responsive values
  double get xs => padding(_xs);
  double get sm => padding(_sm);
  double get md => padding(_md);
  double get lg => padding(_lg);
  double get xl => padding(_xl);
  double get xxl => padding(_xxl);

  // Common font sizes
  static const double _fontXs = 12.0;
  static const double _fontSm = 14.0;
  static const double _fontMd = 16.0;
  static const double _fontLg = 18.0;
  static const double _fontXl = 20.0;
  static const double _fontXxl = 24.0;
  static const double _fontTitle = 28.0;
  static const double _fontHeadline = 32.0;

  // Predefined responsive font sizes
  double get fontXs => fontSize(_fontXs);
  double get fontSm => fontSize(_fontSm);
  double get fontMd => fontSize(_fontMd);
  double get fontLg => fontSize(_fontLg);
  double get fontXl => fontSize(_fontXl);
  double get fontXxl => fontSize(_fontXxl);
  double get fontTitle => fontSize(_fontTitle);
  double get fontHeadline => fontSize(_fontHeadline);

  // Common icon sizes
  static const double _iconSm = 16.0;
  static const double _iconMd = 24.0;
  static const double _iconLg = 32.0;
  static const double _iconXl = 48.0;

  // Predefined responsive icon sizes
  double get iconSm => iconSize(_iconSm);
  double get iconMd => iconSize(_iconMd);
  double get iconLg => iconSize(_iconLg);
  double get iconXl => iconSize(_iconXl);

  // Breakpoints for different device categories
  static const double _breakpointSmall = 360;
  static const double _breakpointMedium = 414;
  static const double _breakpointLarge = 768;

  // Device category helpers
  bool get isSmallDevice => screenWidth < _breakpointSmall;
  bool get isMediumDevice => screenWidth >= _breakpointSmall && screenWidth < _breakpointMedium;
  bool get isLargeDevice => screenWidth >= _breakpointMedium && screenWidth < _breakpointLarge;
  bool get isXLargeDevice => screenWidth >= _breakpointLarge;

  // Responsive grid columns
  int get gridColumns {
    if (isSmallDevice) return 1;
    if (isMediumDevice) return 2;
    if (isLargeDevice) return 3;
    return 4;
  }

  // Responsive card width
  double get cardWidth {
    if (isPhone) return screenWidth - (md * 2);
    return width(300);
  }

  // Responsive button height
  double get buttonHeight => height(48);

  // Responsive app bar height
  double get appBarHeight => height(56);

  // Responsive bottom navigation height
  double get bottomNavHeight => height(60);

  // Responsive floating action button size
  double get fabSize => width(56);

  // Responsive drawer width
  double get drawerWidth => width(280);

  // Responsive list tile height
  double get listTileHeight => height(72);

  // Responsive chip height
  double get chipHeight => height(32);

  // Responsive divider thickness
  double get dividerThickness => 0.5;

  // Responsive elevation
  double get cardElevation => 2.0;
  double get buttonElevation => 1.0;
  double get fabElevation => 6.0;

  // Responsive animation duration
  Duration get shortAnimation => const Duration(milliseconds: 200);
  Duration get mediumAnimation => const Duration(milliseconds: 300);
  Duration get longAnimation => const Duration(milliseconds: 500);

  // Responsive curve
  Curve get defaultCurve => Curves.easeInOut;
  Curve get fastCurve => Curves.easeIn;
  Curve get slowCurve => Curves.easeOut;

  // Debug information
  Map<String, dynamic> get debugInfo => {
    'screenWidth': screenWidth,
    'screenHeight': screenHeight,
    'widthScale': widthScale,
    'heightScale': heightScale,
    'fontScale': fontScale,
    'orientation': orientation.toString(),
    'isTablet': isTablet,
    'isPhone': isPhone,
    'deviceType': isTablet ? 'Tablet' : 'Phone',
  };
}

// Extension for easy access
extension ResponsiveDimensionsExtension on BuildContext {
  ResponsiveDimensions get responsive => ResponsiveDimensions()..init(this);
}

// Helper class for common responsive widgets
class ResponsiveWidgets {
  // Responsive Container
  static Widget container({
    required BuildContext context,
    required Widget child,
    double? width,
    double? height,
    EdgeInsets? padding,
    EdgeInsets? margin,
    double? borderRadius,
    Color? color,
    BoxDecoration? decoration,
  }) {
    final responsive = ResponsiveDimensions()..init(context);
    return Container(
      width: width != null ? responsive.width(width) : null,
      height: height != null ? responsive.height(height) : null,
      padding: padding != null ? responsive.paddingAll(padding.left) : null,
      margin: margin != null ? responsive.paddingAll(margin.left) : null,
      decoration: decoration ?? BoxDecoration(
        color: color,
        borderRadius: borderRadius != null ? responsive.borderRadius(borderRadius) : null,
      ),
      child: child,
    );
  }

  // Responsive Text
  static Widget text(
    String text, {
    required BuildContext context,
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    final responsive = ResponsiveDimensions()..init(context);
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize != null ? responsive.fontSize(fontSize) : responsive.fontMd,
        fontWeight: fontWeight,
        color: color,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  // Responsive Button
  static Widget button({
    required BuildContext context,
    required String text,
    required VoidCallback onPressed,
    double? width,
    double? height,
    Color? backgroundColor,
    Color? textColor,
    double? borderRadius,
    EdgeInsets? padding,
  }) {
    final responsive = ResponsiveDimensions()..init(context);
    return SizedBox(
      width: width != null ? responsive.width(width) : null,
      height: height ?? responsive.buttonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: responsive.borderRadius(borderRadius ?? 8),
          ),
          padding: padding != null ? responsive.paddingAll(padding.left) : null,
        ),
        child: ResponsiveWidgets.text(
          text,
          context: context,
          fontSize: responsive.fontMd,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

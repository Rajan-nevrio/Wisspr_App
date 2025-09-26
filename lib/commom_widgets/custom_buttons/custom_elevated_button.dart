import 'package:flutter/material.dart';

import '../../utils/responsive_dimensions.dart';
import '../customer_text/satoshi_font_type_text.dart';

class CustomElevatedButton extends StatelessWidget {
  final double? width;
  final double? height;
  final double? textSize;
  final String buttonName;
  final void Function() onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? textColor;

  const CustomElevatedButton({super.key,
    this.height,
    this.width,
    this.textSize,
    required this.buttonName,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final r = ResponsiveDimensions()..init(context);

    return SizedBox(
      width: width ?? r.screenWidth,
      height: height ?? r.height(56),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
          foregroundColor: foregroundColor ?? Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 0,
        ),
        child: Center(
          child: SText(
            msg: buttonName,
            textAlign: TextAlign.center,
            textSize: textSize ?? r.fontSize(18),
            textWeight: FontWeight.w500,
            textColor: textColor ?? Theme.of(context).scaffoldBackgroundColor,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

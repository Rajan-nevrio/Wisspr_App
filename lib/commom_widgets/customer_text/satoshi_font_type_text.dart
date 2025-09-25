import 'package:flutter/material.dart';
import 'package:wisspr_app/utils/responsive_dimensions.dart';
import '../../resources/font_constants.dart';

class SText extends StatelessWidget {
  final String msg;
  final double? textSize;
  final Color? textColor;
  final FontWeight? textWeight;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final FontStyle? fontStyle;
  final int? maxLines;
  final TextAlign? textAlign;
  final double? letterSpacing;
  final double? height;
  final double? decorationThickness;
  final Color? decorationColor;

  const SText({super.key,
    required this.msg,
    this.textSize,
    this.textColor,
    this.textWeight,
    this.overflow,
    this.decoration,
    this.fontStyle,
    this.textAlign,
    this.maxLines,
    this.letterSpacing,
    this.height,
    this.decorationThickness,
    this.decorationColor,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Text(msg,
      maxLines: maxLines,
      textAlign: textAlign,

      style: TextStyle(
        height: height,
        fontSize: textSize ?? r.fontSize(14),
        fontFamily: FontConstants.satoshi,
        color: textColor ?? Theme.of(context).colorScheme.primary,
        fontWeight: textWeight,
        overflow: overflow,
        decoration: decoration,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        decorationThickness: decorationThickness,
        decorationColor:decorationColor,
      ),
    );
  }
}

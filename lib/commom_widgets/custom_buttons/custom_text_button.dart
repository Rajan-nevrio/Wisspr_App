import 'package:flutter/material.dart';
import 'package:wisspr_app/utils/responsive_dimensions.dart';

import '../customer_text/satoshi_font_type_text.dart';

class CustomTextButton extends StatelessWidget {
  final void Function() onPressed;
  final String buttonName;
  final double? textSize;
  final Color? textColor;
  final FontWeight? textWeight;

  const CustomTextButton({super.key,
    required this.buttonName,
    required this.onPressed,
    this.textSize,
    this.textColor,
    this.textWeight,

  });

  @override
  Widget build(BuildContext context) {
    final r = ResponsiveDimensions()..init(context);

    return TextButton(
      onPressed: onPressed,
      child: SText(
        msg: buttonName,
        textSize: textSize ?? r.fontSize(15),
        textWeight: textWeight ?? FontWeight.w500,
        textColor: textColor ?? Theme.of(context).colorScheme.tertiary,
        textAlign: TextAlign.center,
      ),
    );
  }
}

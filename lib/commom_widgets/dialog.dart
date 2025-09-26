import 'package:flutter/material.dart';
import 'package:wisspr_app/commom_widgets/custom_buttons/custom_elevated_button.dart';
import 'package:wisspr_app/commom_widgets/custom_buttons/custom_text_button.dart';
import 'package:wisspr_app/commom_widgets/customer_text/marcellus_font_type_text.dart';
import 'package:wisspr_app/commom_widgets/customer_text/satoshi_font_type_text.dart';
import 'package:wisspr_app/resources/dimension_spacing/vertical_spacing.dart';

import '../resources/app_strings.dart';
import '../utils/responsive_dimensions.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String description;
  final String sButtonName;
  final Color? sButtonTextColor;
  final Color? sButtonColor;
  final void Function() sOnPressed;

  const CustomDialog({super.key,
    required this.title,
    required this.description,
    required this.sButtonName,
    required this.sOnPressed,
    required this.sButtonTextColor,
    required this.sButtonColor,
  });

  @override
  Widget build(BuildContext context) {
    final r = ResponsiveDimensions()..init(context);

    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: r.height(20), horizontal: r.width(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MText(
              msg: title,
              textSize: r.fontSize(18),
              textWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            ),
            VerticalSpacing(height: 8),
            Divider(color: Theme.of(context).colorScheme.tertiary.withAlpha(70)),
            VerticalSpacing(height: 8),
            SText(
              msg: description,
              textSize: r.fontSize(15),
              textColor: Theme.of(context).colorScheme.tertiary,
              textAlign: TextAlign.center,
            ),
            VerticalSpacing(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomTextButton(
                  onPressed: () => Navigator.pop(context),
                  buttonName: AppStrings.cancel,
                  textSize: r.fontSize(15),
                  textWeight: FontWeight.w500,
                  textColor: Theme.of(context).colorScheme.tertiary,
                ),
                CustomElevatedButton(
                  height: r.height(50),
                  width: r.width(170),
                  buttonName: sButtonName,
                  onPressed: sOnPressed,
                  textColor: sButtonTextColor,
                  textSize: r.fontSize(15),
                  backgroundColor: sButtonColor,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

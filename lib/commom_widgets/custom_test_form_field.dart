import 'package:flutter/material.dart';
import 'package:wisspr_app/resources/dimension_spacing/vertical_spacing.dart';
import 'package:wisspr_app/resources/font_constants.dart';

import '../utils/responsive_dimensions.dart';
import 'customer_text/marcellus_font_type_text.dart';

class CustomerTextFormField extends StatelessWidget {
  final ResponsiveDimensions dimension;
  final String header;
  final String hintText;
  final bool? enabled;
  final String? Function(String?)? validator;
  final bool? autofocus;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  const CustomerTextFormField({
    super.key,
    required this.dimension,
    required this.header,
    required this.hintText,
    this.enabled,
    this.validator,
    this.autofocus,
    this.keyboardType,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MText(
          msg: header,
          textColor: Theme.of(context).colorScheme.primary,
          textSize: dimension.fontSize(18),
          textWeight: FontWeight.w500,
        ),
        VerticalSpacing(height: dimension.height(6)),
        TextFormField(
          enabled: enabled,
          validator: validator,
          autofocus: autofocus ?? false,
          keyboardType: keyboardType,
          controller: controller,
          style: TextStyle(
            color: (enabled ?? true) ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.tertiary,
            fontSize: dimension.fontSize(16),
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: dimension.fontSize(16),
              fontFamily: FontConstants.satoshi
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
            contentPadding: EdgeInsets.symmetric(
              horizontal: dimension.width(16),
              vertical: dimension.height(14),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

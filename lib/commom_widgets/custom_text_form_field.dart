import 'package:flutter/material.dart';

import '../resources/font_constants.dart';
import '../utils/responsive_dimensions.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final ResponsiveDimensions dimension;
  final bool? enabled;
  final String? hintText;

  const CustomTextFormField({super.key, required this.controller, required this.dimension, this.enabled, this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: FontConstants.satoshi,
          color: Theme.of(context).colorScheme.tertiary,
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        contentPadding: EdgeInsets.symmetric(horizontal: dimension.width(16), vertical: dimension.height(15)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyle(
        color: (enabled ?? true) ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.tertiary,
        fontSize: dimension.fontSize(18),
        fontFamily: FontConstants.satoshi,
      ),
    );
  }
}

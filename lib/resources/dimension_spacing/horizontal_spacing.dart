import 'package:flutter/material.dart';
import 'package:wisspr_app/utils/responsive_dimensions.dart';

class HorizontalSpacing extends StatelessWidget {
  final double width;
  const HorizontalSpacing({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: context.responsive.width(width));
  }
}

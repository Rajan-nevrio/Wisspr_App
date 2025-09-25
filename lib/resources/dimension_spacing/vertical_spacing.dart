import 'package:flutter/material.dart';
import 'package:wisspr_app/utils/responsive_dimensions.dart';

class VerticalSpacing extends StatelessWidget {
  final double height;
  const VerticalSpacing({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: context.responsive.height(height));
  }
}

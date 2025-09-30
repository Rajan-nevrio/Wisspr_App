import 'package:flutter/material.dart';
import 'package:wisspr_app/utils/responsive_dimensions.dart';

class CustomSwitch extends StatelessWidget {
  final ResponsiveDimensions dimension;
  final bool value;
  final ValueChanged<bool>? onChanged;

  const CustomSwitch({
    super.key,
    required this.dimension,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onChanged != null) onChanged!(!value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: dimension.width(55),
        height: dimension.height(24),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: value
              ? Theme.of(context).colorScheme.secondaryFixed
              : Theme.of(context).colorScheme.tertiary,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: dimension.width(24),
            height: dimension.height(14),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(12)
            ),
          ),
        ),
      ),
    );
  }
}

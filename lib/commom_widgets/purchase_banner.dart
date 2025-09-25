import 'package:flutter/material.dart';

import '../resources/dimension_spacing/horizontal_spacing.dart';
import '../utils/responsive_dimensions.dart';
import 'customer_text/satoshi_font_type_text.dart';

class PurchaseBanner extends StatelessWidget {
  final ResponsiveDimensions dimension;

  const PurchaseBanner({super.key, required this.dimension});

  @override
  Widget build(BuildContext context) {
    final r = dimension;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: r.width(12)),
      height: r.height(60),
      width: r.screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(width: 0.2, color: Theme.of(context).colorScheme.tertiary),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset("assets/image/perfume_flower.jpg",
              width: r.screenWidth,
              fit: BoxFit.cover,
            ),
          ),
          /// Gradient overlay from transparent top to black bottom.
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(8), topRight: Radius.circular(8)),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Theme.of(context).colorScheme.shadow,
                    Theme.of(context).colorScheme.surface,
                    Theme.of(context).colorScheme.surface,
                  ],
                  stops: const [0.0, 0.45, 0.7],
                ),
              ),
            ),
          ),
          Positioned(
            right: r.width(20),
            top: r.height(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: r.width(170),
                  child: SText(
                    msg: "Buy Wipper Aura at a limited time discount. Lasts till 31 Aug.",
                    textSize: r.fontSize(9),
                    textColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SText(msg: "\$ 18.99",
                      textColor: Theme.of(context).colorScheme.primaryFixed,
                      textSize: r.fontSize(12),
                    ),
                    HorizontalSpacing(width: 8),
                    SText(
                      msg: "\$ 30.99",
                      textColor: Theme.of(context).colorScheme.error,
                      textSize: 9,
                      decoration: TextDecoration.lineThrough,
                      decorationThickness: 1,
                      decorationColor: Theme.of(context).colorScheme.error,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

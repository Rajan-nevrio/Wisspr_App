import 'package:flutter/material.dart';
import '../resources/dimension_spacing/horizontal_spacing.dart';
import '../resources/image_path.dart';
import '../utils/responsive_dimensions.dart';
import 'customer_text/satoshi_font_type_text.dart';

class BuyBanner extends StatelessWidget {
  final ResponsiveDimensions dimension;

  const BuyBanner({super.key, required this.dimension});

  @override
  Widget build(BuildContext context) {
    final responsive = dimension;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: responsive.width(12)),
      height: responsive.height(60),
      width: responsive.screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(width: 0.2, color: Theme.of(context).colorScheme.tertiary),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(ImgPath.perfumeFlowerImg,
              width: MediaQuery.of(context).size.width,
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
            right: responsive.width(15),
            top: responsive.height(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SText(
                      msg: "Buy Subscription",
                      textColor: Theme.of(context).colorScheme.primaryFixed,
                      textSize: responsive.fontSize(12),
                    ),
                    HorizontalSpacing(width: 5),
                    Icon(Icons.arrow_forward,
                      color: Theme.of(context).colorScheme.primaryFixed,
                      size: responsive.fontSize(13),
                    )
                  ],
                ),
                SizedBox(
                  width: responsive.width(190),
                  child: SText(
                    msg: "Subscribe for full automation & control.",
                    textSize: responsive.fontSize(9),
                    textColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

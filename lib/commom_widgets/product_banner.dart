import 'package:flutter/material.dart';
import '../resources/dimension_spacing/vertical_spacing.dart';
import '../resources/image_path.dart';
import '../utils/responsive_dimensions.dart';
import 'customer_text/marcellus_font_type_text.dart';
import 'customer_text/satoshi_font_type_text.dart';

class ProductBanner extends StatelessWidget {
  final ResponsiveDimensions dimension;
  const ProductBanner({super.key, required this.dimension});

  @override
  Widget build(BuildContext context) {
    final r = dimension;

    return Container(
      width: r.screenWidth,
      padding: EdgeInsets.only(left: r.width(20)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: r.height(500),
                width: r.screenWidth - 20,
                child: Image.asset(
                  ImgPath.hpImage,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Positioned(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    VerticalSpacing(height: 100),
                    MText(
                      msg: "Regel",
                      textSize:  r.fontSize(40),
                      textWeight: FontWeight.w400,
                      textColor: Theme.of(context).colorScheme.primary,
                      letterSpacing: 1.2,
                    ),
                    SText(
                      msg: 'Elixir',
                      textSize: r.fontSize(28),
                      textWeight: FontWeight.w300,
                      textColor: Theme.of(context).colorScheme.primary,
                      letterSpacing: 1.0,
                    ),
                    VerticalSpacing(height: 12),
                    SText(
                      msg: 'A majestic blend of luxury\nand power, fit for royalty.',
                      textAlign: TextAlign.start,
                      textSize: r.fontSize(14),
                      textColor: Theme.of(context).colorScheme.tertiary,
                      height: 1.4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../resources/dimension_spacing/vertical_spacing.dart';
import '../resources/image_path.dart';
import '../utils/responsive_dimensions.dart';
import 'customer_text/marcellus_font_type_text.dart';
import 'customer_text/satoshi_font_type_text.dart';

class RefillsCard extends StatelessWidget {
  final int index;
  final ResponsiveDimensions dimension;

  const RefillsCard({super.key, required this.dimension, required this.index});

  @override
  Widget build(BuildContext context) {
    final responsive = dimension;
    return Container(
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).scaffoldBackgroundColor.withAlpha(84),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: responsive.width(210),
                height: responsive.height(210),
              ),
              Positioned(
                top: 30,
                child: Container(
                  width: responsive.width(210),
                  height: responsive.height(190),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.surface,
                        Theme.of(context).scaffoldBackgroundColor,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: responsive.width(36),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Mirror logic: even index = text left, image right; odd index = image left, text right
                    if (index % 2 == 0) ...[
                      /// Even index: Text on left, Image on right
                      SizedBox(
                        height: responsive.height(235),
                        width: responsive.width(150),
                        child: Image.asset(
                          'assets/image/air fragrance.png',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ] else ...[
                      /// Odd index: Image on left, Text on right
                      SizedBox(
                        height: responsive.height(210),
                        width: responsive.width(125),
                        child: Image.asset(
                          'assets/image/air fragrance2.png',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          // Bottom status bar
          Container(
            height: responsive.height(60),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Container(
              width: responsive.width(210),
              padding: EdgeInsets.symmetric(vertical: responsive.height(6), horizontal: responsive.width(10)),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MText(
                        msg: 'Black Opium',
                        textColor: Theme.of(context).colorScheme.primary,
                        textSize: responsive.fontSize(15),
                        textWeight: FontWeight.w500,
                      ),
                      VerticalSpacing(height: 3),
                      SText(
                        msg: '\$150.00',
                        textColor: Theme.of(context).colorScheme.tertiary,
                        textSize: responsive.fontSize(13),
                        textWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    height: responsive.height(40),
                    width:  responsive.width(40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Center(
                      child: Image.asset(ImgPath.bagImg,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(Icons.shop,
                              size: responsive.fontSize(20),
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

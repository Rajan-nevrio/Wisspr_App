import 'package:flutter/material.dart';
import '../resources/image_path.dart';
import '../utils/responsive_dimensions.dart';
import 'customer_text/marcellus_font_type_text.dart';
import 'customer_text/satoshi_font_type_text.dart';

class VideoCard extends StatelessWidget {
  final ResponsiveDimensions dimension;

  const VideoCard({super.key, required this.dimension});

  @override
  Widget build(BuildContext context) {
    final r = dimension;

    return Container(
      width: r.width(270),
      margin: EdgeInsets.only(right: r.width(16)),
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            /// Background image.
            Positioned.fill(
              child: Image.asset(
                ImgPath.fragranceDeviceImg,
                fit: BoxFit.cover,
              ),
            ),
            /// Gradient overlay from transparent top to black bottom.
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.shadow,
                      Theme.of(context).scaffoldBackgroundColor.withAlpha(240),
                    ],
                  ),
                ),
              ),
            ),
            /// Video play icon on top.
            Positioned(
              top: r.height(16),
              right: r.width(16),
              child: Container(
                width: r.width(40),
                height: r.width(40),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.secondaryFixed,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: r.fontSize(24),
                ),
              ),
            ),
            /// Text overlay at bottom
            Positioned(
              bottom: r.height(16),
              left: r.width(16),
              right: r.width(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: r.width(8), vertical: r.height(4)),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryFixed,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: MText(
                      msg: 'Wisspr Aura',
                      textColor: Theme.of(context).scaffoldBackgroundColor,
                      textSize: r.fontSize(12),
                      textWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SText(
                    msg: 'How to connect the device with app.',
                    textColor: Theme.of(context).colorScheme.primary,
                    textSize: r.fontSize(24),
                    textWeight: FontWeight.w300,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

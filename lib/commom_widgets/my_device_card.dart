import 'package:flutter/material.dart';
import '../resources/app_strings.dart';
import '../resources/dimension_spacing/horizontal_spacing.dart';
import '../resources/dimension_spacing/vertical_spacing.dart';
import '../resources/image_path.dart';
import '../utils/responsive_dimensions.dart';
import 'customer_text/marcellus_font_type_text.dart';
import 'customer_text/satoshi_font_type_text.dart';

class MyDeviceCard extends StatefulWidget {
  final int index;
  const MyDeviceCard({super.key, required this.index});

  @override
  State<MyDeviceCard> createState() => _MyDeviceCardState();
}

class _MyDeviceCardState extends State<MyDeviceCard> {
  late ResponsiveDimensions r;

  @override
  void initState() {
    super.initState();
    r = ResponsiveDimensions();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    r.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Container(
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
            child: Padding(
              padding: EdgeInsets.only(left: r.width(16), right: r.width(16), top: r.height(12)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Mirror logic: even index = text left, image right; odd index = image left, text right
                  if (widget.index % 2 == 0) ...[
                    /// Even index: Text on left, Image on right
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: r.width(24),
                                height: r.width(24),
                                child: Image.asset(ImgPath.lowBattery,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              HorizontalSpacing(width: 8),
                              SText(
                                msg: AppStrings.lowBattery,
                                textColor: Theme.of(context).colorScheme.error,
                                textSize: r.fontSize(16),
                                textWeight: FontWeight.w300,

                              ),
                            ],
                          ),
                          VerticalSpacing(height: 50),
                          MText(
                            msg: 'Evergreen Terrace',
                            textColor: Theme.of(context).colorScheme.primary,
                            textSize: r.fontSize(18),
                            textWeight: FontWeight.w400,

                          ),
                          VerticalSpacing(height: 5),
                          SText(
                            msg: 'Springfield US',
                            textColor: Theme.of(context).colorScheme.primary,
                            textSize:r.fontSize(12),
                            textWeight: FontWeight.w400,
                          ),
                          VerticalSpacing(height: 20),
                        ]
                    ),
                    Spacer(),
                    SizedBox(
                      height: r.height(150),
                      width: r.width(95),
                      child: Image.asset(
                        'assets/image/air fragrance.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ] else ...[
                    /// Odd index: Image on left, Text on right
                    SizedBox(
                      height: r.height(150),
                      width: r.width(95),
                      child: Image.asset(
                        'assets/image/air fragrance2.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Spacer(),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: r.width(24),
                                height: r.width(24),
                                child: Image.asset(ImgPath.lowBattery,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(width: r.width(8)),
                              SText(
                                msg: AppStrings.lowBattery,
                                textColor: Theme.of(context).colorScheme.error,
                                textSize: 15,
                                textWeight: FontWeight.w300,
                              ),
                            ],
                          ),
                          VerticalSpacing(height: 50),
                          MText(
                            msg: 'Evergreen Terrace',
                            textColor: Theme.of(context).colorScheme.primary,
                            textSize: r.fontSize(18),
                            textWeight: FontWeight.w400,

                          ),
                          VerticalSpacing(height: 5),
                          SText(
                            msg: 'Springfield US',
                            textColor: Theme.of(context).colorScheme.primary,
                            textSize: r.fontSize(12),
                            textWeight: FontWeight.w400,
                          ),
                          VerticalSpacing(height: 20),
                        ]
                    ),
                  ],
                ],
              ),
            ),
          ),
          Container(
            height: r.height(60),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: r.width(20),
                      width: r.width(20),
                      child: Image.asset(ImgPath.current,
                        color: Theme.of(context).colorScheme.primaryFixed,
                        fit: BoxFit.contain,
                      ),
                    ),
                    HorizontalSpacing(width: 6),
                    SText(
                      msg: '77%',
                      textColor: Theme.of(context).colorScheme.primary,
                      textSize: r.fontSize(14),
                      textWeight: FontWeight.w500,
                    ),
                  ],
                ),
                Container(
                  height: r.height(20),
                  width: r.width(1),
                  color: Theme.of(context).colorScheme.primary,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: r.width(20),
                      width: r.width(20),
                      child: Image.asset(ImgPath.drop,
                        color: Theme.of(context).colorScheme.primaryFixed,
                        fit: BoxFit.contain,
                      ),
                    ),
                    HorizontalSpacing(width: 6),
                    SText(
                      msg: '15%',
                      textColor: Theme.of(context).colorScheme.primary,
                      textSize: r.fontSize(14),
                      textWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

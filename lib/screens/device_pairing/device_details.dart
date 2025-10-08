import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:wisspr_app/commom_widgets/custom_appbar.dart';
import 'package:wisspr_app/commom_widgets/customer_text/satoshi_font_type_text.dart';
import 'package:wisspr_app/resources/dimension_spacing/horizontal_spacing.dart';
import 'package:wisspr_app/resources/dimension_spacing/vertical_spacing.dart';
import 'package:wisspr_app/resources/image_path.dart';
import 'package:wisspr_app/routes/navigation_helper.dart';
import 'package:wisspr_app/utils/responsive_dimensions.dart';
import '../../commom_widgets/product_banner.dart';
import '../../resources/app_strings.dart';

class DeviceDetailsScreen extends StatefulWidget {
  const DeviceDetailsScreen({super.key});

  @override
  State<DeviceDetailsScreen> createState() => _DeviceDetailsScreenState();
}

class _DeviceDetailsScreenState extends State<DeviceDetailsScreen> {
  late ResponsiveDimensions r;
  DeviceData value = DeviceData(fillValue: 0.50, chargeValue: 0.75);

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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(
        context: context,
        dimension: r,
        title: AppStrings.yourAura,
        isBackBtn: true,
        actions: [
          IconButton(
            onPressed: () => NavigationHelper.goToDeviceSettingsScreen(context),
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.primary,
              size: r.fontSize(28),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            VerticalSpacing(height: 12),
            SizedBox(
              height: r.screenHeight * 0.6,
              child: ProductBanner(dimension: r),
            ),
            VerticalSpacing(height: 28),
            details(),
            VerticalSpacing(height: 30),
          ],
        ),
      ),
    );
  }

  /// Widget user to show details.
  Widget details() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.width(12)),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: r.height(20),
              horizontal: r.width(36),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.surfaceTint,
            ),
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: r.height(40),
                      width: r.height(40),
                      child: CircularProgressIndicator(
                        value: value.chargeValue,
                        strokeWidth: r.width(2),
                        backgroundColor: Theme.of(context).colorScheme.secondaryFixedDim,
                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.secondaryFixed),
                      ),
                    ),
                    SizedBox(
                      height: r.width(22),
                      width: r.width(22),
                      child: Image.asset(ImgPath.current,
                        fit: BoxFit.contain,
                        color: Theme.of(context).colorScheme.secondaryFixed,
                      ),
                    )
                  ],
                ),
                HorizontalSpacing(width: 12),
                SText(
                  msg: "${(value.chargeValue * 100).toStringAsFixed(0)}%",
                  textColor: Theme.of(context).colorScheme.secondaryFixed,
                  textWeight: FontWeight.w400,
                  textSize: r.fontSize(24),
                  letterSpacing: 1,
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: r.height(20),
              horizontal: r.width(36),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.surfaceTint,
            ),
            child: Row(
              children: [
                SizedBox(
                  height: r.height(40),
                  width: r.height(40),
                  child: LiquidCircularProgressIndicator(
                    value: value.fillValue,
                    valueColor: AlwaysStoppedAnimation(Theme.of(context).colorScheme.secondaryFixed),
                    backgroundColor: Theme.of(context).colorScheme.secondaryFixedDim,
                    direction: Axis.vertical,
                  ),
                ),
                HorizontalSpacing(width: 12),
                SText(
                  msg: "${(value.fillValue * 100).toStringAsFixed(0)}%",
                  textColor: Theme.of(context).colorScheme.secondaryFixed,
                  textWeight: FontWeight.w400,
                  textSize: r.fontSize(24),
                  letterSpacing: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Model for device details.
class DeviceData {
  double chargeValue;
  double fillValue;

  DeviceData({required this.chargeValue, required this.fillValue});
}

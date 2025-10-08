import 'package:flutter/material.dart';
import 'package:wisspr_app/commom_widgets/custom_appbar.dart';
import 'package:wisspr_app/commom_widgets/custom_buttons/custom_elevated_button.dart';
import 'package:wisspr_app/commom_widgets/customer_text/marcellus_font_type_text.dart';
import 'package:wisspr_app/commom_widgets/customer_text/satoshi_font_type_text.dart';
import 'package:wisspr_app/resources/dimension_spacing/vertical_spacing.dart';
import 'package:wisspr_app/routes/navigation_helper.dart';

import '../../resources/app_strings.dart';
import '../../utils/responsive_dimensions.dart';

class DeviceSettingsScreen extends StatefulWidget {
  const DeviceSettingsScreen({super.key});

  @override
  State<DeviceSettingsScreen> createState() => _DeviceSettingsScreenState();
}

class _DeviceSettingsScreenState extends State<DeviceSettingsScreen> {
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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(
        context: context,
        dimension: r,
        isBackBtn: true,
        title: AppStrings.auraSetup,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: r.width(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VerticalSpacing(height: 30),
              MText(
                msg: AppStrings.currentSchedules,
                textSize: r.fontSize(22),
                textWeight: FontWeight.w400,
                textColor: Theme.of(context).colorScheme.primary,
              ),
              VerticalSpacing(height: 8),
              Container(
                width: r.screenWidth,
                padding: EdgeInsets.symmetric(vertical: r.height(35)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SText(
                        msg: AppStrings.noSchedulesYet,
                        textColor: Theme.of(context).colorScheme.primary,
                        textSize: r.fontSize(18),
                        textWeight: FontWeight.w500,
                      ),
                      SText(
                        msg: AppStrings.createASeamlessFragranceSchedule,
                        textColor: Theme.of(context).colorScheme.tertiary,
                        textSize: r.fontSize(12),
                      ),
                      VerticalSpacing(height: 25),
                      CustomElevatedButton(
                        height: r.height(40),
                        width: r.width(200),
                        buttonName: AppStrings.createSchedule,
                        textColor: Theme.of(context).scaffoldBackgroundColor,
                        textSize: r.fontSize(18),
                        onPressed: () => NavigationHelper.goToSchedulingScreen(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

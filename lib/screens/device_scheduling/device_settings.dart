import 'package:flutter/material.dart';
import 'package:wisspr_app/commom_widgets/custom_appbar.dart';
import 'package:wisspr_app/commom_widgets/custom_buttons/custom_elevated_button.dart';
import 'package:wisspr_app/commom_widgets/custom_buttons/custom_switch_button.dart';
import 'package:wisspr_app/commom_widgets/custom_buttons/custom_text_button.dart';
import 'package:wisspr_app/commom_widgets/customer_text/marcellus_font_type_text.dart';
import 'package:wisspr_app/commom_widgets/customer_text/satoshi_font_type_text.dart';
import 'package:wisspr_app/resources/dimension_spacing/vertical_spacing.dart';
import 'package:wisspr_app/routes/navigation_helper.dart';

import '../../commom_widgets/custom_text_form_field.dart';
import '../../resources/app_strings.dart';
import '../../utils/responsive_dimensions.dart';

class DeviceSettingsScreen extends StatefulWidget {
  const DeviceSettingsScreen({super.key});

  @override
  State<DeviceSettingsScreen> createState() => _DeviceSettingsScreenState();
}

class _DeviceSettingsScreenState extends State<DeviceSettingsScreen> {
  late ResponsiveDimensions r;
  TextEditingController dnController = TextEditingController(text: "Wisspr Aura");
  TextEditingController snController = TextEditingController(text: "Whispering Woods");

  List<ScheduleModel> schedule = [
    ScheduleModel(name: "Office Schedule", days: "Mon, Wed, Thu, Fri, Sun", status: true),
    ScheduleModel(name: "Schedule - 2", days: "Mon to Fri", status: false),
    ScheduleModel(name: "Waiting Room Schedule", days: "Sun, Sat", status: false),
    ScheduleModel(name: "Bad Room Schedule", days: "Sun to Sat", status: false),
    ScheduleModel(name: "Schedule - 1", days: "Sun, Sat, Wed", status: false),
    ScheduleModel(name: "Schedule - 3", days: "Sun, Sat, Thu", status: false),
  ];

  bool isCreated = false;

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
            children: [
              VerticalSpacing(height: 30),
              buildDeviceName(),
              VerticalSpacing(height: 30),
              buildScentName(),
              VerticalSpacing(height: 50),
              isCreated
              ? buildEmptySchedule()
              : buildScheduleList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomTextButton(
        buttonName: AppStrings.removeDevice,
        textColor: Theme.of(context).colorScheme.error,
        textSize: r.fontSize(16),
        textWeight: FontWeight.w300,
        onPressed: () {
          isCreated = !isCreated;
          setState(() {});
        },
      ),
    );
  }

  /// Widget used to build design for device name.
  Widget buildDeviceName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MText(
          msg: AppStrings.deviceName,
          textSize: r.fontSize(22),
          textWeight: FontWeight.w400,
          textColor: Theme.of(context).colorScheme.primary,
        ),
        VerticalSpacing(height: 8),
        CustomTextFormField(
          controller: dnController,
          dimension: r,
          enabled: false,
        ),
      ],
    );
  }

  /// Widget used to build scent name.
  Widget buildScentName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MText(
          msg: AppStrings.scentName,
          textSize: r.fontSize(22),
          textWeight: FontWeight.w400,
          textColor: Theme.of(context).colorScheme.primary,
        ),
        VerticalSpacing(height: 8),
        CustomTextFormField(
          controller: snController,
          dimension: r,
          enabled: false,
        ),
      ],
    );
  }

  /// Widget used to show the empty schedule state.
  Widget buildEmptySchedule() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                  onPressed: () =>
                      NavigationHelper.goToSchedulingScreen(context),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Widget used to show the created schedule state.
  Widget buildScheduleList() {
    return Column(
      children: [
        Row(
          children: [
            MText(
              msg: AppStrings.currentSchedules,
              textSize: r.fontSize(22),
              textWeight: FontWeight.w400,
              textColor: Theme.of(context).colorScheme.primary,
            ),
            Spacer(),
            GestureDetector(
              onTap: () => NavigationHelper.goToSchedulingScreen(context),
              child: Container(
                padding: EdgeInsets.all(r.width(2)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    size: r.fontSize(24),
                  ),
                ),
              ),
            ),
          ],
        ),
        VerticalSpacing(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: schedule.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: r.height(16)),
              padding: EdgeInsets.symmetric(
                vertical: r.height(12),
                horizontal: r.width(15),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  strokeAlign: r.width(0.7),
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SText(
                        msg: schedule[index].name,
                        textColor: Theme.of(context).colorScheme.primary,
                        textSize: r.fontSize(18),
                        textWeight: FontWeight.w400,
                      ),
                      SText(
                        msg: schedule[index].days,
                        textColor: Theme.of(context).colorScheme.tertiary,
                        textSize: r.fontSize(14),
                        textWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  Spacer(),
                  CustomSwitch(
                    dimension: r,
                    value: schedule[index].status,
                    onChanged: (bool v) {
                      schedule[index].status = !(schedule[index].status);
                      setState(() {});
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}


/// Model class.
class ScheduleModel{
  String name;
  String days;
  bool status;

  ScheduleModel({required this.name, required this.days, required this.status});
}
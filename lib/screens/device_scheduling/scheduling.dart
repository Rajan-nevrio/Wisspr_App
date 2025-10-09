import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:wisspr_app/commom_widgets/custom_appbar.dart';
import 'package:wisspr_app/commom_widgets/custom_buttons/custom_elevated_button.dart';
import 'package:wisspr_app/commom_widgets/custom_buttons/custom_text_button.dart';
import 'package:wisspr_app/resources/dimension_spacing/horizontal_spacing.dart';
import 'package:wisspr_app/resources/font_constants.dart';
import '../../commom_widgets/custom_text_form_field.dart';
import '../../commom_widgets/customer_text/marcellus_font_type_text.dart';
import '../../commom_widgets/customer_text/satoshi_font_type_text.dart';
import '../../resources/app_strings.dart';
import '../../resources/dimension_spacing/vertical_spacing.dart';
import '../../utils/responsive_dimensions.dart';

class SchedulingScreen extends StatefulWidget {
  const SchedulingScreen({super.key});

  @override
  State<SchedulingScreen> createState() => _SchedulingScreenState();
}

class _SchedulingScreenState extends State<SchedulingScreen> {
  late ResponsiveDimensions r;
  TextEditingController snController = TextEditingController();
  List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  DateTime dateTime = DateTime.now();

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
        title: AppStrings.scheduling,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            VerticalSpacing(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: r.width(12)),
              child: buildScheduleName(),
            ),
            VerticalSpacing(height: 30),
            buildSetDays(),
            VerticalSpacing(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: r.width(12)),
              child: buildSetTime(),
            ),
            VerticalSpacing(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(),
      bottomSheet: buildTimePicker(),
    );
  }

  /// Widget used to build design for schedule name.
  Widget buildScheduleName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MText(
          msg: AppStrings.scheduleName,
          textSize: r.fontSize(22),
          textWeight: FontWeight.w400,
          textColor: Theme.of(context).colorScheme.primary,
        ),
        VerticalSpacing(height: 8),
        CustomTextFormField(
          controller: snController,
          dimension: r,
          hintText: AppStrings.enterScheduleName,
        ),
      ],
    );
  }

  /// Widget used to build set days.
  Widget buildSetDays() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: r.width(12)),
          child: MText(
            msg: AppStrings.setDays,
            textSize: r.fontSize(22),
            textWeight: FontWeight.w400,
            textColor: Theme.of(context).colorScheme.primary,
          ),
        ),
        VerticalSpacing(height: 8),
        SizedBox(
          height: r.height(50),
          child: ListView.builder(
            itemCount: days.length,
              scrollDirection: Axis.horizontal,
              itemBuilder:  (context, index) {
                return Container(
                  padding: EdgeInsets.all(r.width(10)),
                  margin: index == 0 
                      ? EdgeInsets.only(right: r.width(8), left: r.width(12)) 
                      : EdgeInsets.only(right: r.width(8)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: Center(
                    child: SText(
                      msg: days[index],
                      textColor: Theme.of(context).colorScheme.tertiary,
                      textSize: r.fontSize(16),
                      textWeight: FontWeight.w400,
                    ),
                  ),
                );
              },
          ),
        ),
      ],
    );
  }

  /// Widget used to build set days.
  Widget buildSetTime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MText(
          msg: AppStrings.setTime,
          textSize: r.fontSize(22),
          textWeight: FontWeight.w400,
          textColor: Theme.of(context).colorScheme.primary,
        ),
        VerticalSpacing(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: r.height(16),
                horizontal: r.width(18),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Center(
                child: SText(
                  msg: "01:00 P.M",
                  textColor: Theme.of(context).colorScheme.tertiary,
                  textSize: r.fontSize(16),
                  textWeight: FontWeight.w400,
                ),
              ),
            ),
            HorizontalSpacing(width: 12),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: r.height(16),
                horizontal: r.width(18),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Center(
                child: SText(
                  msg: "03:00 P.M",
                  textColor: Theme.of(context).colorScheme.tertiary,
                  textSize: r.fontSize(16),
                  textWeight: FontWeight.w400,
                ),
              ),
            ),
            HorizontalSpacing(width: 12),
            Container(
              padding: EdgeInsets.all(r.width(2)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  size: r.fontSize(22),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Widget Used to build time picker.
  Widget buildTimePicker(){
    return Container(
      padding: EdgeInsets.only(top: r.height(30), bottom: r.height(50)),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.tertiary,
            width: r.width(0.4),
          ),
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          MText(
            msg: AppStrings.setTime,
            textSize: r.fontSize(22),
            textWeight: FontWeight.w400,
            textColor: Theme.of(context).colorScheme.primary,
          ),
          VerticalSpacing(height: 8),
          TimePickerSpinner(
            is24HourMode: false,
            normalTextStyle: TextStyle(
              fontSize: r.fontSize(18),
              color: Theme.of(context).colorScheme.tertiary,
              fontFamily: FontConstants.satoshi,
            ),
            highlightedTextStyle: TextStyle(
              fontSize: r.fontSize(24),
              color: Theme.of(context).colorScheme.primary,
              fontFamily: FontConstants.satoshi,
              fontWeight: FontWeight.w600
            ),
            spacing: r.width(50),
            itemHeight: r.height(60),
            isForce2Digits: true,
            minutesInterval: 1,
            onTimeChange: (time) {
              setState(() {
                dateTime = time;
              });
            },
          ),
        ],
      ),
    );
  }

  /// Widget used to build bottom navigation bar.
  Widget buildBottomNavBar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomElevatedButton(
          height: r.height(45),
          width: r.width(300),
          buttonName: "Save Schedule",
          textColor: Theme.of(context).scaffoldBackgroundColor,
          textSize: r.fontSize(18),
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () {},
        ),
        VerticalSpacing(height: 8),
        CustomTextButton(
          buttonName: "Delete Schedule",
          textColor: Theme.of(context).colorScheme.error,
          textSize: r.fontSize(18),
          textWeight: FontWeight.w400,
          onPressed: () {},
        ),
      ],
    );
  }
}

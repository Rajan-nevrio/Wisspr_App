import 'package:flutter/material.dart';
import 'package:wisspr_app/commom_widgets/custom_appbar.dart';
import 'package:wisspr_app/commom_widgets/customer_text/marcellus_font_type_text.dart';
import 'package:wisspr_app/commom_widgets/customer_text/satoshi_font_type_text.dart';
import 'package:wisspr_app/resources/dimension_spacing/horizontal_spacing.dart';
import 'package:wisspr_app/resources/dimension_spacing/vertical_spacing.dart';
import 'package:wisspr_app/routes/navigation_helper.dart';
import 'package:wisspr_app/utils/responsive_dimensions.dart';

import '../../commom_widgets/custom_buttons/custom_text_button.dart';
import '../../resources/app_strings.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  List<String> featuredList = [
    "Automated Scheduling Spray",
    "1-2 Refill Pods Per Month",
    "1 Branded scent Pod",
  ];
  List<String> currentPlanFeature = [
    "Manual Spray Pods",
    "No Refill Pods",
  ];
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
        title: AppStrings.subscription,
        isBackBtn: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: r.width(22)),
          child: Column(
            children: [
              VerticalSpacing(height: 25),
              _planDetails(),
              VerticalSpacing(height: 20),
              _buildFeature(),
              VerticalSpacing(height: 20),
              _buildCurrentPlan(),
              VerticalSpacing(height: 20),
              _buildHistoryBtn(),
              VerticalSpacing(height: 60),
              CustomTextButton(
                buttonName: AppStrings.cancelSubscription,
                textColor: Theme.of(context).colorScheme.error,
                textSize: r.fontSize(18),
                textWeight: FontWeight.w300,
                onPressed: () {},
              ),
              VerticalSpacing(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget for the plan details.
  Widget _planDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MText(
          msg: AppStrings.wissprPrime,
          textWeight: FontWeight.w500,
          textSize: r.fontSize(25),
          textColor: Theme.of(context).colorScheme.primary,
        ),
        VerticalSpacing(height: 5),
        SText(
          msg: AppStrings
              .useThisPromoCodeToGetaFreeDryCleanClickHereForMoreDetails,
          textColor: Theme.of(context).colorScheme.tertiary,
          textSize: r.fontSize(14),
          textWeight: FontWeight.w600,
        ),
        VerticalSpacing(height: 10),
        Row(
          children: [
            MText(
              msg: "\$11.99",
              textWeight: FontWeight.w400,
              textSize: r.fontSize(38),
              textColor: Theme.of(context).colorScheme.primary,
            ),
            HorizontalSpacing(width: r.width(15)),
            SText(
              msg: "/month",
              textColor: Theme.of(context).colorScheme.primary,
              textSize: r.fontSize(16),
              textWeight: FontWeight.w600,
            ),
          ],
        ),
        VerticalSpacing(height: 20),
        _buildUpgradeBtn(),
      ],
    );
  }

  /// Upgrade btn UI.
  Widget _buildUpgradeBtn() {
    return SizedBox(
      width: r.screenWidth,
      height: r.height(46),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondaryFixed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
        child: Center(
          child: SText(
            msg: AppStrings.update,
            textAlign: TextAlign.center,
            textSize: r.fontSize(15),
            textWeight: FontWeight.w500,
            textColor: Theme.of(context).scaffoldBackgroundColor,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  /// Widget for the feature details.
  Widget _buildFeature() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SText(
          msg: AppStrings.features,
          textWeight: FontWeight.w500,
          textSize: r.fontSize(22),
          textColor: Theme.of(context).colorScheme.primary,
        ),
        VerticalSpacing(height: 8),
        ListView.builder(
          itemCount: featuredList.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: r.height(6)),
              child: Row(
                children: [
                  Container(
                    width: r.width(18),
                    height: r.width(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 0.6,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check,
                        color: Theme.of(context).colorScheme.primary,
                        size: r.fontSize(14),
                      ),
                    ),
                  ),
                  HorizontalSpacing(width: 8),
                  SText(
                    msg: featuredList[index],
                    textWeight: FontWeight.w200,
                    textSize: r.fontSize(15),
                    textColor: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            );
          },
        ),
        VerticalSpacing(height: 8),
      ],
    );
  }

  /// Widget for the current plan.
  Widget _buildCurrentPlan() {
    return Container(
      padding: EdgeInsets.fromLTRB(r.width(12), r.height(15), r.width(12), r.height(5)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.surfaceTint.withAlpha(120),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SText(
            msg: AppStrings.currentPlan,
            textWeight: FontWeight.w500,
            textSize: r.fontSize(10),
            textColor: Theme.of(context).colorScheme.primary,
          ),
          VerticalSpacing(height: 8),
          Row(
            children: [
              SText(
                msg: AppStrings.wissprLite,
                textWeight: FontWeight.w500,
                textSize: r.fontSize(14),
                textColor: Theme.of(context).colorScheme.primary,
              ),
              HorizontalSpacing(width: 5),
              SText(
                msg: "\$0/month",
                textWeight: FontWeight.w200,
                textSize: r.fontSize(14),
                textColor: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
          VerticalSpacing(height: 14),
          ListView.builder(
            itemCount: currentPlanFeature.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: r.height(10)),
                  child: Row(
                    children: [
                      Container(
                        height: r.width(8),
                        width: r.width(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).colorScheme.secondaryFixed,
                        ),
                      ),
                      HorizontalSpacing(width: 12),
                      SText(
                        msg: currentPlanFeature[index],
                        textWeight: FontWeight.w300,
                        textSize: r.fontSize(12),
                        textColor: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                );
              },
          ),
        ],
      ),
    );
  }

  /// Subscription history btn UI.
 Widget _buildHistoryBtn() {
    return GestureDetector(
      onTap: () => NavigationHelper.goToYourPaymentScreen(context),
      child: Container(
        width: r.screenWidth,
        padding: EdgeInsets.symmetric(vertical: r.height(14), horizontal: r.width(14)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.tertiary,
            width: r.width(1),
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SText(
              msg: AppStrings.subscriptionHistory,
              textWeight: FontWeight.w400,
              textSize: r.fontSize(16),
              textColor: Theme.of(context).colorScheme.tertiary,
            ),
            Icon(Icons.arrow_forward_ios,
              color: Theme.of(context).colorScheme.tertiary,
              size: r.fontSize(20),
            )
          ],
        ),
      ),
    );
 }
}

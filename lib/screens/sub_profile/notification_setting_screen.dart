import 'package:flutter/material.dart';
import 'package:wisspr_app/commom_widgets/custom_appbar.dart';
import 'package:wisspr_app/commom_widgets/customer_text/satoshi_font_type_text.dart';
import 'package:wisspr_app/resources/dimension_spacing/vertical_spacing.dart';
import 'package:wisspr_app/utils/responsive_dimensions.dart';

import '../../commom_widgets/custom_buttons/custom_switch_button.dart';
import '../../resources/app_strings.dart';
import 'package:provider/provider.dart';
import '../../providers/sub_profile/notification_setting_provider.dart';

class NotificationSettingScreen extends StatefulWidget {
  const NotificationSettingScreen({super.key});

  @override
  State<NotificationSettingScreen> createState() => _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
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
    final provider = Provider.of<NotificationSettingProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(
        context: context,
        dimension: r,
        title: AppStrings.notificationSetting,
        isBackBtn: true,
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
              VerticalSpacing(height: 18),
              mainItem(provider),
            ],
        ),
      ),
    );
  }

  /// Widget used for the main list-tile.
  Widget mainItem(NotificationSettingProvider provider) {
    return ListView.builder(
      itemCount: 4,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        late final String label;
        late final bool value;
        late final void Function(bool) onChanged;

        switch (index) {
          case 0:
            label = AppStrings.newOffers;
            value = provider.newOffers;
            onChanged = provider.setNewOffers;
            break;
          case 1:
            label = AppStrings.accountUpdate;
            value = provider.accountUpdate;
            onChanged = provider.setAccountUpdate;
            break;
          case 2:
            label = AppStrings.orderConfirmation;
            value = provider.orderConfirmation;
            onChanged = provider.setOrderConfirmation;
            break;
          default:
            label = AppStrings.orderTracking;
            value = provider.orderTracking;
            onChanged = provider.setOrderTracking;
        }

        return Container(
          margin: EdgeInsets.symmetric(horizontal: r.width(12)),
          padding: EdgeInsets.symmetric(vertical: r.height(14)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SText(
                msg: label,
                textSize: r.fontSize(20),
                textWeight: FontWeight.w200,
                textColor: Theme.of(context).colorScheme.primary,
              ),
              CustomSwitch(
                dimension: r,
                value: value,
                onChanged: onChanged,
              ),
            ],
          ),
        );
      },
    );
  }
}
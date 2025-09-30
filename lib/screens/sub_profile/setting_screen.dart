import 'package:flutter/material.dart';
import 'package:wisspr_app/commom_widgets/custom_appbar.dart';
import 'package:wisspr_app/resources/dimension_spacing/vertical_spacing.dart';
import 'package:wisspr_app/utils/responsive_dimensions.dart';
import '../../commom_widgets/customer_text/satoshi_font_type_text.dart';
import '../../resources/app_strings.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late ResponsiveDimensions _responsive;
  List<SetModel>? items;

  @override
  void initState() {
    super.initState();
    _responsive = ResponsiveDimensions();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _responsive.init(context);
  }

  @override
  Widget build(BuildContext context) {
    items = [
      SetModel(
        label: AppStrings.dataPrivacy,
        onPressed: () => debugPrint("Data & Privacy:-----> Hit data & privacy"),
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(
        context: context,
        dimension: _responsive,
        title: AppStrings.setting,
        isBackBtn: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            VerticalSpacing(height: _responsive.height(18)),
            itemTile(),
          ],
        ),
      ),
    );
  }

  /// Widget used to show the list-tile item.
  Widget itemTile() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items?.length ?? 0,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: items?[index].onPressed,
          title: SText(
            msg: items?[index].label ?? "",
            textSize: _responsive.fontSize(20),
            textWeight: FontWeight.w200,
            textColor: Theme.of(context).colorScheme.primary,
          ),
        );
      },
    );
  }
}

/// Model class for list-tile item.
class SetModel {
  String label;
  void Function() onPressed;

  SetModel({required this.label, required this.onPressed});
}

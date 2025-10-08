import 'package:flutter/material.dart';
import 'package:wisspr_app/commom_widgets/custom_appbar.dart';
import 'package:wisspr_app/commom_widgets/customer_text/marcellus_font_type_text.dart';
import 'package:wisspr_app/commom_widgets/customer_text/satoshi_font_type_text.dart';
import 'package:wisspr_app/resources/dimension_spacing/horizontal_spacing.dart';
import 'package:wisspr_app/resources/dimension_spacing/vertical_spacing.dart';
import 'package:wisspr_app/resources/image_path.dart';
import 'package:wisspr_app/routes/navigation_helper.dart';
import 'package:wisspr_app/utils/responsive_dimensions.dart';

import '../../resources/app_strings.dart';

class AddDeviceScreen extends StatefulWidget {
  const AddDeviceScreen({super.key});

  @override
  State<AddDeviceScreen> createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  late ResponsiveDimensions r;
  List<ListModel> pairedList = [
    ListModel(img: ImgPath.device, title: "Wisspr Aura", status: 'Connected'),
    ListModel(img: ImgPath.device, title: "My Devices- 3", status: 'Connected'),
    ListModel(img: ImgPath.device, title: "Regel Elixir", status: 'Connected'),
    ListModel(
      img: ImgPath.device,
      title: "My Devices- 11",
      status: 'Connected',
    ),
  ];

  List<ListModel> availableList = [
    ListModel(img: ImgPath.device, title: "Wisspr Aura", status: 'Pairing...'),
    ListModel(
      img: ImgPath.device,
      title: "My Devices- 3",
      status: 'Pairing...',
    ),
    ListModel(img: ImgPath.device, title: "Regel Elixir", status: 'Pairing...'),
    ListModel(
      img: ImgPath.device,
      title: "My Devices- 11",
      status: 'Pairing...',
    ),
  ];

  @override
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
        title: AppStrings.addDevice,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerticalSpacing(height: 60),
            header(),
            VerticalSpacing(height: 30),
            pairedDevice(),
            VerticalSpacing(height: 15),
            availableDevice(),
            VerticalSpacing(height: 30),
          ],
        ),
      ),
    );
  }

  /// Header Widget.
  Widget header() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: r.height(200),
            width: r.height(200),
            child: Image.asset(ImgPath.loader,
              fit: BoxFit.contain,
            ),
          ),
          VerticalSpacing(height: 40),
          SizedBox(
            width: r.width(280),
            child: SText(
              msg: AppStrings.searchingForDevicesViaBluetoothPleaseBePatient,
              textColor: Theme.of(context).colorScheme.tertiary,
              textSize: r.fontSize(16),
              textWeight: FontWeight.w300,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  /// Paired devices.
  Widget pairedDevice() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.width(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MText(
            msg: AppStrings.pairedDevice,
            textSize: r.fontSize(22),
            textWeight: FontWeight.w500,
            textColor: Theme.of(context).colorScheme.primary,
          ),
          VerticalSpacing(height: 12),
          ListView.builder(
            itemCount: pairedList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => NavigationHelper.goToDeviceDetailsScreen(context),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: r.height(12),
                    horizontal: r.width(14),
                  ),
                  margin: EdgeInsets.only(bottom: r.width(10)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      width: r.width(0.4),
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        height: r.height(36),
                        width: r.width(22),
                        child: Image.asset(
                          pairedList[index].img,
                          fit: BoxFit.contain,
                        ),
                      ),
                      HorizontalSpacing(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MText(
                            msg: pairedList[index].title,
                            textColor: Theme.of(context).colorScheme.primary,
                            textSize: r.fontSize(18),
                            textWeight: FontWeight.w500,
                          ),
                          VerticalSpacing(height: 3),
                          SText(
                            msg: pairedList[index].status,
                            textColor: Theme.of(context).colorScheme.tertiary,
                            textSize: r.fontSize(14),
                            textWeight: FontWeight.w300,
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).colorScheme.tertiary,
                        size: r.fontSize(22),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Available devices.
  Widget availableDevice() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.width(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MText(
                msg: AppStrings.availableDevice,
                textSize: r.fontSize(22),
                textWeight: FontWeight.w500,
                textColor: Theme.of(context).colorScheme.primary,
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.refresh,
                  size: r.fontSize(22),
                  color: Theme.of(context).colorScheme.secondaryFixed,
                ),
              ),
            ],
          ),
          ListView.builder(
            itemCount: availableList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => NavigationHelper.goToDeviceDetailsScreen(context),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: r.height(12),
                    horizontal: r.width(14),
                  ),
                  margin: EdgeInsets.only(bottom: r.width(10)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      width: r.width(0.4),
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        height: r.height(36),
                        width: r.width(22),
                        child: Image.asset(
                          availableList[index].img,
                          fit: BoxFit.contain,
                        ),
                      ),
                      HorizontalSpacing(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MText(
                            msg: availableList[index].title,
                            textColor: Theme.of(context).colorScheme.primary,
                            textSize: r.fontSize(18),
                            textWeight: FontWeight.w500,
                          ),
                          VerticalSpacing(height: 3),
                          SText(
                            msg: availableList[index].status,
                            textColor: Theme.of(context).colorScheme.tertiary,
                            textSize: r.fontSize(14),
                            textWeight: FontWeight.w300,
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).colorScheme.tertiary,
                        size: r.fontSize(22),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Model class.
class ListModel {
  String img;
  String title;
  String status;

  ListModel({required this.img, required this.title, required this.status});
}

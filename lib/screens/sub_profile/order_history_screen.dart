import 'package:flutter/material.dart';
import 'package:wisspr_app/commom_widgets/custom_appbar.dart';
import 'package:wisspr_app/commom_widgets/customer_text/marcellus_font_type_text.dart';
import 'package:wisspr_app/resources/dimension_spacing/horizontal_spacing.dart';
import 'package:wisspr_app/resources/dimension_spacing/vertical_spacing.dart';
import 'package:wisspr_app/resources/image_path.dart';
import 'package:wisspr_app/utils/responsive_dimensions.dart';
import '../../commom_widgets/customer_text/satoshi_font_type_text.dart';
import '../../resources/app_strings.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  late ResponsiveDimensions r;
  List<OrderHistoryModel> items = [
    OrderHistoryModel(
      orderName: "3 items",
      orderPrice: "11.99",
      orderDate: "20 Aug, 25",
    ),
    OrderHistoryModel(
      orderName: "5 items",
      orderPrice: "19.99",
      orderDate: "12 Aug, 25",
    ),
    OrderHistoryModel(
      orderName: "8 items",
      orderPrice: "29.99",
      orderDate: "30 Oct, 25",
    ),
    OrderHistoryModel(
      orderName: "12 items",
      orderPrice: "39.99",
      orderDate: "20 Nov, 25",
    ),
    OrderHistoryModel(
      orderName: "4 items",
      orderPrice: "15.99",
      orderDate: "20 Jun, 25",
    ),
    OrderHistoryModel(
      orderName: "7 items",
      orderPrice: "09.99",
      orderDate: "20 Sep, 25",
    ),
    OrderHistoryModel(
      orderName: "1 items",
      orderPrice: "03.99",
      orderDate: "20 Dec, 25",
    ),
    OrderHistoryModel(
      orderName: "1 items",
      orderPrice: "03.99",
      orderDate: "20 Dec, 25",
    ),
    OrderHistoryModel(
      orderName: "1 items",
      orderPrice: "03.99",
      orderDate: "20 Dec, 25",
    ),
    OrderHistoryModel(
      orderName: "1 items",
      orderPrice: "03.99",
      orderDate: "20 Dec, 25",
    ),
  ];

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
        title: AppStrings.yourOrder,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                r.width(12),
                r.height(18),
                r.width(12),
                r.height(7),
              ),
              child: MText(
                msg: AppStrings.orderHistory,
                textSize: r.fontSize(16),
                textColor: Theme.of(context).colorScheme.primary,
                textWeight: FontWeight.w500,
              ),
            ),
            mainItem(),
          ],
        ),
      ),
    );
  }

  /// Main widget
  Widget mainItem() {
    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(
            left: r.width(12),
            right: r.width(12),
            bottom: r.height(18),
          ),
          padding: EdgeInsets.symmetric(
            vertical: r.height(12),
            horizontal: r.width(12),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.surfaceTint,
          ),
          child: Row(
            children: [
              Container(
                height: r.height(50),
                width: r.height(50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                child:  Center(
                  child: SizedBox(
                    width: r.width(22),
                    height: r.width(22),
                    child: Image.asset(ImgPath.box,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              HorizontalSpacing(width: r.width(12)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: r.screenWidth - r.width(110),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SText(
                          msg: items[index].orderName,
                          textColor: Theme.of(context).colorScheme.primary,
                          textSize: r.fontSize(15),
                        ),
                        SText(
                          msg: " • ",
                          textColor: Theme.of(context).colorScheme.primary,
                          textSize: r.fontSize(15),
                        ),
                        SText(
                          msg: "\$${items[index].orderPrice}",
                          textColor: Theme.of(context).colorScheme.secondaryFixed,
                          textSize: r.fontSize(15),
                        ),
                      ],
                    ),
                  ),
                  VerticalSpacing(height: 5),
                  SizedBox(
                    width: r.screenWidth - r.width(110),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: r.width(14),
                              height: r.width(14),
                              child: Image.asset(
                                ImgPath.calender,
                                fit: BoxFit.contain,
                              ),
                            ),
                            HorizontalSpacing(width: 5),
                            SText(
                              msg: items[index].orderDate,
                              textColor: Theme.of(context).colorScheme.tertiary,
                              textSize: r.fontSize(12),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            debugPrint("-----> Press the view more btn.");
                          },
                          child: SText(
                            msg: AppStrings.viewMore,
                            textColor: Theme.of(context).colorScheme.secondaryFixed,
                            textSize: r.fontSize(14),
                            textWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Model for main widget.
class OrderHistoryModel {
  String orderName;
  String orderPrice;
  String orderDate;

  OrderHistoryModel({
    required this.orderName,
    required this.orderPrice,
    required this.orderDate,
  });
}

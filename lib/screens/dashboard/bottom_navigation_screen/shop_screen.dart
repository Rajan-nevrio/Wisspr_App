import 'package:flutter/material.dart';
import 'package:wisspr_app/resources/dimension_spacing/vertical_spacing.dart';
import '../../../commom_widgets/buy_banner.dart';
import '../../../commom_widgets/custom_appbar.dart';
import '../../../commom_widgets/customer_text/marcellus_font_type_text.dart';
import '../../../commom_widgets/customer_text/satoshi_font_type_text.dart';
import '../../../commom_widgets/product_banner.dart';
import '../../../commom_widgets/refills_card.dart';
import '../../../resources/app_strings.dart';
import '../../../utils/responsive_dimensions.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  int _currentPage = 0;
  late ResponsiveDimensions _responsive;

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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(
        context: context,
        dimension: _responsive,
        title: AppStrings.shop,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: _buildProductSection(),
            ),
            _buildMyDevicesSection(),
            BuyBanner(dimension: _responsive),
            SizedBox(height: _responsive.height(20)),
            _buildRefillSection(),
            SizedBox(height: _responsive.height(50)),
          ],
        ),
      ),
      extendBody: true,
    );
  }

  /// Widget used to show product section.
  Widget _buildProductSection() {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          PageView.builder(
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: 4,
            itemBuilder: (context, index) {
              return ProductBanner(dimension: _responsive);
            },
          ),

          /// Pagination indicators (horizontal dashes).
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 16,
                  height: 3,
                  decoration: BoxDecoration(
                    color: index == _currentPage
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  /// Widget used to show the device section.
  Widget _buildMyDevicesSection() {
    return Container(
      padding: EdgeInsets.fromLTRB(_responsive.width(12), _responsive.width(12), _responsive.width(12), _responsive.height(0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MText(
            msg: AppStrings.devices,
            textSize: _responsive.fontSize(20),
            textWeight: FontWeight.w400,
            textColor: Theme.of(context).colorScheme.primary,
          ),
          VerticalSpacing(height: 20),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.36,
            child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return RefillsCard(dimension: _responsive, index: index);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Widget used to show the refills section.
  Widget _buildRefillSection() {
    return Container(
      padding: EdgeInsets.fromLTRB(_responsive.width(12), _responsive.width(12), _responsive.width(12), _responsive.height(40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              MText(
                msg: AppStrings.refills,
                textSize: _responsive.fontSize(20),
                textWeight: FontWeight.w400,
                textColor: Theme.of(context).colorScheme.primary,
              ),
              Spacer(),
              SText(
                msg: AppStrings.seeAll,
                textSize: _responsive.fontSize(14),
                textWeight: FontWeight.w400,
                textColor: Theme.of(context).colorScheme.primaryFixed,
              ),
            ],
          ),
          VerticalSpacing(height: 20),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.36,
            child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return RefillsCard(dimension: _responsive, index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

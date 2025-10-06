import 'package:flutter/material.dart';
import 'package:wisspr_app/commom_widgets/customer_text/marcellus_font_type_text.dart';
import 'package:wisspr_app/resources/dimension_spacing/vertical_spacing.dart';
import '../../../commom_widgets/custom_appbar.dart';
import '../../../commom_widgets/customer_text/satoshi_font_type_text.dart';
import '../../../commom_widgets/my_device_card.dart';
import '../../../commom_widgets/product_banner.dart';
import '../../../commom_widgets/purchase_banner.dart';
import '../../../commom_widgets/video_card.dart';
import 'package:provider/provider.dart';
import '../../../providers/dashboard/botton_navigation_providers/home_provider.dart';
import '../../../resources/app_strings.dart';
import '../../../utils/responsive_dimensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;
  int _deviceCurrentPage = 0;
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
    final homeProvider = context.read<HomeProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeProvider.getVideoMethod();
      homeProvider.getBannerMethod();
    });

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(
        context: context,
        dimension: r,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
              color: Theme.of(context).colorScheme.primary,
              size: r.fontSize(24),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: r.screenHeight * 0.6, child: _productBanner()),
            _buildMyDevicesSection(),
            PurchaseBanner(dimension: r),
            VerticalSpacing(height: 20),
            _buildVideoSection(),
            VerticalSpacing(height: 50),
          ],
        ),
      ),
      extendBody: true,
    );
  }

  /// Widget used to show the product banner on top.
  Widget _productBanner() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
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
              return ProductBanner(dimension: r);
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
                  width: r.width(16),
                  height: r.height(3),
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
      padding: EdgeInsets.fromLTRB(r.width(12), r.width(12), r.width(12), r.height(40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MText(
            msg: AppStrings.myDevices,
            textSize: r.fontSize(20),
            textWeight: FontWeight.w400,
            textColor: Theme.of(context).colorScheme.primary,
          ),
          VerticalSpacing(height: 20),
          SizedBox(
            height: r.screenHeight * 0.27,
            child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  _deviceCurrentPage = index;
                });
              },
              itemCount: 3,
              itemBuilder: (context, index) {
                return MyDeviceCard(index: index);
              },
            ),
          ),
          VerticalSpacing(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: r.width(16),
                height: r.height(3),
                decoration: BoxDecoration(
                  color: index == _deviceCurrentPage
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  /// Widget used to show the video section.
  Widget _buildVideoSection() {
    return Container(
      padding: EdgeInsets.fromLTRB(r.width(12), r.width(12), r.width(12), r.height(40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MText(
                msg: AppStrings.howToVideos,
                textSize: r.fontSize(20),
                textWeight: FontWeight.w400,
                textColor: Theme.of(context).colorScheme.primary,
              ),
              Spacer(),
              TextButton(
                onPressed: () {},
                child: SText(
                  msg: AppStrings.seeAll,
                  textSize: r.fontSize(14),
                  textWeight: FontWeight.w300,
                  textColor: Theme.of(context).colorScheme.primaryFixed,
                ),
              )
            ],
          ),
          VerticalSpacing(height: 20),
          SizedBox(
            height: r.screenHeight * 0.5,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return VideoCard(dimension: r);
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../commom_widgets/custom_appbar.dart';
import '../../theme/font_constants.dart';
import '../../utils/responsive_dimensions.dart';

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
        title: "Shop",
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
            _buildPurchaseCard(),
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
              return _buildProductCard();
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

  /// Widget used to show the product card.
  Widget _buildProductCard() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                height: 450,
                width: MediaQuery.of(context).size.width,
                color: Colors.red,
                child: Transform.rotate(
                  angle: 5.8,
                  child: SizedBox(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/image/PFimg.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: _responsive.height(100)),
                    Text(
                      'Regel',
                      style: TextStyle(
                        fontSize: _responsive.fontSize(40),
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.primary,
                        letterSpacing: 1.2,
                        // fontFamily: FontConstants.marcellus,
                      ),
                    ),
                    Text(
                      'Elixir',
                      style: TextStyle(
                        fontSize: _responsive.fontSize(28),
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).colorScheme.primary,
                        letterSpacing: 1.0,
                        //fontFamily: FontConstants.marcellus,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'A majestic blend of luxury\nand power, fit for royalty.',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: _responsive.fontSize(12),
                        color: Theme.of(context).colorScheme.tertiary,
                        height: 1.4,
                        //fontFamily: FontConstants.satoshi,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(width: _responsive.width(30)),
        ],
      ),
    );
  }

  /// Widget used to show the device section.
  Widget _buildMyDevicesSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Devices',
            style: TextStyle(
              fontSize: _responsive.fontSize(20),
              fontWeight: FontWeight.w400,
              //fontFamily: FontConstants.marcellus,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: _responsive.height(20)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.36,
            child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).scaffoldBackgroundColor.withAlpha(84),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 210,
                            height: 210,
                          ),
                          Positioned(
                            top: 30,
                            child: Container(
                              width: 210,
                              height: 190,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).colorScheme.surface,
                                    Theme.of(context).scaffoldBackgroundColor,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                              left: 36,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  /// Mirror logic: even index = text left, image right; odd index = image left, text right
                                  if (index % 2 == 0) ...[
                                    /// Even index: Text on left, Image on right
                                    SizedBox(
                                      height: _responsive.height(235),
                                      width: _responsive.width(150),
                                      child: Image.asset(
                                        'assets/image/air fragrance.png',
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ] else ...[
                                    /// Odd index: Image on left, Text on right
                                    SizedBox(
                                      height: _responsive.height(210),
                                      width: _responsive.width(125),
                                      child: Image.asset(
                                        'assets/image/air fragrance2.png',
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                          ),
                        ],
                      ),
                      // Bottom status bar
                      Container(
                        height: _responsive.height(60),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A2A2A),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: Container(
                          width: 210,
                          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Black Opium',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    '\$150.00',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.tertiary,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                child: Center(
                                  child: Icon(Icons.shop, color: Theme.of(context).scaffoldBackgroundColor, size: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
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
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Refills',
                style: TextStyle(
                  fontSize: _responsive.fontSize(20),
                  fontWeight: FontWeight.w400,
                  //fontFamily: FontConstants.marcellus,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Spacer(),
              Text(
                'See All',
                style: TextStyle(
                  fontSize: _responsive.fontSize(14),
                  fontWeight: FontWeight.w400,
                  //fontFamily: FontConstants.marcellus,
                  color: Theme.of(context).colorScheme.primaryFixed,
                ),
              ),
            ],
          ),
          SizedBox(height: _responsive.height(20)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.36,
            child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).scaffoldBackgroundColor.withAlpha(84),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 210,
                            height: 210,
                          ),
                          Positioned(
                            top: 30,
                            child: Container(
                              width: 210,
                              height: 190,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).colorScheme.surface,
                                    Theme.of(context).scaffoldBackgroundColor,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 36,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                /// Mirror logic: even index = text left, image right; odd index = image left, text right
                                if (index % 2 == 0) ...[
                                  /// Even index: Text on left, Image on right
                                  SizedBox(
                                    height: _responsive.height(235),
                                    width: _responsive.width(150),
                                    child: Image.asset(
                                      'assets/image/air fragrance.png',
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ] else ...[
                                  /// Odd index: Image on left, Text on right
                                  SizedBox(
                                    height: _responsive.height(210),
                                    width: _responsive.width(125),
                                    child: Image.asset(
                                      'assets/image/air fragrance2.png',
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Bottom status bar
                      Container(
                        height: _responsive.height(60),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A2A2A),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: Container(
                          width: 210,
                          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Black Opium',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    '\$150.00',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.tertiary,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                child: Center(
                                  child: Icon(Icons.shop, color: Theme.of(context).scaffoldBackgroundColor, size: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Widget used to show the purchase card.
  Widget _buildPurchaseCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(width: 0.2, color: Theme.of(context).colorScheme.tertiary),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset("assets/image/perfume_flower.jpg",
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          /// Gradient overlay from transparent top to black bottom.
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(8), topRight: Radius.circular(8)),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Theme.of(context).colorScheme.shadow,
                    Theme.of(context).colorScheme.surface,
                    Theme.of(context).colorScheme.surface,
                  ],
                  stops: const [0.0, 0.45, 0.7],
                ),
              ),
            ),
          ),
          Positioned(
            right: 15,
            top: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Buy Subscription",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryFixed,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.arrow_forward,
                      color: Theme.of(context).colorScheme.primaryFixed,
                      size: 13,
                    )
                  ],
                ),
                SizedBox(
                  width: _responsive.width(190),
                  child: Text("Subscribe for full automation & control.",
                    style: TextStyle(
                      // fontFamily: FontConstants.satoshi,
                      fontSize: 9,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

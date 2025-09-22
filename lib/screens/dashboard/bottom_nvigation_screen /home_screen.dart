import 'package:flutter/material.dart';

import '../../../commom_widgets/custom_appbar.dart';
import '../../../theme/font_constants.dart';
import '../../../utils/responsive_dimensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;
  int _deviceCurrentPage = 0;
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
              color: Theme.of(context).colorScheme.primary,
              size: 24,
            ),
          ),
        ],
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
            _buildVideoSection(),
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
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: _responsive.height(500),
                width: MediaQuery.of(context).size.width - 20,
                child: Image.asset(
                  "assets/image/HP_image.png",
                  fit: BoxFit.fitHeight,
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
            'My Devices',
            style: TextStyle(
              fontSize: _responsive.fontSize(20),
              fontWeight: FontWeight.w400,
              //fontFamily: FontConstants.marcellus,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: _responsive.height(20)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.27,
            child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  _deviceCurrentPage = index;
                });
              },
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
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
                      Container(
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
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              /// Mirror logic: even index = text left, image right; odd index = image left, text right
                              if (index % 2 == 0) ...[
                                /// Even index: Text on left, Image on right
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: Image.asset("assets/image/Low Battery.png",
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          SizedBox(width: _responsive.width(8)),
                                          Text(
                                            'Low Battery',
                                            style: TextStyle(
                                              color: Theme.of(context).colorScheme.error,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300,
                                              //fontFamily: FontConstants.satoshi,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: _responsive.height(50)),
                                      Text(
                                        'Evergreen Terrace',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          //fontFamily: FontConstants.marcellus,
                                        ),
                                      ),
                                      SizedBox(height: _responsive.height(5)),
                                      Text(
                                        'Springfield US',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          //fontFamily: FontConstants.satoshi,
                                        ),
                                      ),
                                      SizedBox(height: _responsive.height(20)),
                                    ]
                                ),
                                Spacer(),
                                SizedBox(
                                  height: _responsive.height(150),
                                  width: _responsive.width(95),
                                  child: Image.asset(
                                    'assets/image/air fragrance.png',
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ] else ...[
                                /// Odd index: Image on left, Text on right
                                SizedBox(
                                  height: _responsive.height(150),
                                  width: _responsive.width(95),
                                  child: Image.asset(
                                    'assets/image/air fragrance2.png',
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                Spacer(),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: Image.asset("assets/image/Low Battery.png",
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          SizedBox(width: _responsive.width(8)),
                                          Text(
                                            'Low Battery',
                                            style: TextStyle(
                                              color: Theme.of(context).colorScheme.error,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300,
                                             // fontFamily: FontConstants.satoshi,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: _responsive.height(50)),
                                      Text(
                                        'Evergreen Terrace',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          //fontFamily: FontConstants.marcellus,
                                        ),
                                      ),
                                      SizedBox(height: _responsive.height(5)),
                                      Text(
                                        'Springfield US',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                         // fontFamily: FontConstants.satoshi,
                                        ),
                                      ),
                                      SizedBox(height: _responsive.height(20)),
                                    ]
                                ),
                              ],
                            ],
                          ),
                        ),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Image.asset("assets/image/current.png",
                                    color: Theme.of(context).colorScheme.primaryFixed,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  '77%',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 20,
                              width: 1,
                              color: Colors.white30,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Image.asset("assets/image/drop.png",
                                    color: Theme.of(context).colorScheme.primaryFixed,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  '15%',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: _responsive.height(12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 16,
                height: 3,
                decoration: BoxDecoration(
                  color: index == _deviceCurrentPage
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            }),
          )
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
            right: 20,
            top: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: _responsive.width(170),
                  child: Text("Buy Wipper Aura at a limited time discount. Lasts till 31 Aug.",
                    style: TextStyle(
                     // fontFamily: FontConstants.satoshi,
                      fontSize: 9,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("\$ 18.99",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryFixed,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: _responsive.width(8)),
                    Text("\$ 30.99",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 9,
                        decoration: TextDecoration.lineThrough,
                        decorationThickness: 1,
                        decorationColor: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Widget used to show the video section.
  Widget _buildVideoSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'How To Videos',
                style: TextStyle(
                  fontSize: _responsive.fontSize(20),
                  fontWeight: FontWeight.w400,
                 // fontFamily: FontConstants.marcellus,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () {},
                child: Text("See all",
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primaryFixed,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: _responsive.height(20)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  width: _responsive.width(270),
                  margin: const EdgeInsets.only(right: 16),
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      children: [
                        /// Background image.
                        Positioned.fill(
                          child: Image.asset(
                            'assets/image/air fragrance device in a room.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        /// Gradient overlay from transparent top to black bottom.
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Theme.of(context).colorScheme.shadow,
                                  Theme.of(context).scaffoldBackgroundColor.withAlpha(240),
                                ],
                              ),
                            ),
                          ),
                        ),
                        /// Video play icon on top.
                        Positioned(
                          top: 16,
                          right: 16,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).colorScheme.secondaryFixed,
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                        /// Text overlay at bottom
                        Positioned(
                          bottom: 16,
                          left: 16,
                          right: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primaryFixed,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Wisspr Aura',
                                  style: TextStyle(
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  //  fontFamily: FontConstants.marcellus,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'How to connect the device with app.',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w300,
                                 // fontFamily: FontConstants.satoshi,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

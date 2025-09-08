import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/font_constants.dart';
import '../utils/responsive_dimensions.dart';

enum _SelectedTab { home, devices, shop, profile }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ResponsiveDimensions _responsive;
  int _currentPage = 0;

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

  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  Widget _buildBody() {
    switch (_selectedTab) {
      case _SelectedTab.home:
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: _buildProductSection(),
              ),
              _buildMyDevicesSection(),
            ],
          ),
        );
      case _SelectedTab.devices:
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Center(
            child: Text(
              'Devices',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        );
      case _SelectedTab.shop:
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Center(
            child: Text(
              'Shop',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        );
      case _SelectedTab.profile:
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Center(
            child: Text(
              'Profile',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        );
    }
  }

  Widget _buildCustomCrystalNavigationBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.shadow.withAlpha(56),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary.withAlpha(28),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).scaffoldBackgroundColor.withAlpha(84),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(
            imgPath: "assets/image/home.png",
            label: 'Home',
            isSelected: _selectedTab == _SelectedTab.home,
            onTap: () => _handleIndexChanged(0),
          ),
          _buildNavItem(
            imgPath: "assets/image/device.png",
            label: 'Devices',
            isSelected: _selectedTab == _SelectedTab.devices,
            onTap: () => _handleIndexChanged(1),
          ),
          _buildNavItem(
            imgPath: "assets/image/shop.png",
            label: 'Shop',
            isSelected: _selectedTab == _SelectedTab.shop,
            onTap: () => _handleIndexChanged(2),
          ),
          _buildNavItem(
            imgPath: "assets/image/profile.png",
            label: 'Profile',
            isSelected: _selectedTab == _SelectedTab.profile,
            onTap: () => _handleIndexChanged(3),
          ),
        ],
      ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String imgPath,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.shadow,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imgPath,
              height: 20,
              width: 20,
              fit: BoxFit.contain,
              color: isSelected ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).colorScheme.tertiary,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 4,
        scrolledUnderElevation: 0,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        shadowColor: Theme.of(context).scaffoldBackgroundColor,
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
       body: _buildBody(),
       extendBody: true,
       bottomNavigationBar: _buildCustomCrystalNavigationBar(),
      //bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

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
          // Pagination indicators (horizontal dashes)
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

  Widget _buildProductCard() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
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
                  fontFamily: FontConstants.marcellus,
                ),
              ),
              Text(
                'Elixir',
                style: TextStyle(
                  fontSize: _responsive.fontSize(28),
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).colorScheme.primary,
                  letterSpacing: 1.0,
                  fontFamily: FontConstants.marcellus,
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
                  fontFamily: FontConstants.satoshi,
                ),
              ),
            ],
          ),
          SizedBox(width: _responsive.width(30)),
          SizedBox(
            height: 450,
            child: Transform.rotate(
              angle: 5.8,
              child: SizedBox(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/image/main_img.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyDevicesSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Devices',
            style: TextStyle(
              fontSize: _responsive.fontSize(20),
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              _buildDeviceCard(
                title: 'Low Battery',
                icon: Icons.battery_alert,
                iconColor: Theme.of(context).colorScheme.error,
                isLowBattery: true,
              ),
              const SizedBox(height: 12),
              _buildDeviceCard(
                title: 'Evergreen Terrace',
                subtitle: '77%',
                subtitleIcon: Icons.flash_on,
                subtitle2: '15%',
                subtitle2Icon: Icons.water_drop,
                perfumeBottle: true,
              ),
              const SizedBox(height: 12),
              _buildDeviceCard(
                title: 'Device 3',
                subtitle: '50%',
                subtitleIcon: Icons.flash_on,
                subtitle2: '30%',
                subtitle2Icon: Icons.water_drop,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceCard({
    required String title,
    String? subtitle,
    IconData? subtitleIcon,
    String? subtitle2,
    IconData? subtitle2Icon,
    IconData? icon,
    Color? iconColor,
    bool perfumeBottle = false,
    bool isLowBattery = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Top row with status and title
          Row(
            children: [
              if (icon != null) ...[
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: iconColor ?? Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: Theme.of(context).colorScheme.primary,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              if (perfumeBottle) ...[
                Container(
                  width: 50,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary.withAlpha(28),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary.withAlpha(28),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Perfume bottle
                      Container(
                        width: 25,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryFixed.withAlpha(190),
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary.withAlpha(84),
                            width: 0.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            // Cap
                            Container(
                              width: 25,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.tertiary,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(3),
                                  topRight: Radius.circular(3),
                                ),
                              ),
                            ),
                            // Liquid
                            Expanded(
                              child: Container(
                                width: 25,
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primaryFixed.withAlpha(156),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(3),
                                    bottomRight: Radius.circular(3),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Label text
                      Text(
                        'CARBAUM',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 7,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        'AUPEM',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 6,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          // Bottom row with metrics (only for non-low battery cards)
          if (!isLowBattery && (subtitle != null || subtitle2 != null)) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                if (subtitle != null) ...[
                  if (subtitleIcon != null) ...[
                    Icon(
                      subtitleIcon,
                      color: Theme.of(context).colorScheme.tertiary,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                  ],
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 14,
                    ),
                  ),
                ],
                if (subtitle2 != null) ...[
                  const Spacer(),
                  if (subtitle2Icon != null) ...[
                    Icon(
                      subtitle2Icon,
                      color: Theme.of(context).colorScheme.tertiary,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                  ],
                  Text(˚
                    subtitle2,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }

}

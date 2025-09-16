import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:wisspr_app/screens/dashboard/my_device_screen.dart';
import 'package:wisspr_app/screens/dashboard/profile_screen.dart';
import 'package:wisspr_app/screens/dashboard/shop_screen.dart';
import '../../utils/responsive_dimensions.dart';
import 'home_screen.dart';

enum _SelectedTab { home, devices, shop, profile }

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
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

  /// Default selected tab.
  var _selectedTab = _SelectedTab.home;

  /// Method used to handle navigation index changes.
  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(child: _buildBody()),
      extendBody: true,
      bottomNavigationBar: _buildCustomCrystalNavigationBar(),
    );
  }

  /// Main body.
  Widget _buildBody() {
    switch (_selectedTab) {
      case _SelectedTab.home:
        return HomeScreen();
      case _SelectedTab.devices:
        return MyDeviceScreen();
      case _SelectedTab.shop:
        return ShopScreen();
      case _SelectedTab.profile:
        return ProfileScreen();
    }
  }

  /// Widget used to show navigation bar design.
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

  /// Widget used to show the selected navigation item design.
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
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.shadow,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imgPath,
              height: 20,
              width: 20,
              fit: BoxFit.contain,
              color: isSelected
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Theme.of(context).colorScheme.tertiary,
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
}

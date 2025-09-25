import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisspr_app/commom_widgets/customer_text/satoshi_font_type_text.dart';
import 'package:wisspr_app/providers/dashboard/dashboard_provider.dart';
import 'package:wisspr_app/resources/dimension_spacing/horizontal_spacing.dart';
import '../../resources/app_strings.dart';
import '../../resources/image_path.dart';
import '../../utils/responsive_dimensions.dart';
import 'bottom_navigation_screen/home_screen.dart';
import 'bottom_navigation_screen/my_device_screen.dart';
import 'bottom_navigation_screen/profile_screen.dart';
import 'bottom_navigation_screen/shop_screen.dart';


class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  late ResponsiveDimensions r;
  
  // Cache screen instances for better performance
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    r = ResponsiveDimensions();
    
    // Initialize all screens once for caching
    _screens = [
      const HomeScreen(),
      const MyDeviceScreen(),
      const ShopScreen(),
      const ProfileScreen(),
    ];
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
      body: Selector<DashBoardProvider, int>(
        selector: (context, provider) => provider.selectedTab.index,
        builder: (context, selectedIndex, _) => IndexedStack(
          index: selectedIndex,
          children: _screens,
        ),
      ),
      extendBody: true,
      bottomNavigationBar: _buildCustomCrystalNavigationBar(),
    );
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
          child: Selector<DashBoardProvider, int>(
            selector: (context, provider) => provider.selectedTab.index,
            builder: (context, selectedIndex, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(
                    imgPath: ImgPath.homeIcon,
                    label: AppStrings.home,
                    isSelected: selectedIndex == 0,
                    onTap: () => context.read<DashBoardProvider>().handleIndexChanged(0),
                  ),
                  _buildNavItem(
                    imgPath: ImgPath.deviceIcon,
                    label: AppStrings.devices,
                    isSelected: selectedIndex == 1,
                    onTap: () => context.read<DashBoardProvider>().handleIndexChanged(1),
                  ),
                  _buildNavItem(
                    imgPath: ImgPath.shopIcon,
                    label: AppStrings.shop,
                    isSelected: selectedIndex == 2,
                    onTap: () => context.read<DashBoardProvider>().handleIndexChanged(2),
                  ),
                  _buildNavItem(
                    imgPath: ImgPath.profileIcon,
                    label: AppStrings.profile,
                    isSelected: selectedIndex == 3,
                    onTap: () => context.read<DashBoardProvider>().handleIndexChanged(3),
                  ),
                ],
              );
            },
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
        padding: EdgeInsets.symmetric(horizontal: r.width(16), vertical: r.height(8)),
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
              height: r.height(20),
              width: r.height(20),
              fit: BoxFit.contain,
              color: isSelected
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Theme.of(context).colorScheme.tertiary,
            ),
            if (isSelected) ...[
              HorizontalSpacing(width: 8),
              SText(
                msg: label,
                textColor: Theme.of(context).scaffoldBackgroundColor,
                textSize: r.fontSize(15),
                textWeight: FontWeight.w500,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

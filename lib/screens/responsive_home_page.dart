import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/responsive_dimensions.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/theme_toggle.dart';
import '../theme/app_colors.dart';
import '../theme/theme_notifier.dart';
import 'local_storage_demo.dart';

class ResponsiveHomePage extends ConsumerStatefulWidget {
  const ResponsiveHomePage({super.key});

  @override
  ConsumerState<ResponsiveHomePage> createState() => _ResponsiveHomePageState();
}

class _ResponsiveHomePageState extends ConsumerState<ResponsiveHomePage> {
  @override
  Widget build(BuildContext context) {
    ResponsiveDimensions.init(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            color: AppColors.getTextPrimaryColor(context),
          ),
        ),
        backgroundColor: AppColors.getSurfaceColor(context),
        foregroundColor: AppColors.getTextPrimaryColor(context),
        actions: [
          const ThemeToggle(),
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: AppColors.getTextSecondaryColor(context),
            ),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      body: ResponsiveLayout(
        mobile: _buildMobileLayout(),
        tablet: _buildTabletLayout(),
        desktop: _buildDesktopLayout(),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.getNavigationBarColor(context),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.home,
            label: 'Home',
            isSelected: true,
            context: context,
          ),
          _buildNavItem(
            icon: Icons.storage,
            label: 'Storage',
            isSelected: false,
            context: context,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LocalStorageDemo()),
            ),
          ),
          _buildNavItem(
            icon: Icons.shopping_bag,
            label: 'Shop',
            isSelected: false,
            context: context,
          ),
          _buildNavItem(
            icon: Icons.person,
            label: 'Profile',
            isSelected: false,
            context: context,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required BuildContext context,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryGold : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color: isSelected 
                  ? AppColors.getTextPrimaryColor(context)
                  : AppColors.getTextInactiveColor(context),
              size: 24,
            ),
          ),
          if (isSelected)
            Text(
              label,
              style: TextStyle(
                color: AppColors.primaryGold,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(ResponsiveDimensions.getPadding(4)),
      child: ResponsiveColumn(
        spacing: 4,
        children: [
          _buildHeroSection(),
          _buildDevicesSection(),
          _buildFeatureGrid(),
          _buildInfoSection(),
        ],
      ),
    );
  }

  Widget _buildTabletLayout() {
    return Row(
      children: [
        // Left sidebar
        Container(
          width: ResponsiveDimensions.getWidth(30),
          padding: EdgeInsets.all(ResponsiveDimensions.getPadding(4)),
          child: ResponsiveColumn(
            spacing: 4,
            children: [
              _buildHeroSection(),
              _buildDevicesSection(),
            ],
          ),
        ),
        // Right content
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(ResponsiveDimensions.getPadding(4)),
            child: ResponsiveColumn(
              spacing: 4,
              children: [
                _buildFeatureGrid(),
                _buildInfoSection(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        // Left sidebar
        Container(
          width: ResponsiveDimensions.getWidth(25),
          padding: EdgeInsets.all(ResponsiveDimensions.getPadding(4)),
          child: ResponsiveColumn(
            spacing: 4,
            children: [
              _buildHeroSection(),
              _buildDevicesSection(),
            ],
          ),
        ),
        // Center content
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(ResponsiveDimensions.getPadding(4)),
            child: ResponsiveColumn(
              spacing: 4,
              children: [
                _buildFeatureGrid(),
                _buildInfoSection(),
              ],
            ),
          ),
        ),
        // Right sidebar
        Container(
          width: ResponsiveDimensions.getWidth(20),
          padding: EdgeInsets.all(ResponsiveDimensions.getPadding(4)),
          child: _buildQuickActions(),
        ),
      ],
    );
  }

  Widget _buildHeroSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.getSurfaceColor(context),
        borderRadius: BorderRadius.circular(ResponsiveDimensions.cardRadius),
      ),
      padding: EdgeInsets.all(ResponsiveDimensions.getPadding(4)),
      child: ResponsiveColumn(
        spacing: 3,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ResponsiveColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(
                      'Regel Elixir',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: AppColors.getTextPrimaryColor(context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'A majestic blend of luxury and power, fit for royalty.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.getTextSecondaryColor(context),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Placeholder for perfume bottle image
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primaryGold.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.local_bar,
                  size: 40,
                  color: AppColors.primaryGold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 20,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.primaryGold,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 20,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.getTextInactiveColor(context),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 20,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.getTextInactiveColor(context),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDevicesSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.getSurfaceColor(context),
        borderRadius: BorderRadius.circular(ResponsiveDimensions.cardRadius),
      ),
      padding: EdgeInsets.all(ResponsiveDimensions.getPadding(4)),
      child: ResponsiveColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 3,
        children: [
          Text(
            'My Devices',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.getTextPrimaryColor(context),
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.battery_alert,
                      color: AppColors.accentRed,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Low Battery',
                        style: TextStyle(
                          color: AppColors.accentRed,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Placeholder for device image
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.primaryGold.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  Icons.devices,
                  size: 30,
                  color: AppColors.primaryGold,
                ),
              ),
            ],
          ),
          Text(
            'Evergreen Terrace',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.getTextSecondaryColor(context),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.flash_on,
                    color: AppColors.primaryGold,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '77%',
                    style: TextStyle(
                      color: AppColors.getTextSecondaryColor(context),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.water_drop,
                    color: AppColors.primaryGold,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '15%',
                    style: TextStyle(
                      color: AppColors.getTextSecondaryColor(context),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureGrid() {
    final features = [
      {'icon': Icons.phone_android, 'title': 'Mobile First', 'description': 'Optimized for mobile devices'},
      {'icon': Icons.tablet_android, 'title': 'Tablet Ready', 'description': 'Perfect for tablet screens'},
      {'icon': Icons.desktop_windows, 'title': 'Desktop Compatible', 'description': 'Full desktop experience'},
      {'icon': Icons.screen_rotation, 'title': 'Orientation Aware', 'description': 'Adapts to screen rotation'},
      {'icon': Icons.restore_page, 'title': 'Responsive Design', 'description': 'Scales to any screen size'},
      {'icon': Icons.view_agenda, 'title': 'Adaptive Layout', 'description': 'Smart layout switching'},
    ];

    return ResponsiveGrid(
      mobileColumns: 1,
      tabletColumns: 2,
      desktopColumns: 3,
      spacing: 3,
      runSpacing: 3,
      children: features.map((feature) => _buildFeatureCard(feature)).toList(),
    );
  }

  Widget _buildFeatureCard(Map<String, dynamic> feature) {
    return Card(
      color: AppColors.getSurfaceColor(context),
      child: Padding(
        padding: EdgeInsets.all(ResponsiveDimensions.getPadding(3)),
        child: ResponsiveColumn(
          spacing: 2,
          children: [
            Icon(
              feature['icon'],
              size: ResponsiveDimensions.iconSize * 1.5,
              color: AppColors.primaryGold,
            ),
            Text(
              feature['title'] as String,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.getTextPrimaryColor(context),
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              feature['description'] as String,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.getTextSecondaryColor(context),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Card(
      color: AppColors.getSurfaceColor(context),
      child: Padding(
        padding: EdgeInsets.all(ResponsiveDimensions.getPadding(4)),
        child: ResponsiveColumn(
          spacing: 3,
          children: [
            Text(
              'Device Information',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.getTextPrimaryColor(context),
                fontWeight: FontWeight.w600,
              ),
            ),
            _buildInfoRow('Screen Width', '${ResponsiveDimensions.screenWidth.toStringAsFixed(1)} px'),
            _buildInfoRow('Screen Height', '${ResponsiveDimensions.screenHeight.toStringAsFixed(1)} px'),
            _buildInfoRow('Device Type', ResponsiveDimensions.isMobile ? 'Mobile' : ResponsiveDimensions.isTablet ? 'Tablet' : 'Desktop'),
            _buildInfoRow('Orientation', ResponsiveDimensions.isPortrait ? 'Portrait' : 'Landscape'),
            _buildInfoRow('Status Bar Height', '${ResponsiveDimensions.statusBarHeight.toStringAsFixed(1)} px'),
            _buildInfoRow('Bottom Padding', '${ResponsiveDimensions.bottomPadding.toStringAsFixed(1)} px'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return ResponsiveRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.getTextPrimaryColor(context),
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.primaryGold,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      {'icon': Icons.settings, 'label': 'Settings'},
      {'icon': Icons.help, 'label': 'Help'},
      {'icon': Icons.info, 'label': 'About'},
      {'icon': Icons.feedback, 'label': 'Feedback'},
    ];

    return ResponsiveColumn(
      spacing: 2,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.getTextPrimaryColor(context),
          ),
        ),
        ...actions.map((action) => ListTile(
          leading: Icon(
            action['icon'] as IconData,
            color: AppColors.primaryGold,
          ),
          title: Text(
            action['label'] as String,
            style: TextStyle(
              color: AppColors.getTextPrimaryColor(context),
            ),
          ),
          onTap: () {},
        )),
      ],
    );
  }
}

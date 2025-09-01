import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/local_storage_provider.dart';
import '../theme/app_colors.dart';
import '../utils/responsive_dimensions.dart';
import '../widgets/responsive_layout.dart';

class LocalStorageDemo extends ConsumerStatefulWidget {
  const LocalStorageDemo({super.key});

  @override
  ConsumerState<LocalStorageDemo> createState() => _LocalStorageDemoState();
}

class _LocalStorageDemoState extends ConsumerState<LocalStorageDemo> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _favoriteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load current values when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCurrentValues();
    });
  }

  void _loadCurrentValues() {
    final userPrefs = ref.read(userPreferencesProvider);
    final appSettings = ref.read(appSettingsProvider);
    
    _nameController.text = userPrefs.name ?? '';
    _ageController.text = userPrefs.age?.toString() ?? '';
    _heightController.text = userPrefs.height?.toString() ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _favoriteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveDimensions.init(context);
    
    final userPrefs = ref.watch(userPreferencesProvider);
    final appSettings = ref.watch(appSettingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Local Storage Demo',
          style: TextStyle(
            color: AppColors.getTextPrimaryColor(context),
          ),
        ),
        backgroundColor: AppColors.getSurfaceColor(context),
        foregroundColor: AppColors.getTextPrimaryColor(context),
      ),
      body: ResponsiveLayout(
        mobile: _buildMobileLayout(userPrefs, appSettings),
        tablet: _buildTabletLayout(userPrefs, appSettings),
        desktop: _buildDesktopLayout(userPrefs, appSettings),
      ),
    );
  }

  Widget _buildMobileLayout(UserPreferences userPrefs, AppSettings appSettings) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(ResponsiveDimensions.getPadding(4)),
      child: ResponsiveColumn(
        spacing: 4,
        children: [
          _buildUserPreferencesSection(userPrefs),
          _buildAppSettingsSection(appSettings),
          _buildStorageOperationsSection(),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(UserPreferences userPrefs, AppSettings appSettings) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(ResponsiveDimensions.getPadding(4)),
            child: ResponsiveColumn(
              spacing: 4,
              children: [
                _buildUserPreferencesSection(userPrefs),
                _buildStorageOperationsSection(),
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(ResponsiveDimensions.getPadding(4)),
            child: _buildAppSettingsSection(appSettings),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(UserPreferences userPrefs, AppSettings appSettings) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(ResponsiveDimensions.getPadding(4)),
            child: _buildUserPreferencesSection(userPrefs),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(ResponsiveDimensions.getPadding(4)),
            child: _buildAppSettingsSection(appSettings),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(ResponsiveDimensions.getPadding(4)),
            child: _buildStorageOperationsSection(),
          ),
        ),
      ],
    );
  }

  Widget _buildUserPreferencesSection(UserPreferences userPrefs) {
    return Card(
      color: AppColors.getSurfaceColor(context),
      child: Padding(
        padding: EdgeInsets.all(ResponsiveDimensions.getPadding(4)),
        child: ResponsiveColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 3,
          children: [
            Text(
              'User Preferences',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.getTextPrimaryColor(context),
                fontWeight: FontWeight.w600,
              ),
            ),
            
            // String input
            _buildInputField(
              controller: _nameController,
              label: 'Name (String)',
              hint: 'Enter your name',
              onChanged: (value) => ref.read(userPreferencesProvider.notifier).updateName(value),
            ),
            
            // Int input
            _buildInputField(
              controller: _ageController,
              label: 'Age (Integer)',
              hint: 'Enter your age',
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final age = int.tryParse(value);
                if (age != null) {
                  ref.read(userPreferencesProvider.notifier).updateAge(age);
                }
              },
            ),
            
            // Double input
            _buildInputField(
              controller: _heightController,
              label: 'Height (Double)',
              hint: 'Enter your height in cm',
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final height = double.tryParse(value);
                if (height != null) {
                  ref.read(userPreferencesProvider.notifier).updateHeight(height);
                }
              },
            ),
            
            // Bool toggle
            _buildToggleTile(
              title: 'Dark Mode (Boolean)',
              subtitle: 'Toggle dark mode preference',
              value: userPrefs.isDarkMode,
              onChanged: (value) => ref.read(userPreferencesProvider.notifier).toggleDarkMode(),
            ),
            
            // Favorite items
            _buildFavoriteItemsSection(userPrefs),
          ],
        ),
      ),
    );
  }

  Widget _buildAppSettingsSection(AppSettings appSettings) {
    return Card(
      color: AppColors.getSurfaceColor(context),
      child: Padding(
        padding: EdgeInsets.all(ResponsiveDimensions.getPadding(4)),
        child: ResponsiveColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 3,
          children: [
            Text(
              'App Settings',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.getTextPrimaryColor(context),
                fontWeight: FontWeight.w600,
              ),
            ),
            
            _buildInfoRow('Language', appSettings.language),
            _buildInfoRow('Font Size', '${appSettings.fontSize}px'),
            _buildInfoRow('Volume', '${(appSettings.volume * 100).toInt()}%'),
            
            _buildToggleTile(
              title: 'Notifications',
              subtitle: 'Enable/disable notifications',
              value: appSettings.notificationsEnabled,
              onChanged: (value) => ref.read(appSettingsProvider.notifier).toggleNotifications(),
            ),
            
            const SizedBox(height: 16),
            
            // Settings controls
            _buildSliderTile(
              title: 'Font Size',
              value: appSettings.fontSize.toDouble(),
              min: 12,
              max: 24,
              divisions: 12,
              onChanged: (value) => ref.read(appSettingsProvider.notifier).updateFontSize(value.toInt()),
            ),
            
            _buildSliderTile(
              title: 'Volume',
              value: appSettings.volume,
              min: 0.0,
              max: 1.0,
              divisions: 10,
              onChanged: (value) => ref.read(appSettingsProvider.notifier).updateVolume(value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStorageOperationsSection() {
    return Card(
      color: AppColors.getSurfaceColor(context),
      child: Padding(
        padding: EdgeInsets.all(ResponsiveDimensions.getPadding(4)),
        child: ResponsiveColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 3,
          children: [
            Text(
              'Storage Operations',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.getTextPrimaryColor(context),
                fontWeight: FontWeight.w600,
              ),
            ),
            
            _buildActionButton(
              title: 'Clear User Preferences',
              subtitle: 'Remove all user preference data',
              icon: Icons.person_off,
              onPressed: () => _showClearDialog('user preferences', () {
                ref.read(userPreferencesProvider.notifier).clearPreferences();
                _nameController.clear();
                _ageController.clear();
                _heightController.clear();
              }),
            ),
            
            _buildActionButton(
              title: 'Clear App Settings',
              subtitle: 'Reset all app settings to default',
              icon: Icons.settings_backup_restore,
              onPressed: () => _showClearDialog('app settings', () {
                ref.read(appSettingsProvider.notifier).clearSettings();
              }),
            ),
            
            _buildActionButton(
              title: 'Clear All Data',
              subtitle: 'Remove all stored data',
              icon: Icons.delete_forever,
              onPressed: () => _showClearDialog('all data', () {
                ref.read(userPreferencesProvider.notifier).clearPreferences();
                ref.read(appSettingsProvider.notifier).clearSettings();
                _nameController.clear();
                _ageController.clear();
                _heightController.clear();
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    void Function(String)? onChanged,
  }) {
    return ResponsiveColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 1,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.getTextPrimaryColor(context),
            fontWeight: FontWeight.w500,
          ),
        ),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          onChanged: onChanged,
          style: TextStyle(color: AppColors.getTextPrimaryColor(context)),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: AppColors.getTextSecondaryColor(context)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.getTextInactiveColor(context)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.getTextInactiveColor(context)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.primaryGold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildToggleTile({
    required String title,
    required String subtitle,
    required bool value,
    required void Function(bool) onChanged,
  }) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.getTextPrimaryColor(context),
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: AppColors.getTextSecondaryColor(context)),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primaryGold,
      ),
    );
  }

  Widget _buildSliderTile({
    required String title,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required void Function(double) onChanged,
  }) {
    return ResponsiveColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 1,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.getTextPrimaryColor(context),
            fontWeight: FontWeight.w500,
          ),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          onChanged: onChanged,
          activeColor: AppColors.primaryGold,
        ),
        Text(
          '${value.toStringAsFixed(title == 'Volume' ? 2 : 0)}${title == 'Volume' ? '' : 'px'}',
          style: TextStyle(
            color: AppColors.primaryGold,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
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

  Widget _buildActionButton({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.accentRed,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.getTextPrimaryColor(context),
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: AppColors.getTextSecondaryColor(context)),
      ),
      onTap: onPressed,
    );
  }

  Widget _buildFavoriteItemsSection(UserPreferences userPrefs) {
    return ResponsiveColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: [
        Text(
          'Favorite Items (String List)',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.getTextPrimaryColor(context),
            fontWeight: FontWeight.w500,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _favoriteController,
                style: TextStyle(color: AppColors.getTextPrimaryColor(context)),
                decoration: InputDecoration(
                  hintText: 'Add favorite item',
                  hintStyle: TextStyle(color: AppColors.getTextSecondaryColor(context)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.getTextInactiveColor(context)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.getTextInactiveColor(context)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.primaryGold),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () {
                if (_favoriteController.text.isNotEmpty) {
                  ref.read(userPreferencesProvider.notifier).addFavoriteItem(_favoriteController.text);
                  _favoriteController.clear();
                }
              },
              icon: Icon(
                Icons.add,
                color: AppColors.primaryGold,
              ),
            ),
          ],
        ),
        if (userPrefs.favoriteItems.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: userPrefs.favoriteItems.map((item) => Chip(
              label: Text(
                item,
                style: TextStyle(color: AppColors.getTextPrimaryColor(context)),
              ),
              deleteIcon: Icon(
                Icons.close,
                color: AppColors.getTextPrimaryColor(context),
                size: 18,
              ),
              onDeleted: () => ref.read(userPreferencesProvider.notifier).removeFavoriteItem(item),
              backgroundColor: AppColors.primaryGold.withValues(alpha: 0.2),
            )).toList(),
          ),
      ],
    );
  }

  void _showClearDialog(String dataType, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Clear $dataType?',
          style: TextStyle(color: AppColors.getTextPrimaryColor(context)),
        ),
        content: Text(
          'This action cannot be undone. Are you sure you want to clear all $dataType?',
          style: TextStyle(color: AppColors.getTextSecondaryColor(context)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.getTextSecondaryColor(context)),
            ),
          ),
          TextButton(
            onPressed: () {
              onConfirm();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$dataType cleared successfully'),
                  backgroundColor: AppColors.primaryGold,
                ),
              );
            },
            child: Text(
              'Clear',
              style: TextStyle(color: AppColors.accentRed),
            ),
          ),
        ],
      ),
    );
  }
}

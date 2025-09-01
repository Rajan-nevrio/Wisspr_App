import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/theme_notifier.dart';
import '../theme/app_colors.dart';

class ThemeToggle extends ConsumerWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.read(themeNotifierProvider.notifier);
    final isDarkMode = ref.watch(themeNotifierProvider.notifier).isDarkMode;
    
    return PopupMenuButton<ThemeMode>(
      icon: Icon(
        isDarkMode ? Icons.dark_mode : Icons.light_mode,
        color: AppColors.getTextSecondaryColor(context),
      ),
      onSelected: (ThemeMode mode) {
        themeNotifier.setThemeMode(mode);
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<ThemeMode>(
          value: ThemeMode.system,
          child: Row(
            children: [
              Icon(
                Icons.settings_system_daydream,
                color: AppColors.getTextSecondaryColor(context),
              ),
              const SizedBox(width: 8),
              Text(
                'System',
                style: TextStyle(
                  color: AppColors.getTextPrimaryColor(context),
                ),
              ),
              if (ref.watch(themeNotifierProvider) == ThemeMode.system)
                Icon(
                  Icons.check,
                  color: AppColors.primaryGold,
                  size: 16,
                ),
            ],
          ),
        ),
        PopupMenuItem<ThemeMode>(
          value: ThemeMode.light,
          child: Row(
            children: [
              Icon(
                Icons.light_mode,
                color: AppColors.getTextSecondaryColor(context),
              ),
              const SizedBox(width: 8),
              Text(
                'Light',
                style: TextStyle(
                  color: AppColors.getTextPrimaryColor(context),
                ),
              ),
              if (ref.watch(themeNotifierProvider) == ThemeMode.light)
                Icon(
                  Icons.check,
                  color: AppColors.primaryGold,
                  size: 16,
                ),
            ],
          ),
        ),
        PopupMenuItem<ThemeMode>(
          value: ThemeMode.dark,
          child: Row(
            children: [
              Icon(
                Icons.dark_mode,
                color: AppColors.getTextSecondaryColor(context),
              ),
              const SizedBox(width: 8),
              Text(
                'Dark',
                style: TextStyle(
                  color: AppColors.getTextPrimaryColor(context),
                ),
              ),
              if (ref.watch(themeNotifierProvider) == ThemeMode.dark)
                Icon(
                  Icons.check,
                  color: AppColors.primaryGold,
                  size: 16,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

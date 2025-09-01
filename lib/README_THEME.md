# Theme System Documentation

## Overview
This Flutter app implements a comprehensive theme system that automatically adapts to the system theme (light/dark) and provides manual theme switching capabilities.

## Features

### 🎨 **Automatic System Theme Detection**
- Automatically follows the device's system theme setting
- Seamlessly switches between light and dark modes
- No manual intervention required

### 🌓 **Manual Theme Control**
- Toggle between Light, Dark, and System themes
- Theme toggle widget in the app bar
- Persistent theme selection

### 🎯 **Design-Based Color Scheme**
- **Primary Gold**: `#FFD700` - Used for accents, buttons, and highlights
- **Accent Red**: `#FF4444` - Used for alerts and warnings (e.g., "Low Battery")
- **Dark Theme**: Pure black backgrounds with white text and gold accents
- **Light Theme**: Light gray backgrounds with dark text and gold accents

## File Structure

```
lib/theme/
├── app_colors.dart          # Color constants and theme-aware color getters
├── responsive_theme.dart    # Theme data for light and dark modes
└── theme_provider.dart      # Theme state management
```

## Usage

### 1. Accessing Theme Colors

```dart
import '../theme/app_colors.dart';

// Get theme-aware colors
Color backgroundColor = AppColors.getBackgroundColor(context);
Color textColor = AppColors.getTextPrimaryColor(context);
Color surfaceColor = AppColors.getSurfaceColor(context);

// Get accent colors (same for both themes)
Color gold = AppColors.primaryGold;
Color red = AppColors.accentRed;
```

### 2. Using Theme Provider

```dart
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';

// Access theme provider
Consumer<ThemeProvider>(
  builder: (context, themeProvider, child) {
    bool isDark = themeProvider.isDarkMode;
    // Your widget here
  },
)

// Change theme
themeProvider.setThemeMode(ThemeMode.dark);
themeProvider.setThemeMode(ThemeMode.light);
themeProvider.setThemeMode(ThemeMode.system);
```

### 3. Theme Toggle Widget

```dart
import '../widgets/theme_toggle.dart';

// Add to app bar actions
AppBar(
  actions: [
    const ThemeToggle(),
    // Other actions...
  ],
)
```

## Color Palette

### Dark Theme Colors
- **Background**: `#000000` (Pure Black)
- **Surface**: `#1A1A1A` (Dark Gray)
- **Navigation Bar**: `#2A2A2A` (Medium Dark Gray)
- **Text Primary**: `#FFFFFF` (White)
- **Text Secondary**: `#CCCCCC` (Light Gray)
- **Text Inactive**: `#666666` (Medium Gray)

### Light Theme Colors
- **Background**: `#F8F9FA` (Light Gray)
- **Surface**: `#FFFFFF` (White)
- **Navigation Bar**: `#E9ECEF` (Light Gray)
- **Text Primary**: `#212529` (Dark)
- **Text Secondary**: `#6C757D` (Medium Gray)
- **Text Inactive**: `#ADB5BD` (Light Gray)

### Accent Colors (Both Themes)
- **Primary Gold**: `#FFD700` (Golden Yellow)
- **Accent Red**: `#FF4444` (Bright Red)

## Implementation Details

### Theme Data Structure
The app uses Material 3 design system with custom color schemes:

```dart
ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark, // or Brightness.light
  colorScheme: ColorScheme.dark( // or ColorScheme.light
    background: AppColors.darkBackground,
    surface: AppColors.darkSurface,
    primary: AppColors.primaryGold,
    secondary: AppColors.accentRed,
    // ... other color mappings
  ),
  // ... other theme configurations
)
```

### Responsive Design Integration
The theme system integrates with the responsive design system:
- Colors adapt to screen sizes
- Consistent spacing and typography
- Platform-aware theming

## Best Practices

1. **Always use theme-aware colors** instead of hardcoded colors
2. **Use AppColors.getter methods** for dynamic colors
3. **Test both themes** on different devices
4. **Maintain contrast ratios** for accessibility
5. **Use accent colors sparingly** for important elements only

## Testing Themes

### Manual Testing
1. Use the theme toggle in the app bar
2. Switch between Light, Dark, and System modes
3. Verify all UI elements adapt correctly

### System Theme Testing
1. Change device theme in system settings
2. Verify app automatically follows system theme
3. Test theme persistence across app restarts

## Future Enhancements

- [ ] Custom color schemes for different app sections
- [ ] Theme animation transitions
- [ ] User preference storage
- [ ] High contrast mode support
- [ ] Color blindness accessibility features

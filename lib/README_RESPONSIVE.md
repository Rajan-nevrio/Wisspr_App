# Responsive Design System for Flutter

This Flutter app includes a comprehensive responsive design system that automatically adapts to all device types, screen sizes, and orientations.

## Features

- **Multi-Device Support**: Automatically detects mobile, tablet, and desktop devices
- **Orientation Awareness**: Adapts layouts for portrait and landscape modes
- **Responsive Dimensions**: All sizes, fonts, and spacing scale proportionally
- **Smart Layouts**: Different layouts for different screen sizes
- **Theme Integration**: Responsive themes with Material 3 design
- **Safe Area Handling**: Automatically handles status bars, notches, and safe areas

## Architecture

### 1. ResponsiveDimensions (`lib/utils/responsive_dimensions.dart`)

The core utility class that provides responsive sizing calculations:

```dart
// Initialize dimensions
ResponsiveDimensions.init(context);

// Get responsive sizes
double fontSize = ResponsiveDimensions.getFontSize(16);
double padding = ResponsiveDimensions.getPadding(20);
double height = ResponsiveDimensions.getHeight(100);
double width = ResponsiveDimensions.getWidth(200);

// Device detection
bool isMobile = ResponsiveDimensions.isMobile;
bool isTablet = ResponsiveDimensions.isTablet;
bool isDesktop = ResponsiveDimensions.isDesktop;

// Orientation detection
bool isPortrait = ResponsiveDimensions.isPortrait;
bool isLandscape = ResponsiveDimensions.isLandscape;

// Common responsive values
double appBarHeight = ResponsiveDimensions.appBarHeight;
double buttonHeight = ResponsiveDimensions.buttonHeight;
double iconSize = ResponsiveDimensions.iconSize;
```

### 2. ResponsiveTheme (`lib/theme/responsive_theme.dart`)

Provides responsive themes that automatically scale with device size:

```dart
// Use in MaterialApp
theme: ResponsiveTheme.getLightTheme(context),
darkTheme: ResponsiveTheme.getDarkTheme(context),
```

### 3. ResponsiveLayout (`lib/widgets/responsive_layout.dart`)

Automatically switches between different layouts based on device type:

```dart
ResponsiveLayout(
  mobile: _buildMobileLayout(),
  tablet: _buildTabletLayout(),
  desktop: _buildDesktopLayout(),
  landscape: _buildLandscapeLayout(), // Optional
  portrait: _buildPortraitLayout(),   // Optional
)
```

### 4. Responsive Widgets

#### ResponsiveGrid
```dart
ResponsiveGrid(
  mobileColumns: 1,
  tabletColumns: 2,
  desktopColumns: 3,
  spacing: 16.0,
  children: [/* your widgets */],
)
```

#### ResponsiveRow & ResponsiveColumn
```dart
ResponsiveRow(
  spacing: 16.0,
  children: [/* your widgets */],
)

ResponsiveColumn(
  spacing: 16.0,
  children: [/* your widgets */],
)
```

#### ResponsiveContainer
```dart
ResponsiveContainer(
  width: 200,  // Will be converted to responsive width
  height: 100, // Will be converted to responsive height
  padding: EdgeInsets.all(20), // Will be converted to responsive padding
  child: YourWidget(),
)
```

### 5. ResponsiveBuilder
```dart
ResponsiveBuilder(
  builder: (context, dimensions) {
    return Text(
      'Screen: ${dimensions.screenWidth} x ${dimensions.screenWidth}',
      style: TextStyle(fontSize: dimensions.bodySize),
    );
  },
)
```

## Usage Examples

### Basic Responsive Layout
```dart
class MyResponsivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Responsive Page')),
      body: ResponsiveLayout(
        mobile: _buildMobileLayout(),
        tablet: _buildTabletLayout(),
        desktop: _buildDesktopLayout(),
      ),
    );
  }
  
  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      child: ResponsiveColumn(
        spacing: 4,
        children: [
          _buildHeader(),
          _buildContent(),
          _buildFooter(),
        ],
      ),
    );
  }
  
  Widget _buildTabletLayout() {
    return Row(
      children: [
        Container(
          width: ResponsiveDimensions.getWidth(30),
          child: _buildSidebar(),
        ),
        Expanded(child: _buildContent()),
      ],
    );
  }
  
  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Container(
          width: ResponsiveDimensions.getWidth(25),
          child: _buildSidebar(),
        ),
        Expanded(flex: 2, child: _buildContent()),
        Container(
          width: ResponsiveDimensions.getWidth(20),
          child: _buildRightPanel(),
        ),
      ],
    );
  }
}
```

### Responsive Grid Layout
```dart
ResponsiveGrid(
  mobileColumns: 1,
  tabletColumns: 2,
  desktopColumns: 4,
  spacing: 16.0,
  children: items.map((item) => _buildItemCard(item)).toList(),
)
```

### Responsive Typography
```dart
Text(
  'Hello World',
  style: TextStyle(
    fontSize: ResponsiveDimensions.h1Size,    // Responsive heading size
    fontWeight: FontWeight.bold,
  ),
)
```

### Responsive[README_THEME.md](README_THEME.md) Spacing
```dart
Container(
  padding: EdgeInsets.all(ResponsiveDimensions.getPadding(4)),
  margin: EdgeInsets.all(ResponsiveDimensions.getMargin(2)),
  child: YourWidget(),
)
```

## Best Practices

1. **Always Initialize**: Call `ResponsiveDimensions.init(context)` at the start of your build method
2. **Use Responsive Values**: Use `getPadding()`, `getHeight()`, `getWidth()` instead of fixed values
3. **Plan Multiple Layouts**: Design separate layouts for mobile, tablet, and desktop
4. **Test on Different Devices**: Use Flutter's device simulator to test various screen sizes
5. **Consider Orientation**: Design for both portrait and landscape modes
6. **Use Responsive Widgets**: Leverage `ResponsiveGrid`, `ResponsiveRow`, etc. for consistent spacing

## Device Breakpoints

- **Mobile**: < 600px width
- **Tablet**: 600px - 1199px width  
- **Desktop**: ≥ 1200px width

## Testing

To test responsiveness:

1. **Hot Reload**: Make changes and use hot reload to see immediate updates
2. **Device Simulator**: Use different device sizes in your IDE
3. **Orientation**: Rotate device/simulator to test landscape/portrait
4. **Window Resize**: Resize Flutter web window to test different sizes

## Performance

The responsive system is optimized for performance:
- Dimensions are calculated once per build
- No unnecessary rebuilds
- Efficient layout switching
- Minimal memory overhead

## Customization

You can customize the responsive system by:
- Modifying breakpoints in `ResponsiveDimensions`
- Adding new responsive values
- Creating custom responsive widgets
- Extending the theme system

## Support

This responsive design system works with:
- ✅ Android (all screen sizes)
- ✅ iOS (all screen sizes)
- ✅ Web (responsive browser windows)
- ✅ Desktop (resizable windows)
- ✅ All orientations (portrait/landscape)
- ✅ Material 3 design system
- ✅ Dark/Light theme support

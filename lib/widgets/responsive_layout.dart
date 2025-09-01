import 'package:flutter/material.dart';
import '../utils/responsive_dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? landscape;
  final Widget? portrait;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.landscape,
    this.portrait,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveDimensions.init(context);
    
    // Check if specific orientation widgets are provided
    if (ResponsiveDimensions.isLandscape && landscape != null) {
      return landscape!;
    }
    
    if (ResponsiveDimensions.isPortrait && portrait != null) {
      return portrait!;
    }
    
    // Check device type and return appropriate layout
    if (ResponsiveDimensions.isDesktop && desktop != null) {
      return desktop!;
    }
    
    if (ResponsiveDimensions.isTablet && tablet != null) {
      return tablet!;
    }
    
    // Default to mobile layout
    return mobile;
  }
}

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ResponsiveDimensions dimensions) builder;

  const ResponsiveBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveDimensions.init(context);
    return builder(context, ResponsiveDimensions as ResponsiveDimensions);
  }
}

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final int mobileColumns;
  final int tabletColumns;
  final int desktopColumns;
  final double spacing;
  final double runSpacing;
  final EdgeInsets padding;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.mobileColumns = 1,
    this.tabletColumns = 2,
    this.desktopColumns = 3,
    this.spacing = 16.0,
    this.runSpacing = 16.0,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveDimensions.init(context);
    
    int columns = mobileColumns;
    if (ResponsiveDimensions.isTablet) {
      columns = tabletColumns;
    } else if (ResponsiveDimensions.isDesktop) {
      columns = desktopColumns;
    }
    
    return Padding(
      padding: padding,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: ResponsiveDimensions.getPadding(spacing),
          mainAxisSpacing: ResponsiveDimensions.getPadding(runSpacing),
          childAspectRatio: _getChildAspectRatio(),
        ),
        itemCount: children.length,
        itemBuilder: (context, index) => children[index],
      ),
    );
  }
  
  double _getChildAspectRatio() {
    if (ResponsiveDimensions.isMobile) {
      return 1.0;
    } else if (ResponsiveDimensions.isTablet) {
      return 1.2;
    } else {
      return 1.5;
    }
  }
}

class ResponsiveRow extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final EdgeInsets padding;
  final double spacing;

  const ResponsiveRow({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.padding = EdgeInsets.zero,
    this.spacing = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveDimensions.init(context);
    
    List<Widget> spacedChildren = [];
    for (int i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i < children.length - 1) {
        spacedChildren.add(
          SizedBox(width: ResponsiveDimensions.getPadding(spacing)),
        );
      }
    }
    
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        children: spacedChildren,
      ),
    );
  }
}

class ResponsiveColumn extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final EdgeInsets padding;
  final double spacing;

  const ResponsiveColumn({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.padding = EdgeInsets.zero,
    this.spacing = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveDimensions.init(context);
    
    List<Widget> spacedChildren = [];
    for (int i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i < children.length - 1) {
        spacedChildren.add(
          SizedBox(height: ResponsiveDimensions.getPadding(spacing)),
        );
      }
    }
    
    return Padding(
      padding: padding,
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        children: spacedChildren,
      ),
    );
  }
}

class ResponsiveContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Decoration? decoration;
  final AlignmentGeometry? alignment;
  final Clip clipBehavior;

  const ResponsiveContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.decoration,
    this.alignment,
    this.clipBehavior = Clip.none,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveDimensions.init(context);
    
    return Container(
      width: width != null ? ResponsiveDimensions.getWidth(width!) : null,
      height: height != null ? ResponsiveDimensions.getHeight(height!) : null,
      margin: margin != null 
          ? EdgeInsets.all(ResponsiveDimensions.getPadding(margin!.top))
          : null,
      padding: padding != null 
          ? EdgeInsets.all(ResponsiveDimensions.getPadding(padding!.top))
          : null,
      decoration: decoration,
      alignment: alignment,
      clipBehavior: clipBehavior,
      child: child,
    );
  }
}

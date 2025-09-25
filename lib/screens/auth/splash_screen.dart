import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisspr_app/main.dart';
import 'package:wisspr_app/resources/app_strings.dart';
import 'package:wisspr_app/resources/dimension_spacing/vertical_spacing.dart';
import '../../commom_widgets/customer_text/marcellus_font_type_text.dart';
import '../../commom_widgets/customer_text/rougr_script_font_type_text.dart';
import '../../commom_widgets/customer_text/satoshi_font_type_text.dart';
import '../../resources/image_path.dart';
import '../../utils/responsive_dimensions.dart';
import '../../utils/performance_helper.dart';
import '../../providers/auth/splash_provider.dart';
import '../../routes/navigation_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late SplashProvider _splashProvider;

  @override
  void initState() {
    super.initState();
    _splashProvider = Provider.of<SplashProvider>(context, listen: false);
    _splashProvider.initializeAnimations(this);
    _splashProvider.addListener(_onNavigationStateChanged);
  }

  void _onNavigationStateChanged() {
    if (_splashProvider.isNavigating && mounted) {
      if (_splashProvider.navigationDestination == 'home') {
        NavigationHelper.goToHome(context);
      } else {
        NavigationHelper.goToIntro(context);
      }
    }
  }

  @override
  void dispose() {
    _splashProvider.removeListener(_onNavigationStateChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveDimensions()..init(context);

    return PerformanceHelper.optimizeWidget(
      Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              VerticalSpacing(height: 200),
              
              /// Logo with Selector - only rebuilds when logo visibility changes
              Selector<SplashProvider, bool>(
                selector: (context, provider) => provider.isLogoVisible,
                builder: (context, isLogoVisible, child) {
                  return Center(
                    child: AnimatedOpacity(
                      opacity: isLogoVisible ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 1200),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 1200),
                        curve: Curves.elasticOut,
                        transform: Matrix4.identity()
                          ..scale(isLogoVisible ? 1.0 : 0.5)
                          ..translate(0.0, isLogoVisible ? 0.0 : -50.0),
                        child: SizedBox(
                          width: responsive.width(120),
                          height: responsive.width(210),
                          child: Image.asset(
                            ImgPath.appLogo,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.apps,
                                size: responsive.width(60),
                                color: Theme.of(context).colorScheme.primary,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              
              VerticalSpacing(height: 4),
              
              /// Title with Selector - only rebuilds when title visibility changes
              Selector<SplashProvider, bool>(
                selector: (context, provider) => provider.isTitleVisible,
                builder: (context, isTitleVisible, child) {
                  return AnimatedOpacity(
                    opacity: isTitleVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 800),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOutCubic,
                      transform: Matrix4.identity()
                        ..translate(isTitleVisible ? 0.0 : -30.0, 0.0),
                      child: MText(
                        msg: AppStrings.appName,
                        textSize: responsive.fontSize(40),
                        textWeight: FontWeight.bold,
                        textColor: Theme.of(context).colorScheme.primaryFixed,
                        letterSpacing: 1.2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
              
              VerticalSpacing(height: 16),
              
              /// Tagline with Selector - only rebuilds when tagline visibility changes
              Selector<SplashProvider, bool>(
                selector: (context, provider) => provider.isTaglineVisible,
                builder: (context, isTaglineVisible, child) {
                  return AnimatedOpacity(
                    opacity: isTaglineVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 800),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOutCubic,
                      transform: Matrix4.identity()
                        ..translate(isTaglineVisible ? 0.0 : 30.0, 0.0),
                      child: RText(
                        msg: AppStrings.splashDescription,
                        textSize: responsive.fontSize(20),
                        textColor: Theme.of(context).colorScheme.tertiary,
                        letterSpacing: 0.5,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
              
              Spacer(),
              
              /// Version with Selector - only rebuilds when version visibility changes
              Selector<SplashProvider, bool>(
                selector: (context, provider) => provider.isVersionVisible,
                builder: (context, isVersionVisible, child) {
                  return AnimatedOpacity(
                    opacity: isVersionVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 600),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutCubic,
                      transform: Matrix4.identity()
                        ..translate(0.0, isVersionVisible ? 0.0 : 50.0),
                      child: SText(
                        msg: appVersion,
                        textSize: responsive.fontSize(14),
                        textColor: Theme.of(context).colorScheme.tertiary,
                        textWeight: FontWeight.w200,
                        letterSpacing: 0.5,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
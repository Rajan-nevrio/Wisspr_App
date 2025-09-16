import 'package:flutter/material.dart';
import 'package:wisspr_app/theme/font_constants.dart';
import '../../utils/responsive_dimensions.dart';
import '../../utils/performance_helper.dart';
import '../../routes/navigation_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoAnimationController;
  late AnimationController _titleAnimationController;
  late AnimationController _taglineAnimationController;
  late AnimationController _versionAnimationController;
  
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _logoScaleAnimation;
  late Animation<Offset> _logoSlideAnimation;
  
  late Animation<double> _titleFadeAnimation;
  late Animation<Offset> _titleSlideAnimation;
  
  late Animation<double> _taglineFadeAnimation;
  late Animation<Offset> _taglineSlideAnimation;
  
  late Animation<double> _versionFadeAnimation;
  late Animation<Offset> _versionSlideAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _navigateToIntro();
  }

  void _setupAnimations() {
    // Logo animations
    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _logoScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    _logoSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _logoAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Title animations
    _titleAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _titleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _titleAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _titleSlideAnimation = Tween<Offset>(
      begin: const Offset(-0.3, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _titleAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Tagline animations
    _taglineAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _taglineFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _taglineAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _taglineSlideAnimation = Tween<Offset>(
      begin: const Offset(0.3, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _taglineAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Version animations
    _versionAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _versionFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _versionAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _versionSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _versionAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );

    /// Start animations with staggered timing
    _startStaggeredAnimations();
  }

  void _startStaggeredAnimations() {
    _logoAnimationController.forward();
    
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _titleAnimationController.forward();
    });
    
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) _taglineAnimationController.forward();
    });
    
    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) _versionAnimationController.forward();
    });
  }

  void _navigateToIntro() {
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        NavigationHelper.goToIntro(context);
      }
    });
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _titleAnimationController.dispose();
    _taglineAnimationController.dispose();
    _versionAnimationController.dispose();
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
              responsive.sizedBox(height: 200),
              Center(
                child: AnimatedBuilder(
                  animation: _logoAnimationController,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _logoFadeAnimation,
                      child: SlideTransition(
                        position: _logoSlideAnimation,
                        child: ScaleTransition(
                          scale: _logoScaleAnimation,
                          child: SizedBox(
                            width: responsive.width(120),
                            height: responsive.width(210),
                            child: Image.asset(
                              'assets/logo/app_logo.png',
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
              ),
              responsive.sizedBox(height: 8),
              AnimatedBuilder(
                animation: _titleAnimationController,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _titleFadeAnimation,
                    child: SlideTransition(
                      position: _titleSlideAnimation,
                      child: Text(
                        'Wisspr',
                        style: TextStyle(
                          fontSize: responsive.fontSize(40),
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                         // fontFamily: FontConstants.marcellus,
                          letterSpacing: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
              responsive.sizedBox(height: 16),
              AnimatedBuilder(
                animation: _taglineAnimationController,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _taglineFadeAnimation,
                    child: SlideTransition(
                      position: _taglineSlideAnimation,
                      child: Text(
                        "Hygiene's best kept secret…shh!",
                        style: TextStyle(
                          fontSize: responsive.fontSize(16),
                          color: Theme.of(context).colorScheme.tertiary,
                          letterSpacing: 0.5,
                         // fontFamily: FontConstants.satoshi,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
              Spacer(),
              AnimatedBuilder(
                animation: _versionAnimationController,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _versionFadeAnimation,
                    child: SlideTransition(
                      position: _versionSlideAnimation,
                      child: Text(
                        'Version 1.0',
                        style: TextStyle(
                         //fontFamily: FontConstants.satoshi,
                          fontSize: responsive.fontSize(12),
                          color: Theme.of(context).colorScheme.tertiary,
                          letterSpacing: 0.5,
                        ),
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

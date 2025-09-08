import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisspr_app/theme/font_constants.dart';
import '../utils/responsive_dimensions.dart';
import '../utils/performance_helper.dart';
import '../routes/navigation_helper.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _imageAnimationController;

  final List<IntroSlide> _slides = [
    IntroSlide(
      title: 'Welcome to Wisspr!',
      description: 'Your Journey to a Fragrant \nHome Begins Here!',
      icon: "assets/image/Oboarding-1.png",
      color: const Color(0x00000000),
    ),
    IntroSlide(
      title: 'Scents for Every Story',
      description: "Explore curated aromas crafted \nto elevate every space.",
      icon: "assets/image/Onboarding-2.png",
      color: const Color(0x00000000),
    ),
    IntroSlide(
      title: 'Intelligence in the Air',
      description: 'Experience the art of fragrance \nautomation.',
      icon: "assets/image/Onboarding-3.png",
      color: const Color(0x00000000),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _imageAnimationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    Tween<double>(
      begin: 1.0,
      end: 0.3,
    ).animate(CurvedAnimation(
      parent: _imageAnimationController,
      curve: Curves.easeInOut,
    ));
    
    _imageAnimationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _imageAnimationController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToHome();
    }
  }

  void _skipIntro() {
    _navigateToHome();
  }

  void _navigateToHome() {
    NavigationHelper.goToSignup(context);
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveDimensions()..init(context);

    return PerformanceHelper.optimizeWidget(
      Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              // Skip button (only on first two screens)
              if (_currentPage < _slides.length - 1)
                Padding(
                  padding: EdgeInsets.only(
                    top: responsive.height(20),
                    right: responsive.width(20),
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _skipIntro,
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          fontFamily: FontConstants.satoshi,
                          fontSize: responsive.fontSize(16),
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              
              // Page view
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _slides.length,
                  itemBuilder: (context, index) {
                    return _buildSlide(_slides[index], responsive);
                  },
                ),
              ),

              // Page indicators and navigation
              _buildBottomSection(responsive),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlide(IntroSlide slide, ResponsiveDimensions responsive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Image at the top
        SizedBox(
          width: double.infinity,
          height: responsive.height(440),
          child: Image.asset(
            slide.icon,
            fit: BoxFit.cover,
          ),
        ),

        SizedBox(height: responsive.height(40)),

        // Title
        TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 600),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: Text(
                  slide.title,
                  style: GoogleFonts.marcellus(
                    textStyle: TextStyle(
                      fontSize: responsive.fontSize(28),
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        ),

        SizedBox(height: responsive.height(20)),

        // Description
        TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 800),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: Text(
                  slide.description,
                  style: GoogleFonts.marcellus(
                    textStyle: TextStyle(
                      fontSize: responsive.fontSize(16),
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withAlpha(200),
                      height: 1.5,
                      letterSpacing: 0.3,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBottomSection(ResponsiveDimensions responsive) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: responsive.width(40),
        vertical: responsive.height(40),
      ),
      child: Column(
        children: [

          // Continue button (only on last screen)
          if (_currentPage == _slides.length - 1)
            SizedBox(
              width: double.infinity,
              height: responsive.height(56),
              child: ElevatedButton(
                onPressed: _nextPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    fontFamily: FontConstants.satoshi,
                    fontSize: responsive.fontSize(16),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),

          SizedBox(height: responsive.height(40)),

          // Page indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _slides.length,
                  (index) => _buildPageIndicator(index, responsive),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(int index, ResponsiveDimensions responsive) {
    final isActive = index == _currentPage;
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: responsive.width(4)),
      width: responsive.width(24),
      height: responsive.height(5),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white.withAlpha(84),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}

class IntroSlide {
  final String title;
  final String description;
  final String icon;
  final Color color;

  IntroSlide({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

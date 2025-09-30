import 'package:flutter/material.dart';
import 'package:wisspr_app/resources/image_path.dart';
import '../../resources/app_strings.dart';
import '../../routes/navigation_helper.dart';

/// Provider class to manage intro screen state
class IntroProvider extends ChangeNotifier {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _imageAnimationController;

  PageController get pageController => _pageController;
  int get currentPage => _currentPage;
  AnimationController get imageAnimationController => _imageAnimationController;

  /// Intro slides data.
  List<IntroSlide> get slides => [
    IntroSlide(
      title: AppStrings.welcomeToWisspr,
      description: AppStrings.yourJourneyToAFragrantHomeBeginsHere,
      icon: ImgPath.onBoarding1,
    ),
    IntroSlide(
      title: AppStrings.scentsForEveryStory,
      description: AppStrings.exploreCuratedAromasCraftedToElevateEverySpace,
      icon: ImgPath.onBoarding2,
    ),
    IntroSlide(
      title: AppStrings.intelligenceInTheAir,
      description: AppStrings.experienceTheArtOfFragranceAutomation,
      icon: ImgPath.onBoarding3,
    ),
  ];

  /// Initialize the provider with animation controller
  void initialize(TickerProvider vsync) {
    _imageAnimationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: vsync,
    );

    Tween<double>(begin: 1.0, end: 0.3).animate(
      CurvedAnimation(
        parent: _imageAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _imageAnimationController.forward();
  }

  /// Handle page change
  void onPageChanged(int index) {
    _currentPage = index;
    notifyListeners();
  }

  /// Navigate to next page
  void nextPage(BuildContext context) {
    if (_currentPage < slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      navigateToSignUp(context);
    }
  }

  /// Skip intro and navigate to signup
  void skipIntro(BuildContext context) {
    navigateToSignUp(context);
  }

  /// Navigate to signup screen
  void navigateToSignUp(BuildContext context) {
    NavigationHelper.goToSignIn(context);
    notifyListeners();
  }

  /// Check if skip button should be shown
  bool get shouldShowSkipButton => _currentPage < slides.length - 1;

  /// Check if this is the last page
  bool get isLastPage => _currentPage == slides.length - 1;

  @override
  void dispose() {
    _pageController.dispose();
    _imageAnimationController.dispose();
    super.dispose();
  }
}

/// Model to pass UI data for intro slides
class IntroSlide {
  final String title;
  final String description;
  final String icon;

  IntroSlide({
    required this.title,
    required this.description,
    required this.icon,
  });
}

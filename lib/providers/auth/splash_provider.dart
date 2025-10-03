import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:wisspr_app/resources/local_storage.dart';

class SplashProvider with ChangeNotifier {
  LocalStorage storage = LocalStorage();
  bool _isLogoVisible = false;
  bool _isTitleVisible = false;
  bool _isTaglineVisible = false;
  bool _isVersionVisible = false;

  bool _isNavigating = false;
  String _navigationDestination = '';

  double _logoProgress = 0.0;
  double _titleProgress = 0.0;
  double _taglineProgress = 0.0;
  double _versionProgress = 0.0;

  bool get isLogoVisible => _isLogoVisible;
  bool get isTitleVisible => _isTitleVisible;
  bool get isTaglineVisible => _isTaglineVisible;
  bool get isVersionVisible => _isVersionVisible;

  bool get isNavigating => _isNavigating;
  String get navigationDestination => _navigationDestination;
  
  double get logoProgress => _logoProgress;
  double get titleProgress => _titleProgress;
  double get taglineProgress => _taglineProgress;
  double get versionProgress => _versionProgress;
  final AudioPlayer _player = AudioPlayer()..setReleaseMode(ReleaseMode.stop);
  bool _played = false;

  /// Method used to play audio.
  Future<void> playStartupTone() async {
    if (_played) return;
    _played = true;
    try {
      debugPrint("-----> Audio Playing...");
      await _player.setVolume(0.4);
      await _player.play(AssetSource("assets/audio/start_up_tone.mp3"));
      debugPrint("-----> Audio done.");
    } catch (e) {
      debugPrint('Startup tone failed:------> $e');
    }
  }


  /// Initialize splash animations
  void initializeAnimations(TickerProvider vsync) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startStaggeredAnimations();
      _startNavigationTimer();
      playStartupTone();
    });
  }

  /// Start staggered animations
  void _startStaggeredAnimations() {
    /// Logo animation
    _animateLogo();

    /// Title animation (300ms delay)
    Future.delayed(const Duration(milliseconds: 300), () {
      _animateTitle();
    });
    
    /// Tagline animation (600ms delay)
    Future.delayed(const Duration(milliseconds: 600), () {
      _animateTagline();
    });
    
    /// Version animation (900ms delay)
    Future.delayed(const Duration(milliseconds: 900), () {
      _animateVersion();
    });
  }

  /// Animate logo
  void _animateLogo() {
    _isLogoVisible = true;
    _logoProgress = 1.0;
    _safeNotifyListeners();
  }

  /// Animate title
  void _animateTitle() {
    _isTitleVisible = true;
    _titleProgress = 1.0;
    _safeNotifyListeners();
  }

  /// Animate tagline
  void _animateTagline() {
    _isTaglineVisible = true;
    _taglineProgress = 1.0;
    _safeNotifyListeners();
  }

  /// Animate version
  void _animateVersion() {
    _isVersionVisible = true;
    _versionProgress = 1.0;
    _safeNotifyListeners();
  }

  /// Start navigation timer
  Future<void> _startNavigationTimer() async {
    Future.delayed(const Duration(seconds: 2), () async {
      if (!_isNavigating) {
        await _checkAccessTokenAndNavigate();
      }
    });
  }

  /// Check access token and navigate accordingly
  Future<void> _checkAccessTokenAndNavigate() async {
    try {
      final token = await storage.getAccessToken();
      debugPrint('Access token check:------> ${token.isNotEmpty ? "Found" : "Not found"}');
      
      if (token.isNotEmpty) {
        _navigateToHome();
      } else {
        _navigateToIntro();
      }
    } catch (error) {
      debugPrint('Error checking access token:------>  $error');
      debugPrint('------> Navigating to intro screen (error occurred)');
      _navigateToIntro();
    }
  }

  /// Navigate to intro screen
  void _navigateToIntro() {
    _isNavigating = true;
    _navigationDestination = 'intro';
    _safeNotifyListeners();
  }

  /// Navigate to home screen
  void _navigateToHome() {
    _isNavigating = true;
    _navigationDestination = 'home';
    _safeNotifyListeners();
  }

  /// Safe notify listeners - ensures it's called after build phase
  void _safeNotifyListeners() {
    if (WidgetsBinding.instance.schedulerPhase == SchedulerPhase.idle) {
      notifyListeners();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
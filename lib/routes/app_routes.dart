import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/intro_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/main_navigation_screen.dart';

/// Centralized route management class for the entire app
class AppRoutes {
  // Private constructor to prevent instantiation
  AppRoutes._();

  // ========================================
  // ROUTE KEYS
  // ========================================
  
  // Main app routes
  static const String splash = '/';
  static const String intro = '/intro';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String mainNavigation = '/main-navigation';
  static const String responsive = '/responsive';
  static const String sharedPreferences = '/sharedprefs';
  static const String routeExample = '/route-example';
  
  // Authentication routes
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String verifyEmail = '/verify-email';
  
  // Profile routes
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String changePassword = '/change-password';
  static const String settings = '/settings';
  static const String privacyPolicy = '/privacy-policy';
  static const String termsOfService = '/terms-of-service';
  
  // Main feature routes
  static const String dashboard = '/dashboard';
  static const String notifications = '/notifications';
  static const String search = '/search';
  static const String favorites = '/favorites';
  static const String history = '/history';
  
  // Content routes
  static const String contentList = '/content-list';
  static const String contentDetail = '/content-detail';
  static const String createContent = '/create-content';
  static const String editContent = '/edit-content';
  
  // Media routes
  static const String gallery = '/gallery';
  static const String camera = '/camera';
  static const String imageViewer = '/image-viewer';
  static const String videoPlayer = '/video-player';
  
  // Communication routes
  static const String messages = '/messages';
  static const String chat = '/chat';
  static const String contacts = '/contacts';
  static const String call = '/call';
  
  // Utility routes
  static const String about = '/about';
  static const String help = '/help';
  static const String feedback = '/feedback';
  static const String support = '/support';
  static const String debug = '/debug';
  
  // Error routes
  static const String notFound = '/not-found';
  static const String error = '/error';
  static const String maintenance = '/maintenance';

  // ========================================
  // ROUTE GENERATOR
  // ========================================

  /// Generate routes for the app
  static Map<String, WidgetBuilder> get routes => {
    // Main app routes
    splash: (context) => const SplashScreen(),
    intro: (context) => const IntroScreen(),
    home: (context) => const MainNavigationScreen(),
    mainNavigation: (context) => const MainNavigationScreen(),
    responsive: (context) => const _PlaceholderScreen(title: 'Responsive Demo'),
    sharedPreferences: (context) => const _PlaceholderScreen(title: 'Data Storage'),
    routeExample: (context) => const _PlaceholderScreen(title: 'Route Examples'),
    
    // Authentication routes (placeholder widgets)
    login: (context) => const _PlaceholderScreen(title: 'Login'),
    register: (context) => const _PlaceholderScreen(title: 'Register'),
    forgotPassword: (context) => const _PlaceholderScreen(title: 'Forgot Password'),
    resetPassword: (context) => const _PlaceholderScreen(title: 'Reset Password'),
    verifyEmail: (context) => const _PlaceholderScreen(title: 'Verify Email'),
    
    // Profile routes (placeholder widgets)
    profile: (context) => const _PlaceholderScreen(title: 'Profile'),
    editProfile: (context) => const _PlaceholderScreen(title: 'Edit Profile'),
    changePassword: (context) => const _PlaceholderScreen(title: 'Change Password'),
    settings: (context) => const _PlaceholderScreen(title: 'Settings'),
    privacyPolicy: (context) => const _PlaceholderScreen(title: 'Privacy Policy'),
    termsOfService: (context) => const _PlaceholderScreen(title: 'Terms of Service'),
    
    // Main feature routes (placeholder widgets)
    dashboard: (context) => const _PlaceholderScreen(title: 'Dashboard'),
    notifications: (context) => const _PlaceholderScreen(title: 'Notifications'),
    search: (context) => const _PlaceholderScreen(title: 'Search'),
    favorites: (context) => const _PlaceholderScreen(title: 'Favorites'),
    history: (context) => const _PlaceholderScreen(title: 'History'),
    
    // Content routes (placeholder widgets)
    contentList: (context) => const _PlaceholderScreen(title: 'Content List'),
    contentDetail: (context) => const _PlaceholderScreen(title: 'Content Detail'),
    createContent: (context) => const _PlaceholderScreen(title: 'Create Content'),
    editContent: (context) => const _PlaceholderScreen(title: 'Edit Content'),
    
    // Media routes (placeholder widgets)
    gallery: (context) => const _PlaceholderScreen(title: 'Gallery'),
    camera: (context) => const _PlaceholderScreen(title: 'Camera'),
    imageViewer: (context) => const _PlaceholderScreen(title: 'Image Viewer'),
    videoPlayer: (context) => const _PlaceholderScreen(title: 'Video Player'),
    
    // Communication routes (placeholder widgets)
    messages: (context) => const _PlaceholderScreen(title: 'Messages'),
    chat: (context) => const _PlaceholderScreen(title: 'Chat'),
    contacts: (context) => const _PlaceholderScreen(title: 'Contacts'),
    call: (context) => const _PlaceholderScreen(title: 'Call'),
    
    // Utility routes (placeholder widgets)
    about: (context) => const _PlaceholderScreen(title: 'About'),
    help: (context) => const _PlaceholderScreen(title: 'Help'),
    feedback: (context) => const _PlaceholderScreen(title: 'Feedback'),
    support: (context) => const _PlaceholderScreen(title: 'Support'),
    debug: (context) => const _PlaceholderScreen(title: 'Debug'),
    
    // Error routes (placeholder widgets)
    notFound: (context) => const _PlaceholderScreen(title: 'Page Not Found'),
    error: (context) => const _PlaceholderScreen(title: 'Error'),
    maintenance: (context) => const _PlaceholderScreen(title: 'Maintenance'),
  };

  // ========================================
  // ROUTE GENERATOR WITH ARGUMENTS
  // ========================================

  /// Generate routes with arguments support
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: settings,
        );
      
      case intro:
        return MaterialPageRoute(
          builder: (context) => const IntroScreen(),
          settings: settings,
        );
      
      case signup:
        return MaterialPageRoute(
          builder: (context) => const SignupScreen(),
          settings: settings,
        );
      
      case home:
        return MaterialPageRoute(
          builder: (context) => const MainNavigationScreen(),
          settings: settings,
        );
      
      case mainNavigation:
        return MaterialPageRoute(
          builder: (context) => const MainNavigationScreen(),
          settings: settings,
        );
      
      case responsive:
        return MaterialPageRoute(
          builder: (context) => const _PlaceholderScreen(title: 'Responsive Demo'),
          settings: settings,
        );
      
      case sharedPreferences:
        return MaterialPageRoute(
          builder: (context) => const _PlaceholderScreen(title: 'Data Storage'),
          settings: settings,
        );
      
      case routeExample:
        return MaterialPageRoute(
          builder: (context) => const _PlaceholderScreen(title: 'Route Examples'),
          settings: settings,
        );
      
      // Dynamic routes with arguments
      case contentDetail:
        final args = settings.arguments as Map<String, dynamic>?;
        final contentId = args?['contentId'] as String? ?? 'unknown';
        return MaterialPageRoute(
          builder: (context) => _PlaceholderScreen(
            title: 'Content Detail',
            subtitle: 'Content ID: $contentId',
          ),
          settings: settings,
        );
      
      case chat:
        final args = settings.arguments as Map<String, dynamic>?;
        final chatId = args?['chatId'] as String? ?? 'unknown';
        final userName = args?['userName'] as String? ?? 'Unknown User';
        return MaterialPageRoute(
          builder: (context) => _PlaceholderScreen(
            title: 'Chat',
            subtitle: 'Chatting with $userName (ID: $chatId)',
          ),
          settings: settings,
        );
      
      case imageViewer:
        final args = settings.arguments as Map<String, dynamic>?;
        final imageUrl = args?['imageUrl'] as String? ?? '';
        final imageTitle = args?['imageTitle'] as String? ?? 'Image';
        return MaterialPageRoute(
          builder: (context) => _PlaceholderScreen(
            title: 'Image Viewer',
            subtitle: '$imageTitle\nURL: $imageUrl',
          ),
          settings: settings,
        );
      
      // Default route
      default:
        return MaterialPageRoute(
          builder: (context) => const _PlaceholderScreen(title: 'Page Not Found'),
          settings: settings,
        );
    }
  }

  // ========================================
  // NAVIGATION HELPERS
  // ========================================

  /// Navigate to a route
  static Future<T?> push<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamed<T>(
      context,
      routeName,
      arguments: arguments,
    );
  }

  /// Navigate to a route and replace current
  static Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
    TO? result,
  }) {
    return Navigator.pushReplacementNamed<T, TO>(
      context,
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  /// Navigate to a route and clear stack
  static Future<T?> pushAndClearStack<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamedAndRemoveUntil<T>(
      context,
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  /// Navigate to a route and remove until
  static Future<T?> pushAndRemoveUntil<T extends Object?>(
    BuildContext context,
    String routeName,
    RoutePredicate predicate, {
    Object? arguments,
  }) {
    return Navigator.pushNamedAndRemoveUntil<T>(
      context,
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  /// Pop current route
  static void pop<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.pop<T>(context, result);
  }

  /// Pop until specific route
  static void popUntil(BuildContext context, String routeName) {
    Navigator.popUntil(context, ModalRoute.withName(routeName));
  }

  /// Pop to root
  static void popToRoot(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  // ========================================
  // ROUTE VALIDATION
  // ========================================

  /// Check if route exists
  static bool routeExists(String routeName) {
    return routes.containsKey(routeName);
  }

  /// Get all available routes
  static List<String> getAllRoutes() {
    return routes.keys.toList();
  }

  /// Get routes by category
  static Map<String, List<String>> getRoutesByCategory() {
    return {
      'Main': [splash, intro, home, responsive, sharedPreferences],
      'Authentication': [login, register, forgotPassword, resetPassword, verifyEmail],
      'Profile': [profile, editProfile, changePassword, settings, privacyPolicy, termsOfService],
      'Features': [dashboard, notifications, search, favorites, history],
      'Content': [contentList, contentDetail, createContent, editContent],
      'Media': [gallery, camera, imageViewer, videoPlayer],
      'Communication': [messages, chat, contacts, call],
      'Utility': [about, help, feedback, support, debug],
      'Error': [notFound, error, maintenance],
    };
  }

  // ========================================
  // ROUTE CONSTANTS
  // ========================================

  /// Route names for easy reference
  static const List<String> mainRoutes = [
    splash,
    intro,
    home,
    mainNavigation,
    responsive,
    sharedPreferences,
    routeExample,
  ];

  static const List<String> authRoutes = [
    login,
    register,
    forgotPassword,
    resetPassword,
    verifyEmail,
  ];

  static const List<String> profileRoutes = [
    profile,
    editProfile,
    changePassword,
    settings,
    privacyPolicy,
    termsOfService,
  ];

  static const List<String> featureRoutes = [
    dashboard,
    notifications,
    search,
    favorites,
    history,
  ];

  static const List<String> contentRoutes = [
    contentList,
    contentDetail,
    createContent,
    editContent,
  ];

  static const List<String> mediaRoutes = [
    gallery,
    camera,
    imageViewer,
    videoPlayer,
  ];

  static const List<String> communicationRoutes = [
    messages,
    chat,
    contacts,
    call,
  ];

  static const List<String> utilityRoutes = [
    about,
    help,
    feedback,
    support,
    debug,
  ];

  static const List<String> errorRoutes = [
    notFound,
    error,
    maintenance,
  ];
}

// ========================================
// PLACEHOLDER WIDGET
// ========================================

/// Placeholder widget for routes that haven't been implemented yet
class _PlaceholderScreen extends StatelessWidget {
  final String title;
  final String? subtitle;

  const _PlaceholderScreen({
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.construction,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 8),
                Text(
                  subtitle!,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 16),
              Text(
                'This screen is under construction',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

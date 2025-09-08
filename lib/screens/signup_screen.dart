import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/font_constants.dart';
import '../utils/responsive_dimensions.dart';
import '../utils/performance_helper.dart';
import '../routes/navigation_helper.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveDimensions()..init(context);

    return PerformanceHelper.optimizeWidget(
      Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: responsive.width(24),
              vertical: responsive.height(40),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top section with logo and branding
                Column(
                  children: [
                    SizedBox(height: responsive.height(60)),
                    
                    // Logo
                    SizedBox(
                      width: responsive.width(80),
                      height: responsive.width(160),
                      child: Image.asset(
                        'assets/logo/app_logo.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.apps,
                            size: responsive.width(60),
                            color: Colors.white,
                          );
                        },
                      ),
                    ),
                    
                    // App name
                    Text(
                      'Wisspr',
                      style: GoogleFonts.marcellus(
                        textStyle: TextStyle(
                          fontSize: responsive.fontSize(32),
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFFFFD859), // Golden color
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),

                // Middle section with call to action
                Column(
                  children: [
                    // Main title
                    Text(
                      'Join the Fragrance Experience',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.marcellus(
                        textStyle: TextStyle(
                          fontSize: responsive.fontSize(24),
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    
                    SizedBox(height: responsive.height(16)),
                    
                    // Description
                    Text(
                      'Step into a world where every scent tells a story.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: responsive.fontSize(15),
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.tertiary,
                        height: 1.5,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),

                // Bottom section with login buttons
                Column(
                  children: [
                    // Google login button
                    SizedBox(
                      width: double.infinity,
                      height: responsive.height(56),
                      child: ElevatedButton(
                        onPressed: _handleGoogleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.surface,// Dark grey
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Google logo
                            SizedBox(
                              width: responsive.width(20),
                              height: responsive.height(20),
                              child: Image.asset("assets/image/google_icon.png"),
                            ),
                            SizedBox(width: responsive.width(12)),
                            Text(
                              'Login with Google',
                              style: TextStyle(
                                fontFamily: FontConstants.satoshi,
                                fontSize: responsive.fontSize(16),
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    SizedBox(height: responsive.height(16)),
                    
                    // Apple login button
                    SizedBox(
                      width: double.infinity,
                      height: responsive.height(56),
                      child: ElevatedButton(
                        onPressed: _handleAppleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.surface, // Dark grey
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Apple logo
                            Icon(
                              Icons.apple,
                              size: responsive.width(25),
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                            SizedBox(width: responsive.width(12)),
                            Text(
                              'Login with Apple',
                              style: TextStyle(
                                fontFamily: FontConstants.satoshi,
                                fontSize: responsive.fontSize(16),
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    SizedBox(height: responsive.height(120)),
                    
                    // Legal text
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: responsive.fontSize(14),
                          color: Colors.white.withAlpha(156),
                          fontFamily: FontConstants.satoshi,
                        ),
                        children: [
                          const TextSpan(text: 'By continuing, you agree to our '),
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const TextSpan(text: ' & '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleGoogleLogin() {
    // TODO: Implement Google login
    print('Google login pressed');
    // For now, navigate to main navigation
    NavigationHelper.goToMainNavigation(context);
  }

  void _handleAppleLogin() {
    // TODO: Implement Apple login
    print('Apple login pressed');
    // For now, navigate to main navigation
    NavigationHelper.goToMainNavigation(context);
  }
}

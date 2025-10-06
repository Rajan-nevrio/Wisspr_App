import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisspr_app/commom_widgets/customer_text/marcellus_font_type_text.dart';
import 'package:wisspr_app/commom_widgets/customer_text/satoshi_font_type_text.dart';
import 'package:wisspr_app/resources/dimension_spacing/horizontal_spacing.dart';
import 'package:wisspr_app/resources/dimension_spacing/vertical_spacing.dart';
import '../../providers/auth/sign_in_provider.dart';
import '../../resources/app_strings.dart';
import '../../resources/font_constants.dart';
import '../../resources/image_path.dart';
import '../../routes/navigation_helper.dart';
import '../../utils/responsive_dimensions.dart';
import '../../utils/performance_helper.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    final r = ResponsiveDimensions()..init(context);

    return PerformanceHelper.optimizeWidget(
      Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: r.width(24),
              vertical: r.height(40),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                header(r),
                VerticalSpacing(height: 60),
                description(r),
                VerticalSpacing(height: 30),
                
                /// Google button with Selector - only rebuilds when isGoogleLoader changes
                Selector<SignUpProvider, bool>(
                  selector: (context, provider) => provider.isGoogleLoader,
                  builder: (context, isGoogleLoader, child) {
                    return googleLoginBtn(isGoogleLoader, r);
                  },
                ),
                
                VerticalSpacing(height: 16),
                
                /// Apple button with Selector - only rebuilds when isAppleLoader changes
                Selector<SignUpProvider, bool>(
                  selector: (context, provider) => provider.isAppleLoader,
                  builder: (context, isAppleLoader, child) {
                    return appleLoginBtn(isAppleLoader, r);
                  },
                ),
                
                VerticalSpacing(height: 80),
                bottomDescription(r),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Top header UI.
  Widget header(ResponsiveDimensions r) {
    return Column(
      children: [
        VerticalSpacing(height: 50),
        SizedBox(
          width: r.width(80),
          height: r.width(160),
          child: Image.asset(
            ImgPath.appLogo,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.apps,
                size: r.width(60),
                color: Theme.of(context).colorScheme.primary,
              );
            },
          ),
        ),
        MText(
          msg: AppStrings.appName,
          textSize: r.fontSize(32),
          textWeight: FontWeight.w400,
          textColor: Theme.of(context).colorScheme.primaryFixed,
          letterSpacing: 1.2,
        ),
      ],
    );
  }

  /// Description UI.
  Widget description(ResponsiveDimensions r) {
    return Column(
      children: [
        SText(
          msg: AppStrings.joinTheFragranceExperience,
          textAlign: TextAlign.center,
          textSize: r.fontSize(24),
          textWeight: FontWeight.w400,
          textColor: Theme.of(context).colorScheme.primary,
          letterSpacing: 0.5,
        ),
        VerticalSpacing(height: 16),
        SText(
          msg: AppStrings.stepIntoAWorldWhereEveryScentTellsStory,
          textAlign: TextAlign.center,
          textSize: r.fontSize(15),
          textWeight: FontWeight.w400,
          textColor: Theme.of(context).colorScheme.tertiary,
          height: 1.5,
          letterSpacing: 0.3,
        ),
      ],
    );
  }

  /// Google login button UI.
  Widget googleLoginBtn(bool isLoading, ResponsiveDimensions r) {
    return SizedBox(
      width: r.screenWidth,
      height: r.height(56),
      child: ElevatedButton(
        onPressed: isLoading
            ? () => debugPrint("Google login:-----> Already running")
            : () async {
                final provider = Provider.of<SignUpProvider>(context, listen: false);
                final result = await provider.handleGoogleLogin(context);
                if (result != null && result['success'] == true) {
                  if (context.mounted) {
                    NavigationHelper.goToHome(context);
                  }
                } else {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Google login failed. Please try again.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.surface,
          foregroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? Center(
                child: SizedBox(
                  height: r.height(25),
                  width: r.height(25),
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                    strokeWidth: 2,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: r.width(22),
                    height: r.height(22),
                    child: Image.asset(
                      ImgPath.googleIcon,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.apps,
                          size: r.fontSize(30),
                          color: Theme.of(context).colorScheme.primary,
                        );
                      },
                    ),
                  ),
                  HorizontalSpacing(width: 12),
                  SText(
                    msg: AppStrings.loginWithGoogle,
                    textSize: r.fontSize(18),
                    textWeight: FontWeight.w400,
                    textColor: Theme.of(context).colorScheme.onSecondary,
                  ),
                ],
              ),
      ),
    );
  }

  /// Apple login button UI.
  Widget appleLoginBtn(bool isLoading, ResponsiveDimensions r) {
    return SizedBox(
      width: r.screenWidth,
      height: r.height(56),
      child: ElevatedButton(
        onPressed: isLoading
            ? () => debugPrint("Apple Login:------> Already running")
            : () {
                final provider = Provider.of<SignUpProvider>(context, listen: false);
                provider.handleAppleLogin(context);
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.surface,
          foregroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? Center(
                child: SizedBox(
                  height: r.height(25),
                  width: r.height(25),
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                    strokeWidth: 2,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.apple,
                    size: r.fontSize(30),
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  HorizontalSpacing(width: 12),
                  SText(
                    msg: AppStrings.loginWithApple,
                    textSize: r.fontSize(18),
                    textWeight: FontWeight.w400,
                    textColor: Theme.of(context).colorScheme.onSecondary,
                  ),
                ],
              ),
      ),
    );
  }

  /// Bottom description UI.
  Widget bottomDescription(ResponsiveDimensions r) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontSize: r.fontSize(14),
          color: Theme.of(context).colorScheme.tertiary,
          fontFamily: FontConstants.satoshi,
        ),
        children: [
          TextSpan(text: AppStrings.byContinuingYouAgreeToOur),
          TextSpan(
            text: AppStrings.termsOfService,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(text: AppStrings.a),
          TextSpan(
            text: AppStrings.privacyPolicy,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }
}
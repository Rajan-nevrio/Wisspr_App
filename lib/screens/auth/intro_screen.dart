import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisspr_app/commom_widgets/customer_text/marcellus_font_type_text.dart';
import 'package:wisspr_app/commom_widgets/customer_text/satoshi_font_type_text.dart';
import '../../resources/app_strings.dart';
import '../../utils/responsive_dimensions.dart';
import '../../utils/performance_helper.dart';
import '../../providers/auth/intro_provider.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> with TickerProviderStateMixin {
  late IntroProvider _introProvider;

  @override
  void initState() {
    super.initState();
    _introProvider = Provider.of<IntroProvider>(context, listen: false);
    _introProvider.initialize(this);
  }

  @override
  Widget build(BuildContext context) {
    final r = ResponsiveDimensions()..init(context);

    return PerformanceHelper.optimizeWidget(
      Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              /// Skip button with Selector - only rebuilds when shouldShowSkipButton changes
              Selector<IntroProvider, bool>(
                selector: (context, provider) => provider.shouldShowSkipButton,
                builder: (context, shouldShowSkipButton, child) {
                  if (shouldShowSkipButton) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: r.height(20),
                        right: r.width(20),
                      ),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            _introProvider.skipIntro(context);
                          },
                          child: SText(
                            msg: AppStrings.skip,
                            textSize: r.fontSize(18),
                            textColor: Theme.of(context).colorScheme.primary,
                            textWeight: FontWeight.w200,
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              
              /// Page view with Selector - only rebuilds when slides change
              Selector<IntroProvider, List<IntroSlide>>(
                selector: (context, provider) => provider.slides,
                builder: (context, slides, child) {
                  return Expanded(
                    child: PageView.builder(
                      controller: _introProvider.pageController,
                      onPageChanged: _introProvider.onPageChanged,
                      itemCount: slides.length,
                      itemBuilder: (context, index) {
                        return _buildSlide(context, slides[index], r);
                      },
                    ),
                  );
                },
              ),

              /// Bottom section with Selector - only rebuilds when currentPage or isLastPage changes
              Selector<IntroProvider, ({int currentPage, bool isLastPage})>(
                selector: (context, provider) => (
                  currentPage: provider.currentPage,
                  isLastPage: provider.isLastPage,
                ),
                builder: (context, data, child) {
                  return _buildBottomSection(data.currentPage, data.isLastPage, r);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Page UI
  Widget _buildSlide(BuildContext context, IntroSlide slide, ResponsiveDimensions responsive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       Container(
          width: double.infinity,
          height: responsive.height(440),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Image.asset(
            slide.icon,
            fit: BoxFit.fitWidth,
          ),
        ),
        SizedBox(height: responsive.height(40)),

        /// Title
        TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 600),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: MText(
                  msg: slide.title,
                  textAlign: TextAlign.center,
                  textSize: responsive.fontSize(28),
                  textWeight: FontWeight.w400,
                  textColor: Theme.of(context).colorScheme.primary,
                  letterSpacing: 1.2,
                ),
              ),
            );
          },
        ),
        SizedBox(height: responsive.height(20)),

        /// Description
        TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 800),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: SText(
                  msg: slide.description,
                  textAlign: TextAlign.center,
                  textSize: responsive.fontSize(18),
                  textWeight: FontWeight.w300,
                  textColor: Theme.of(context).colorScheme.tertiary,
                  height: 1.5,
                  letterSpacing: 0.3,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  /// Widget to show bottom navigation UI.
  Widget _buildBottomSection(int currentPage, bool isLastPage, ResponsiveDimensions responsive) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: responsive.width(40),
        vertical: responsive.height(40),
      ),
      child: Column(
        children: [

          /// Continue button (only on last screen).
          if (isLastPage)
            SizedBox(
              width: double.infinity,
              height: responsive.height(56),
              child: ElevatedButton(
                onPressed: () {
                  _introProvider.nextPage(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  elevation: 0,
                ),
                child: SText(
                  msg: AppStrings.bContinue,
                  textSize: responsive.fontSize(18),
                  textWeight: FontWeight.w600,
                  textColor: Theme.of(context).scaffoldBackgroundColor,
                  letterSpacing: 0.5,
                ),
              ),
            ),

          SizedBox(height: responsive.height(50)),

          /// Page indicators with Selector - only rebuilds when currentPage changes
          Selector<IntroProvider, int>(
            selector: (context, provider) => provider.currentPage,
            builder: (context, currentPage, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _introProvider.slides.length,
                      (index) => _buildPageIndicator(index, currentPage, responsive),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Widgets used to show the indicator UI.
  Widget _buildPageIndicator(int index, int currentPage, ResponsiveDimensions responsive) {
    final isActive = index == currentPage;
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: responsive.width(4)),
      width: responsive.width(24),
      height: responsive.height(3),
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.tertiary,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}
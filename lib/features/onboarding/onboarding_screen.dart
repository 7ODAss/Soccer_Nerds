import 'package:flutter/material.dart';
import 'package:football_app/features/onboarding/widgets/onboarding_action.dart';
import 'package:football_app/features/onboarding/widgets/onboarding_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/theme/theme_mode.dart';
import '../../core/utils/onboarding/app_color.dart';
import '../../core/utils/onboarding/app_text_style.dart';
import '../home/presentation/screen/home_screen.dart';
import 'model/onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int pageIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextButton(
                onPressed: () {
                  if (pageIndex < onboardingList.length - 1) {
                    _pageController.animateToPage(onboardingList.length - 1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                    );
                  }
                },
                child: Text(
                  'SKIP',
                  style: AppTextStyle.black16ColorRegular16.copyWith(
                    fontSize: 20,
                    color: AppColor.whiteFAColor,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: PageView.builder(
                      itemCount: onboardingList.length,
                      itemBuilder: (context, index) =>
                          OnboardingItem(
                            index: index, pageController: _pageController,),
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          pageIndex = index;
                        });
                      },
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: onboardingList.length,
                    axisDirection: Axis.horizontal,
                    effect: SlideEffect(
                      spacing: 8.0,
                      dotWidth: 30,
                      dotHeight: 6.0,
                      radius: 56,
                      paintStyle: PaintingStyle.fill,
                      strokeWidth: 1.5,
                      activeDotColor: Theme.of(context).extension<AngledCardTheme>()!.color2,
                    ),
                    onDotClicked: (index){
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                ],
              ),
            ),



            Padding(
              padding: const EdgeInsets.all(25.0),
              child: OnboardingAction(
                pageIndex: pageIndex, primaryButtonPressed: () {
                if (pageIndex < onboardingList.length - 1) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                }
                if (pageIndex == onboardingList.length - 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                }
              }, secondaryButtonPressed: () {
                if (pageIndex > 0) {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                }
              },),
            ),
          ],
        ),
      ),
    );
  }
}

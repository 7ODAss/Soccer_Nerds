import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../model/onboarding_model.dart';

class OnboardingItem extends StatelessWidget {
  final PageController pageController;
  final int index;

  const OnboardingItem({
    super.key,
    required this.index,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark; // Check if it's dark mode
    final ColorFilter? iconColorFilter = isDarkMode ? const ColorFilter.mode(Colors.white, BlendMode.srcIn) : null;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 60),
          Container(
            decoration: BoxDecoration(
              color: isDarkMode ? Theme.of(context).colorScheme.surface.withOpacity(0.1) : Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SvgPicture.asset(
              onboardingList[index].image,
              width: 250.0,
              height: 250.0,
              colorFilter: iconColorFilter,
              fit: BoxFit.contain, // Ensures the SVG maintains aspect ratio and fits within the bounds
            ),
          ),
          SizedBox(height: 70),
          Expanded(
            child: Text(
              onboardingList[index].title,
              style: TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
          ),
          SizedBox(height: 42),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                onboardingList[index].description,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

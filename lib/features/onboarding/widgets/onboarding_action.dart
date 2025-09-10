import 'package:flutter/material.dart';
import '../../../core/theme/theme_mode.dart';
import '../../../core/utils/onboarding/app_button_style.dart';
import '../../../core/utils/onboarding/app_color.dart';
import '../../../core/utils/onboarding/app_text_style.dart';
import 'button.dart';
import '../model/onboarding_model.dart';

class OnboardingAction extends StatelessWidget {
  final int pageIndex;
  final VoidCallback primaryButtonPressed;
  final VoidCallback secondaryButtonPressed;

  const OnboardingAction({
    super.key,
    required this.pageIndex,
    required this.primaryButtonPressed,
    required this.secondaryButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: secondaryButtonPressed,
          child: Text(
            'BACK',
            style: AppTextStyle.black16ColorRegular16.copyWith(
              fontSize: 20,
              color: AppColor.whiteFAColor,
            ),
          ),
        ),
        const Spacer(),
        Button(
          onPressed: primaryButtonPressed,
          buttonText:
              pageIndex == onboardingList.length - 1 ? 'GET STARTED' : 'NEXT',
          buttonStyle: AppButtonStyle.primaryButtonStyle.copyWith(
            backgroundColor: WidgetStatePropertyAll(
              Theme.of(context).extension<AngledCardTheme>()!.color2,
            ),
          ),
          buttonTextStyle: AppTextStyle.black16ColorRegular16.copyWith(
            color: AppColor.onBoardingPrimaryButtonText,
          ),
        ),
      ],
    );
  }
}

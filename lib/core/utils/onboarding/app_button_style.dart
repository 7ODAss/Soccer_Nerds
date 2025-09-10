import 'package:flutter/material.dart';

import 'app_color.dart';

class AppButtonStyle {
  AppButtonStyle._();

  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColor.onBoardingPrimaryButtonBackGround,
    foregroundColor: AppColor.onBoardingTextBold,
    minimumSize: Size(90, 50),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    elevation: 0,
  );
  static ButtonStyle homePrimaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColor.homeScreenPrimaryButtonBackGround,
    foregroundColor: AppColor.homeScreenPrimaryButtonText,
    minimumSize: Size(350, 50),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    elevation: 0,
  );
}
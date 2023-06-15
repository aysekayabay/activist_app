import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();
  static Color vanillaShake = Color(0xffFFFCF0);
  static Color black = Color(0xff000000);
  static Color red = Color(0xffDC2C2C);
  static Color darkGrey = Color(0xff6B6B6B);
}

class AppSizes {
  const AppSizes._();
  static double highSize = 40;
  static double mediumSize = 20;
  static double lowSize = 10;
}

class AppPadings {
  const AppPadings._();
  static EdgeInsets mediumPadding = EdgeInsets.all(AppSizes.mediumSize);
}

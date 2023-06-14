import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();
  static Color vanillaShake = Color(0xffFFFCF0);
  static Color black = Color(0xff000000);
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

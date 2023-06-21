import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();
  static Color vanillaShake = Color(0xffFFFCF0);
  static Color black = Color(0xff000000);
  static Color red = Color(0xffDC2C2C);
  static Color darkGrey = Color(0xff6B6B6B);
  static Color darkYellow = Color(0xff78777700);

  static LinearGradient greyGradient = LinearGradient(colors: [darkGrey.withOpacity(0.39), darkYellow.withOpacity(0)], begin: Alignment.topCenter, end: Alignment.bottomCenter);
}

class AppSizes {
  const AppSizes._();
  static double highSize = mediumSize * 2;
  static double mediumSize = lowSize * 2;
  static double lowSize = 10;
  static double radiusSize = 15;
}

class AppPadings {
  const AppPadings._();
  static EdgeInsets mediumPadding = EdgeInsets.all(AppSizes.mediumSize);
}

class AppRadius {
  const AppRadius._();
  static BorderRadius primaryRadius = BorderRadius.all(Radius.circular(AppSizes.radiusSize));
}

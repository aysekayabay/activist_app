import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();
  static Color vanillaShake = Color(0xffFFFCF0);
  static Color black = Color(0xff000000);
  static Color red = Color(0xffDC2C2C);
  static Color darkGrey = Color(0xff6B6B6B);
  static Color darkYellow = Color(0xff78777700);
  static Color blue = Color(0xff0000FF);
  static Color green = Color(0xff008000);
  static Color lightGrey = Color(0xffD3D3D3);
  static Color grey = Color(0xff808080);
  static Color pink = Color(0xffFFC0CB);
  static Color maroon = Color(0xff800000);
  static Color orange = Color(0xffFFA500);
  static Color yellow = Color(0xffFFFF00);
  static Color lightYellow = Color(0xffFFFFE0);
  static Color blueHue = Color(0xffADD8E6);
  static Color yellowHue = Color(0xffF0E68C);
  static Color white = Color(0xffFFFFFF);
  static Color lightblue = Color(0xff32D7E1);

  static LinearGradient greyGradient = LinearGradient(
      colors: [darkGrey.withOpacity(0.39), darkYellow.withOpacity(0)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
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
  static BorderRadius primaryRadius =
      BorderRadius.all(Radius.circular(AppSizes.radiusSize));
}

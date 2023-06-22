import 'package:akademi_bootcamp/core/constants/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeDark {
  AppThemeDark._();
  static late final AppThemeDark instance = AppThemeDark._();
  ThemeData get theme => ThemeData(
      fontFamily: 'Poppins',
      textSelectionTheme: TextSelectionThemeData(selectionColor: Colors.red),
      colorScheme: appColorSheme(),
      scaffoldBackgroundColor: Colors.black,
      snackBarTheme: SnackBarThemeData(backgroundColor: Colors.deepOrangeAccent),
      textTheme: appTextTheme(),
      appBarTheme: appBarTheme().appBarTheme.copyWith(iconTheme: IconThemeData(color: AppColors.vanillaShake)),
      inputDecorationTheme: appInputDecorationTheme());

  TextTheme appTextTheme() {
    return TextTheme(
      headline1: GoogleFonts.poppins(fontSize: 22.0, fontWeight: FontWeight.bold, color: AppColors.vanillaShake),
    );
  }

  ThemeData appBarTheme() => ThemeData.light();

  InputDecorationTheme appInputDecorationTheme() {
    return InputDecorationTheme(
      focusColor: AppColors.vanillaShake,
      hintStyle: TextStyle(color: Colors.grey),
      border: OutlineInputBorder(borderSide: BorderSide(width: 10, color: AppColors.vanillaShake), borderRadius: BorderRadius.all(Radius.circular(15))),
    );
  }

  ColorScheme appColorSheme() {
    return ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.vanillaShake,
        onPrimary: Colors.white,
        secondary: Colors.white,
        onSecondary: Colors.white,
        error: Colors.white,
        onError: Colors.white,
        background: Colors.white,
        onBackground: Colors.white,
        surface: Colors.white,
        onSurface: Colors.white);
  }
}

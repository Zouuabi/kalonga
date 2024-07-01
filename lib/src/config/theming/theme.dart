import 'package:flutter/material.dart';
import 'package:kalonga/src/utils/app_colors.dart';

class AppTheme {
  static ThemeData main() {
    return ThemeData().copyWith(
        scaffoldBackgroundColor: AppColors.scaffoldColor,
        textTheme: _buildTextTheme(),
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: AppColors.yellow,
            onPrimary: Color(0xffdcd6f7),
            secondary: Color(0xffe56b6f),
            onSecondary: Color(0xffFE5D9F),
            error: Colors.red,
            onError: Colors.black,
            surface: Color(0xffb4869f),
            onSurface: Colors.white));
  }
}

TextTheme _buildTextTheme() {
  return ThemeData()
      .textTheme
      .apply(fontFamily: 'Silkscreen', displayColor: AppColors.yellow);
}

import 'package:flutter/material.dart';
import 'package:kalonga/src/utils/app_colors.dart';

class AppTheme {
  static ThemeData main() {
    return ThemeData().copyWith(
      scaffoldBackgroundColor: AppColors.scaffoldColor,
      appBarTheme: const AppBarTheme(backgroundColor: AppColors.scaffoldColor),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.scaffoldColor),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(),
      ),
      textTheme: _buildMainTextTheme(),
      colorScheme: const ColorScheme.light(
        primary: Colors.yellow,
        surface: Color(0xffb4869f),
      ),
    );
  }

  static ThemeData secondary() {
    return ThemeData().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 1, 97, 87),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 1, 97, 87),
        ),
        textTheme: _buildMainTextTheme(),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 1, 97, 87),
        ),
        inputDecorationTheme: const InputDecorationTheme(
            filled: true, border: OutlineInputBorder()),
        colorScheme: const ColorScheme.dark(
          primary: Colors.yellow,
          surface: Color.fromARGB(255, 51, 165, 146),
        ));
  }
}

TextTheme _buildMainTextTheme() {
  return ThemeData().textTheme.apply(
      fontFamily: 'Silkscreen',
      bodyColor: Colors.yellow,
      displayColor: Colors.yellow);
}

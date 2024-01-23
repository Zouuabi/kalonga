import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData main() {
    return ThemeData().copyWith(
        scaffoldBackgroundColor: const Color(0xffa6b1e1),
        colorScheme: const ColorScheme(
            brightness: Brightness.dark,
            primary: Color(0xffb4869f),
            onPrimary: Color(0xffdcd6f7),
            secondary: Color(0xffe56b6f),
            onSecondary: Color(0xffFE5D9F),
            error: Colors.red,
            onError: Colors.black,
            background: Color(0xffD6D2D2),
            onBackground: Color(0xff6d597a),
            surface: Color.fromARGB(255, 48, 47, 47),
            onSurface: Colors.black));
  }
}

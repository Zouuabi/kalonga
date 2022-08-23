import 'package:flutter/material.dart';
import 'package:kalonga/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalonga',
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: const Color(0xffD6D2D2),
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Color(0xffeaac8b),
            onPrimary: Color(0xff6d597a),
            secondary: Color(0xffe56b6f),
            onSecondary: Color(0xffFE5D9F),
            error: Colors.red,
            onError: Colors.black,
            background: Color(0xffD6D2D2),
            onBackground: Color(0xff6d597a),
            surface: Colors.white,
            onSurface: Colors.black),
      ),
      home: const HomeScreen(),
    );
  }
}

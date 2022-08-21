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
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ).copyWith(scaffoldBackgroundColor: Colors.teal),
      home: const HomeScreen(),
    );
  }
}

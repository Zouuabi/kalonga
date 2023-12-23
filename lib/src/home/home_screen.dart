import 'package:flutter/material.dart';

import 'package:kalonga/src/game/screens/main_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String id = '/home-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: -0.1,
              child: const Text(
                'Kalonga\n Press To Start',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Permanent Marker',
                  fontSize: 55,
                  height: 1,
                ),
              ),
            ),
            Transform.rotate(
              angle: 0.1,
              child: Container(
                  margin: const EdgeInsets.only(top: 50),
                  width: 200,
                  height: 70,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, MainScreen.id);
                      },
                      child: const Text(
                        'Play',
                        style: TextStyle(
                          fontFamily: 'Permanent Marker',
                          fontSize: 55,
                          height: 1,
                        ),
                      ))),
            )
          ],
        ),
      ),
    );
  }
}

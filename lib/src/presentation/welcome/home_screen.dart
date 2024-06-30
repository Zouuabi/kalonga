import 'package:flutter/material.dart';
import 'package:kalonga/src/core/routing/router.dart';
import 'package:kalonga/src/presentation/home/pages/home/widgets/widgets.dart'
    show infoDialog;

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  static const String id = '/welcome-screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _controller = TextEditingController();

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
                'Kalonga',
                style: TextStyle(
                  color: Color(0xffb4869f),
                  fontFamily: 'Permanent Marker',
                  fontSize: 55,
                  height: 1,
                ),
              ),
            ),
            Transform.rotate(
              angle: -0.1,
              child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: 50,
                  width: 300,
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                        hintText: 'Username',
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  )),
            ),
            Transform.rotate(
              angle: -0.1,
              child: Container(
                  margin: const EdgeInsets.only(top: 50),
                  width: 200,
                  height: 70,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_controller.text.isEmpty) {
                          infoDialog(context, 'Enter a username');
                        } else {
                          Navigator.of(context)
                              .pushReplacementNamed(Routes.main);
                        }
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

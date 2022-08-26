import 'package:flutter/material.dart';

Future<dynamic> infoDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xffa6b1e1),
                  borderRadius: BorderRadius.circular(30)),
              width: 300,
              height: 100,
              child: const DefaultTextStyle(
                style: TextStyle(color: Colors.black),
                child: Center(
                    child: Text(
                  'Move The Monkey Using Arrow Keys\nTry To Put Bananas In The Holes',
                  style: TextStyle(fontSize: 12, fontFamily: 'Silkscreen'),
                )),
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    width: 70,
                    height: 40,
                    decoration: const BoxDecoration(
                        color: Color(0xffa6b1e1),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: const Icon(
                      Icons.check,
                      color: Color(0xff6d597a),
                    ))),
          ],
        );
      });
}

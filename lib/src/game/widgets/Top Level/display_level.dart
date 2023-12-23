import 'package:flutter/material.dart';

import 'how_button.dart';

class DisplayLevel extends StatelessWidget {
  const DisplayLevel({
    Key? key,
    required this.globalIndex,
  }) : super(key: key);

  final int globalIndex;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex: 2, child: Container()),
            Expanded(
              flex: 2,
              child: Text(
                'Level $globalIndex',
                style: TextStyle(
                    color: Colors.yellowAccent,
                    fontSize: size.height * 0.03,
                    fontFamily: 'Silkscreen'),
              ),
            ),

            /// ***** How to Play*************
            const Expanded(
              flex: 1,
              child: HowButton(),
            )
          ],
        ));
  }
}

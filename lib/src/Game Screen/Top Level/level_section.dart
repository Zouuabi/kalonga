import 'package:flutter/material.dart';

import 'how_button.dart';

class LevelSection extends StatelessWidget {
  const LevelSection({
    Key? key,
    required this.globalIndex,
    required this.size,
  }) : super(key: key);

  final int globalIndex;
  final Size size;

  @override
  Widget build(BuildContext context) {
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
                    fontSize: size.width < 400 ? 20 : 30,
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

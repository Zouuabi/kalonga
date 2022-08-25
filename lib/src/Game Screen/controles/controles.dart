import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class Controles extends StatelessWidget {
  const Controles(
      {Key? key,
      required this.size,
      required this.updateGame,
      required this.previousMap,
      required this.nextMap,
      required this.moveUp,
      required this.moveDown,
      required this.moveLeft,
      required this.moveRight})
      : super(key: key);

  final Size size;
  final VoidCallback updateGame;
  final VoidCallback previousMap;
  final VoidCallback nextMap;
  final VoidCallback moveUp;
  final VoidCallback moveDown;
  final VoidCallback moveLeft;
  final VoidCallback moveRight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width < 500 ? double.infinity : 600,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
              onPressed: updateGame,
              child: const Text(
                'Restart',
                style: kButtonTextStyle,
              )),

          /// ****** Next and previous Game
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: previousMap,
                  child: const Text(
                    'Back',
                    style: kButtonTextStyle,
                  )),
              SizedBox(
                width: size.width * 0.2,
              ),
              ElevatedButton(
                  onPressed: nextMap,
                  child: const Text(
                    'Next',
                    style: kButtonTextStyle,
                  )),
            ],
          ),

          ///
          ///******  MOVE UP********

          Column(
            children: [
              ElevatedButton(
                  onPressed: moveUp, child: const Icon(Icons.arrow_drop_up)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ///
                  ///******  MOVE LEFT********

                  ElevatedButton(
                      onPressed: moveLeft, child: const Icon(Icons.arrow_left)),
                  SizedBox(width: size.width * 0.2),

                  ///******  MOVE RIGHT********

                  ElevatedButton(
                      onPressed: moveRight,
                      child: const Icon(Icons.arrow_right))
                ],
              ),

              ///******  MOVE DOWN********

              ElevatedButton(
                  onPressed: moveDown,
                  child: const Icon(Icons.arrow_drop_down)),
            ],
          )
        ],
      ),
    );
  }
}

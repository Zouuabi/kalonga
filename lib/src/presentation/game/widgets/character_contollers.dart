import 'package:flutter/material.dart';

class CharacterControllers extends StatelessWidget {
  const CharacterControllers(
      {super.key,
      required this.moveUp,
      required this.moveDown,
      required this.moveLeft,
      required this.moveRight});

  final VoidCallback moveUp;
  final VoidCallback moveDown;
  final VoidCallback moveLeft;
  final VoidCallback moveRight;

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: (node, event) {
        print(event.character);
        switch (event.character) {
          case 'z':
            moveUp();
            break;
          case 'q':
            moveLeft();
            break;
          case 'd':
            moveRight();
            break;

          case 's':
            moveDown();
            break;
          default:
            return KeyEventResult.ignored;
        }
        return KeyEventResult.ignored;
      },
      child: Column(
        children: [
          ///******  MOVE UP********
          ElevatedButton(
              onPressed: moveUp, child: const Icon(Icons.arrow_drop_up)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ///
              ///******  MOVE LEFT********

              ElevatedButton(
                  onPressed: moveLeft, child: const Icon(Icons.arrow_left)),

              const SizedBox(width: 60),

              ///******  MOVE RIGHT********

              ElevatedButton(
                  onPressed: moveRight, child: const Icon(Icons.arrow_right))
            ],
          ),
          const SizedBox(height: 20),

          ///******  MOVE DOWN********

          ElevatedButton(
              onPressed: moveDown, child: const Icon(Icons.arrow_drop_down))
        ],
      ),
    );
  }
}

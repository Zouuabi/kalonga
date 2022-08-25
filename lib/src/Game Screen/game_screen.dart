import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/constants.dart';
import 'Top Level/level_section.dart';
import 'box_character.dart';
import 'controles/controles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  int globalIndex = 0;
  List<Box> boxes = [];
  late Character character;
  Image? gameState(int index) {
    Image? box;
    if (index == character.position) {
      box = Image.asset(
        'assets/images/monkey.png',
        fit: BoxFit.cover,
      );
    } else if (isHere(index)) {
      box = Image.asset('assets/images/banana.png');
    } else if (level[globalIndex].targetPlaces.contains(index)) {
      box = Image.asset('assets/images/hole (1).png');
    } else {
      box = null;
    }
    for (int i = 0; i < boxes.length; i++) {
      for (int j = 0; j < level[globalIndex].targetPlaces.length; j++) {
        if (boxes[i].position == level[globalIndex].targetPlaces[j] &&
            index == level[globalIndex].targetPlaces[j]) {
          box = Image.asset(
            'assets/images/ba.gif',
            fit: BoxFit.cover,
          );
        }
      }
    }
    return box;
  }

  void moveDown() {
    return setState(() {
      if (!isHere(character.position + 9)) {
        character.moveDown();
      } else {
        for (Box box in boxes) {
          if (box.position == character.position + 9 &&
              !isHere(box.position + 9)) {
            box.moveDown();
          }
        }
      }
    });
  }

  void moveRight() {
    return setState(() {
      if (!isHere(character.position + 1)) {
        character.moveRight();
      } else {
        for (Box box in boxes) {
          if (box.position == character.position + 1 &&
              !isHere(box.position + 1)) {
            box.moveRight();
          }
        }
      }
    });
  }

  void moveLeft() {
    return setState(() {
      if (!isHere(character.position - 1)) {
        character.moveLeft();
      } else {
        for (Box box in boxes) {
          if (box.position == character.position - 1 &&
              !isHere(box.position - 1)) {
            box.moveLeft();
          }
        }
      }
    });
  }

  void moveUp() {
    return setState(() {
      if (!isHere(character.position - 9)) {
        character.moveUp();
      } else {
        for (Box box in boxes) {
          if (box.position == character.position - 9 &&
              !isHere(box.position - 9)) {
            box.moveUp();
          }
        }
      }
    });
  }

  bool isHere(int index) {
    for (Box box in boxes) {
      if (box.position == index) {
        return true;
      }
    }
    return false;
  }

  void updateGame() {
    setState(() {
      boxes.clear();
      character = Character(
        position: level[globalIndex].characterPosition,
        border: level[globalIndex].map,
      );
      for (int pos in level[globalIndex].boxPositions) {
        boxes.add(Box(position: pos, border: level[globalIndex].map));
      }
    });
  }

  void previousMap() {
    if (globalIndex > 0) {
      setState(() {
        globalIndex--;

        updateGame();
      });
    }
  }

  void nextMap() {
    if (globalIndex < level.length - 1) {
      setState(() {
        globalIndex++;

        updateGame();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    updateGame();
    boxes..
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    /// TODO: enable auto next level
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event is RawKeyDownEvent) {
          if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
            moveUp();
          } else if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
            moveDown();
          } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
            moveLeft();
          } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
            moveRight();
          }
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            /// * Top Level

            Expanded(
              flex: 1,
              child: LevelSection(globalIndex: globalIndex, size: size),
            ),

            /// * Game Map

            Expanded(
              flex: 5,
              child: SizedBox(
                width: size.width < 400 ? double.infinity : 400,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 9,
                  ),
                  itemCount: 81,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: level[globalIndex].map.contains(index)
                              ? const Color(0xff4e4c67)
                              : null,
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.all(1),
                      child: gameState(index),
                    );
                  },
                ),
              ),
            ),

            /// * Controles

            Expanded(
                flex: 3,
                child: Controles(
                    size: size,
                    updateGame: updateGame,
                    previousMap: previousMap,
                    nextMap: nextMap,
                    moveUp: moveUp,
                    moveDown: moveDown,
                    moveLeft: moveLeft,
                    moveRight: moveRight)),
          ]),
        ),
      ),
    );
  }
}

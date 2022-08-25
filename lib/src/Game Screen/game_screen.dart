import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/constants.dart';
import 'Top Level/level_section.dart';
import 'box_character.dart';
import 'controles/controles.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);
  static const String id = 'Game Screen';

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int currentLevel = 0;
  List<Box> boxes = [];
  late Character character;

  void checkState() {
    bool flag = true;

    for (Box box in boxes) {
      int currentPos = box.position;
      if (!level[currentLevel].targetPlaces.contains(currentPos)) {
        flag = false;
      }
    }

    if (flag) {
      nextMap();

      showDialog(
          context: context,
          builder: (context) {
            Timer(const Duration(milliseconds: 1500), () {
              Navigator.pop(context);
            });
            return Container(
              alignment: Alignment.bottomCenter,
              width: 300,
              height: 100,
              child: Image.asset(
                'assets/images/happyMonkey.gif',
                fit: BoxFit.cover,
              ),
            );
          });
    }
  }

  Image? gameState(int index) {
    Image? box;
    if (index == character.position) {
      box = Image.asset(
        'assets/images/monkey.png',
        fit: BoxFit.cover,
      );
    } else if (isHere(index)) {
      box = Image.asset('assets/images/banana.png');
    } else if (level[currentLevel].targetPlaces.contains(index)) {
      box = Image.asset('assets/images/hole (1).png');
    } else {
      box = null;
    }
    for (int i = 0; i < boxes.length; i++) {
      for (int j = 0; j < level[currentLevel].targetPlaces.length; j++) {
        if (boxes[i].position == level[currentLevel].targetPlaces[j] &&
            index == level[currentLevel].targetPlaces[j]) {
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
            checkState();
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
            checkState();
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
            checkState();
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
            checkState();
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
        position: level[currentLevel].characterPosition,
        border: level[currentLevel].map,
      );
      for (int pos in level[currentLevel].boxPositions) {
        boxes.add(Box(position: pos, border: level[currentLevel].map));
      }
    });
  }

  void previousMap() {
    if (currentLevel > 0) {
      setState(() {
        currentLevel--;

        updateGame();
      });
    }
  }

  void nextMap() {
    if (currentLevel < level.length - 1) {
      setState(() {
        currentLevel++;

        updateGame();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    updateGame();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
              child: LevelSection(globalIndex: currentLevel, size: size),
            ),

            /// * Game Map

            Expanded(
              flex: 6,
              child: Container(
                padding: EdgeInsets.only(
                    top: size.width < 300 ? size.width * 0.2 : 0),
                width: 400,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 9,
                  ),
                  itemCount: 81,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: level[currentLevel].map.contains(index)
                              ? const Color(0xff4e4c67)
                              : null,
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.all(1),
                      child: gameState(index),
                    );
                    // child: Text('$index'));
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

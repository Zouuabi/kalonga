import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'box.dart';
import 'character.dart';
import 'constants.dart';
import 'levels.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int globalIndex = 0;
  List<Box> boxes = [];
  late Character character;

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

  void updateGame(int index) {
    boxes.clear();
    character = Character(
      position: level[globalIndex].characterPosition,
      border: level[globalIndex].map,
    );
    for (int pos in level[globalIndex].boxPositions) {
      boxes.add(Box(position: pos, border: level[globalIndex].map));
    }
  }

  @override
  void initState() {
    super.initState();
    updateGame(globalIndex);
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
      child: Scaffold(
        body: SafeArea(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              flex: 1,
              child: Container(
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
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: const Color(0xffa6b1e1),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        width: 300,
                                        height: 100,
                                        child: DefaultTextStyle(
                                          style: const TextStyle(
                                              color: Colors.black),
                                          child: Center(
                                              child: Text(
                                            'Move The Monkey Using Arrow Keys\nTry To Put Bananas In The Holes',
                                            style: kButtonTextStyle.copyWith(
                                                fontSize: 12),
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10))),
                                              child: const Icon(
                                                Icons.check,
                                                color: Color(0xff6d597a),
                                              ))),
                                    ],
                                  );
                                });
                          },
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffb4869f)),
                            child: const Icon(
                              Icons.question_mark_rounded,
                              color: Color(0xffdcd6f7),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            Expanded(
              flex: 5,
              child: SizedBox(
                width: size.width < 500 ? 300 : 400,
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
            Expanded(
              flex: 3,
              child: SizedBox(
                width: size.width < 400 ? 300 : 500,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            updateGame(globalIndex);
                          });
                        },
                        child: const Text(
                          'Restart',
                          style: kButtonTextStyle,
                        )),

                    /// ****** Next Game
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              if (globalIndex > 0) {
                                setState(() {
                                  globalIndex--;

                                  updateGame(globalIndex);
                                });
                              }
                            },
                            child: const Text(
                              'Back',
                              style: kButtonTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              if (globalIndex < level.length - 1) {
                                setState(() {
                                  globalIndex++;

                                  updateGame(globalIndex);
                                });
                              }
                            },
                            child: const Text(
                              'Next',
                              style: kButtonTextStyle,
                            )),
                      ],
                    ),

                    ///
                    ///******  MOVE UP********

                    size.width > 700
                        ? Container()
                        : Column(
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    moveUp();
                                  },
                                  child: const Icon(Icons.arrow_drop_up)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ///
                                  ///******  MOVE LEFT********

                                  ElevatedButton(
                                      onPressed: () {
                                        moveLeft();
                                      },
                                      child: const Icon(Icons.arrow_left)),
                                  const SizedBox(width: 100),

                                  ///******  MOVE RIGHT********

                                  ElevatedButton(
                                      onPressed: () {
                                        moveRight();
                                      },
                                      child: const Icon(Icons.arrow_right))
                                ],
                              ),

                              ///******  MOVE DOWN********

                              ElevatedButton(
                                  onPressed: () {
                                    moveDown();
                                  },
                                  child: const Icon(Icons.arrow_drop_down)),
                            ],
                          )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

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
      box = Image.asset('assets/images/monkey.png');
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
    return Scaffold(
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              margin: const EdgeInsets.only(top: 30),
              child: Text(
                'Level $globalIndex',
                style: const TextStyle(
                    color: Colors.yellowAccent,
                    fontSize: 30,
                    fontFamily: 'Silkscreen'),
              )),
          Expanded(
              flex: 6,
              child: Container(
                padding: EdgeInsets.only(top: size.height * 0.04),
                width: size.width * 0.9,
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
              )),
          Expanded(
            flex: 4,
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
                        child: Text(
                          'Previous Level',
                          style: kButtonTextStyle.copyWith(fontSize: 16),
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
                          ' Next Level ',
                          style: kButtonTextStyle,
                        )),
                  ],
                ),

                ///
                ///******  MOVE UP********

                ElevatedButton(
                    onPressed: () {
                      setState(() {
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
                    },
                    child: const Icon(Icons.arrow_drop_up)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ///
                    ///******  MOVE LEFT********

                    ElevatedButton(
                        onPressed: () {
                          setState(() {
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
                        },
                        child: const Icon(Icons.arrow_left)),
                    const SizedBox(width: 100),

                    ///******  MOVE RIGHT********

                    ElevatedButton(
                        onPressed: () {
                          setState(() {
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
                        },
                        child: const Icon(Icons.arrow_right))
                  ],
                ),

                ///******  MOVE DOWN********

                ElevatedButton(
                    onPressed: () {
                      setState(() {
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
                    },
                    child: const Icon(Icons.arrow_drop_down))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

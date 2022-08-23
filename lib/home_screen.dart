import 'package:flutter/material.dart';
import 'character.dart';
import 'box.dart';
import 'levels.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int globalIndex = 2;
  late Character character;

  List<Box> boxes = [];
  bool isHere(int index) {
    for (Box box in boxes) {
      if (box.position == index) {
        return true;
      }
    }
    return false;
  }
  Color gameState(int index) {
    Color boxColor = const Color(0xffD6D2D2);
    if (index == character.position) {
      boxColor = const Color(0xffe56b6f);
    } else if (level[globalIndex].map.contains(index)) {
      boxColor = const Color(0xff6d597a);
    } else if (isHere(index)) {
      boxColor = const Color(0xffeaac8b);
    } else if (level[globalIndex].targetPlaces.contains(index)) {
      boxColor = const Color(0xffb56576);
    }
    for (int i = 0; i < boxes.length; i++) {
      for (int j = 0; j < level[globalIndex].targetPlaces.length; j++) {
        if (boxes[i].position == level[globalIndex].targetPlaces[j] &&
            index == level[globalIndex].targetPlaces[j]) {
          boxColor = const Color.fromARGB(255, 107, 54, 64);
        }
      }
    }
    return boxColor;
  }

  @override
  void initState() {
    super.initState();
    character = Character(
      position: level[globalIndex].characterPosition,
      border: level[globalIndex].map,
    );

    for (int pos in level[globalIndex].boxPositions) {
      boxes.add(Box(position: pos, border: level[globalIndex].map));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.only(top: 100),
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
                        borderRadius: BorderRadius.circular(10),
                        color: gameState(index),
                      ),
                      margin: const EdgeInsets.all(1),
                      // child: Text(
                      //   '$index',
                      //   style: const TextStyle(color: Colors.teal),
                      // ),
                    );
                  },
                ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// ****** Next Game
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (globalIndex > 1) {
                              setState(() {
                                globalIndex--;
                              });
                            }
                          },
                          child: const Text('Previous Level')),
                      ElevatedButton(
                          onPressed: () {
                            if (globalIndex < level.length - 1) {
                              setState(() {
                                globalIndex++;
                              });
                            }
                          },
                          child: const Text('    Next Level    ')),
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
                              if (!isHere(character.position - globalIndex)) {
                                character.moveLeft();
                              } else {
                                for (Box box in boxes) {
                                  if (box.position ==
                                          character.position - globalIndex &&
                                      !isHere(box.position - globalIndex)) {
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
                              if (!isHere(character.position + globalIndex)) {
                                character.moveRight();
                              } else {
                                for (Box box in boxes) {
                                  if (box.position ==
                                          character.position + globalIndex &&
                                      !isHere(box.position + globalIndex)) {
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
          ),
        ]),
      ),
    );
  }
}

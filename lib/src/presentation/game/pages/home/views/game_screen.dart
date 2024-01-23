import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalonga/src/core/image_manager.dart';
import 'package:kalonga/src/core/utils/constants.dart';
import 'package:kalonga/src/entities/entities.dart';
import 'package:kalonga/src/presentation/game/cubit/game_cubit.dart';

import '../widgets/Top Level/display_level.dart';
import '../widgets/controles/controles.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key, required this.currentLevel}) : super(key: key);
  final int currentLevel;
  static const String id = 'game-screen';

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late int currentLevel;
  int numberOfMoves = 0;

  double score = 0.0;

  late Map map;

  @override
  void initState() {
    super.initState();
    currentLevel = widget.currentLevel;
    map = Map(
        bananas: levels[currentLevel]
            .bananasPositions
            .map((e) => Banana(position: e))
            .toList(),
        holes: levels[currentLevel].holesPositions,
        monkey: Monkey(position: levels[currentLevel].characterPosition),
        border: levels[currentLevel].borders);
    map.levelComplete.stream.listen((event) {
      if (event == true) {
        celebrateSuccess();
      }
    });
  }

  void celebrateSuccess() {
    score += 1000 * (0.2 * (currentLevel + 1)) - numberOfMoves;
    numberOfMoves = 0;
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

  void nextMap() {
    if (currentLevel < levels.length - 1) {
      setState(() {
        currentLevel++;
        BlocProvider.of<GameCubit>(context)
            .unlockNextLevel(nextLevel: currentLevel);

        map = Map(
            bananas: levels[currentLevel]
                .bananasPositions
                .map((e) => Banana(position: e))
                .toList(),
            holes: levels[currentLevel].holesPositions,
            monkey: Monkey(position: levels[currentLevel].characterPosition),
            border: levels[currentLevel].borders);
        map.levelComplete.stream.listen((event) {
          if (event == true) {
            celebrateSuccess();
          }
        });
      });
    }
  }

  Widget? displayGame(int index) {
    List<int> bananas = map.bananas.map((e) => e.position).toList();
    if (index == map.monkey.position) {
      // display Monkey
      return Image.asset(
        ImageManager.monkey,
        fit: BoxFit.cover,
      );
    } else if (bananas.contains(index)) {
      // diplay bananas

      // we check if any hole index equal to any banana position
      // if so we check we have to display a happyBanana
      if (map.holes.contains(index)) {
        return Image.asset(
          ImageManager.happyBanana,
          fit: BoxFit.cover,
        );
      }

      return Image.asset(
        ImageManager.banana,
        fit: BoxFit.cover,
      );
    } else if (map.holes.contains(index)) {
      return Image.asset(
        ImageManager.hole,
        fit: BoxFit.cover,
      );
    } else if (map.border.contains(index)) {
      // display borders
      return null;
      // return Image.asset(
      //   ImageManager.happyMonkey,
      //   fit: BoxFit.cover,
      // );
    } else {
      // empty box ==> nothing in our case
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: RawKeyboardListener(
          focusNode: FocusNode(),
          autofocus: true,
          onKey: (event) {
            if (event is RawKeyDownEvent) {
              if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
                setState(() {
                  map.moveUp();
                  numberOfMoves++;
                });
              } else if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
                setState(() {
                  map.moveDown();
                  numberOfMoves++;
                });
              } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
                setState(() {
                  map.moveLeft();
                  numberOfMoves++;
                });
              } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
                setState(() {
                  map.moveRight();
                  numberOfMoves++;
                });
              }
            }
          },
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            /// * Top Level

            Expanded(
              child: DisplayLevel(
                globalIndex: currentLevel,
              ),
            ),

            /// * Game Map

            SizedBox(
              width: size.height * 0.5,
              height: size.height * 0.5,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 9,
                ),
                itemCount: 81,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                        // border: Border.all(),
                        color: levels[currentLevel].borders.contains(index)
                            ? const Color(0xff4e4c67)
                            : null,
                        borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.all(1),
                    child: displayGame(index),
                  );
                },
              ),
            ),

            /// * Controles
            Text(
              ' Score : $score',
              style: const TextStyle(
                  color: Colors.yellowAccent,
                  fontSize: 20,
                  fontFamily: 'Silkscreen'),
            ),
            Expanded(
                flex: 3,
                child: Controles(
                    updateGame: () {
                      setState(() {
                        map = Map(
                            bananas: levels[currentLevel]
                                .bananasPositions
                                .map((e) => Banana(position: e))
                                .toList(),
                            holes: levels[currentLevel].holesPositions,
                            monkey: Monkey(
                                position:
                                    levels[currentLevel].characterPosition),
                            border: levels[currentLevel].borders);
                      });
                    },
                    previousMap: () {},
                    nextMap: nextMap,
                    moveUp: () {
                      setState(() {
                        map.moveUp();
                        numberOfMoves++;
                      });
                    },
                    moveDown: () {
                      setState(() {
                        map.moveDown();
                        numberOfMoves++;
                      });
                    },
                    moveLeft: () {
                      setState(() {
                        map.moveLeft();
                        numberOfMoves++;
                      });
                    },
                    moveRight: () {
                      setState(() {
                        map.moveRight();
                        numberOfMoves++;
                      });
                    })),
          ]),
        ),
      ),
    );
  }
}

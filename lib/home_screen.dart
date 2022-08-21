import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int playerPosition = 25;
  int boxPosition = 32;

  Color playerOrBox(int index) {
    if (index == playerPosition) {
      return Colors.pink;
    } else if (index == boxPosition) {
      return Colors.white;
    } else {
      return Colors.teal.shade400;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(children: [
        Expanded(
            child: Container(
          color: Colors.red,
          child: Center(
              child: ElevatedButton(
            onPressed: () {
              setState(() {
                playerPosition = 25;
                boxPosition = 32;
              });
            },
            child: const Text('Restart'),
          )),
        )),
        Expanded(
            flex: 6,
            child: SizedBox(
              width: size.width * 0.8,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                ),
                itemCount: 70,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.all(2),
                    color: playerOrBox(index),
                    child: Text("$index"),
                  );
                },
              ),
            )),
        Expanded(
          child: Container(
            color: Colors.blue,
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (playerPosition - 7 >= 0 &&
                            playerPosition - 7 != boxPosition) {
                          playerPosition -= 7;
                        } else if (playerPosition - 7 == boxPosition &&
                            boxPosition - 7 >= 0) {
                          boxPosition -= 7;
                          playerPosition -= 7;
                        }
                      });
                    },
                    child: const Icon(Icons.arrow_drop_up)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (playerPosition - 1 >= 0 &&
                                playerPosition - 1 != boxPosition) {
                              playerPosition--;
                            } else if (playerPosition - 1 == boxPosition &&
                                boxPosition - 1 >= 0) {
                              boxPosition--;
                              playerPosition--;
                            }
                          });
                        },
                        child: const Icon(Icons.arrow_left)),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (playerPosition + 1 < 70 &&
                                playerPosition + 1 != boxPosition) {
                              playerPosition++;
                            } else if (playerPosition + 1 == boxPosition &&
                                boxPosition + 1 < 70) {
                              boxPosition++;
                              playerPosition++;
                            }
                          });
                        },
                        child: const Icon(Icons.arrow_right))
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (playerPosition + 7 < 70 &&
                            playerPosition + 7 != boxPosition) {
                          playerPosition += 7;
                        } else if (playerPosition + 7 == boxPosition &&
                            boxPosition + 7 < 70) {
                          boxPosition += 7;
                          playerPosition += 7;
                        }
                      });
                    },
                    child: const Icon(Icons.arrow_drop_down))
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

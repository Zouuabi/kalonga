import 'package:flutter/material.dart';
import 'character.dart';
import 'box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Character character = Character();
  Box box = Box();
  List<Box> boxes = [
    Box(position: 45),
    Box(position: 17),
  ];


  bool isHere(int index) {
    for (Box box in boxes) {
      if (box.position == index) {
        return true;
      }
    }
    return false;
  }
  Color playerOrBox(int index) {
    if (index == character.position) {
      return Colors.pink;
    } else if (isHere(index)) {
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
                character.position = 26;
                box.position = 32;
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
                        
                        if (character.position - 7 != box.position) {
                          character.moveUp();
                        } else {
                          box.moveUp();
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
                            if (character.position - 1 != box.position) {
                              character.moveLeft();
                            } else {
                              box.moveLeft();
                            }
                          });
                        },
                        child: const Icon(Icons.arrow_left)),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (character.position + 1 != box.position) {
                              character.moveRight();
                            } else {
                              box.moveRight();
                            }
                          });
                        },
                        child: const Icon(Icons.arrow_right))
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (character.position + 7 != box.position) {
                          character.moveDown();
                        } else {
                          box.moveDown();
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

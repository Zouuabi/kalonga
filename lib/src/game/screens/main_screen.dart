import 'package:flutter/material.dart';
import 'package:kalonga/src/game/screens/game_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static const String id = '/main-screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentScreen = 0;
  List<Widget> pages = const [
    GameScreen(),
    Center(child: Text('tesdfsdfdsfsd')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: SizedBox(
          height: 55,
          child: BottomNavigationBar(
            iconSize: 20,
            selectedLabelStyle: const TextStyle(fontFamily: 'Permanent Marker'),
            unselectedLabelStyle:
                const TextStyle(fontFamily: 'Permanent Marker'),
            backgroundColor: const Color(0xffa6b1e1),
            elevation: 20,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.games_outlined), label: 'Play'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.leaderboard_outlined),
                  label: 'LearderBoard'),
            ],
            currentIndex: currentScreen,
            onTap: ((value) {
              setState(() {
                currentScreen = value;
              });
            }),
          ),
        ),
        body: IndexedStack(
          index: currentScreen,
          children: pages,
        ));
  }
}

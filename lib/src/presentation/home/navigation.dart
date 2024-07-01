import 'package:flutter/material.dart';
import 'package:kalonga/src/presentation/home/views/leader_board_page.dart';
import 'package:kalonga/src/presentation/home/views/levels_page.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentScreen = 0;
  List<Widget> pages = [const LevelsPage(), const LeadBoardPage()];

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
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: IndexedStack(
            index: currentScreen,
            children: pages,
          ),
        ));
  }
}

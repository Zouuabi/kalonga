import 'package:flutter/material.dart';

import 'package:kalonga/src/presentation/navigation/levels_page.dart';
import 'package:kalonga/src/presentation/settings/pages/settings_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentPage = 0;
  final List<Widget> _pages = [const LevelsPage(), const SettingsPage()];

  void _onPageSelected(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CustomBottomNavBar(
          currentPage: _currentPage,
          onPageSelected: _onPageSelected,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: IndexedStack(
              index: _currentPage,
              children: _pages,
            ),
          ),
        ));
  }
}

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.onPageSelected,
    required this.currentPage,
  });

  final void Function(int value) onPageSelected;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: BottomNavigationBar(
        iconSize: 20,
        backgroundColor: const Color(0xffa6b1e1),
        elevation: 20,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.games_outlined), label: 'Play'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: currentPage,
        onTap: onPageSelected,
      ),
    );
  }
}

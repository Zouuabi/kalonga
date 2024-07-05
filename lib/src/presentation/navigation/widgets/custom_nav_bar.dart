import 'package:flutter/material.dart';

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

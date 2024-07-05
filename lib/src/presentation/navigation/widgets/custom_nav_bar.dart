import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        elevation: 20,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.games_outlined),
              label: AppLocalizations.of(context)!.play),
          BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: AppLocalizations.of(context)!.settings),
        ],
        currentIndex: currentPage,
        onTap: onPageSelected,
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:kalonga/src/presentation/navigation/views/levels_page.dart';
import 'package:kalonga/src/presentation/navigation/widgets/custom_nav_bar.dart';
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

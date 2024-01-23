import 'package:flutter/material.dart';
import 'package:kalonga/src/presentation/game/pages/home/views/game_screen.dart';
import 'package:kalonga/src/presentation/main_screen.dart';
import 'package:kalonga/src/presentation/welcome/home_screen.dart';

class Routes {
  static const String welcome = "/welcome";
  static const String main = "/main";
  static const String game = "/game";
}

class RouteGenerator {
  static Route<Widget> getRoute(RouteSettings settings) {
    switch (settings.name) {
      // login screen
      case Routes.welcome:
        return MaterialPageRoute(builder: (BuildContext ctx) {
          return const WelcomeScreen();
        });

      /// Navigation screeen
      case Routes.main:
        return MaterialPageRoute(builder: (BuildContext ctx) {
          return const MainScreen();
        });

      // navigate to a specific level (game)
      case Routes.game:
        return MaterialPageRoute(builder: (BuildContext ctx) {
          final int arg = settings.arguments as int;
          return GameScreen(currentLevel: arg);
        });

      default:
        // naamlou page 404
        return MaterialPageRoute(builder: (ctx) {
          return const Scaffold(
            body: Center(child: Text('404 Not Found')),
          );
        });
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalonga/src/data/local.dart';
import 'package:kalonga/src/presentation/app/cubit/app_cubit.dart';
import 'package:kalonga/src/presentation/game/bloc/game_bloc.dart';
import 'package:kalonga/src/presentation/game/views/game_page.dart';
import 'package:kalonga/src/presentation/injector.dart';
import 'package:kalonga/src/presentation/navigation/views/navigation_page.dart';
import 'package:kalonga/src/presentation/welcome/welcome_page.dart';

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
          return const WelcomePage();
        });

      /// Navigation screeen
      case Routes.main:
        return MaterialPageRoute(builder: (BuildContext ctx) {
          return const NavigationPage();
        });

      // navigate to a specific level (game)
      case Routes.game:
        return MaterialPageRoute(builder: (BuildContext ctx) {
          return BlocProvider<GameBloc>(
              create: (ctx) => GameBloc(
                    initialLevel: settings.arguments as int,
                    appCubit: serviceLocator<AppCubit>(),
                  ),
              child: const GamePage());
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

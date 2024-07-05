import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalonga/src/data/local.dart';
import 'package:kalonga/src/presentation/app/cubit/app_cubit.dart';
import 'package:kalonga/src/presentation/game/bloc/game_bloc.dart';
import 'package:kalonga/src/presentation/game/views/game_page.dart';
import 'package:kalonga/src/presentation/injector.dart';
import 'package:kalonga/src/presentation/navigation/navigation_page.dart';
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
          return const WelcomeScreen();
        });

      /// Navigation screeen
      case Routes.main:
        return MaterialPageRoute(builder: (BuildContext ctx) {
          return const Navigation();
        });

      // navigate to a specific level (game)
      case Routes.game:
        return MaterialPageRoute(builder: (BuildContext ctx) {
          return MultiBlocProvider(providers: [
            BlocProvider(
                create: (context) =>
                    AppCubit(serviceLocator<PersistentStorage>())),
            BlocProvider<GameBloc>(
              create: (context) => GameBloc(
                  persistentStorage: serviceLocator<PersistentStorage>(),
                  appCubit: serviceLocator<AppCubit>()),
            ),
          ], child: const GamePage());
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalonga/src/config/routing/router.dart';
import 'package:kalonga/src/config/theming/theme.dart';
import 'package:kalonga/src/data/local.dart';
import 'package:kalonga/src/presentation/home/bloc/game_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.persistentStrorage});

  final Storage persistentStrorage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc(persistentStorage: persistentStrorage),
      child: MaterialApp(
        restorationScopeId: 'kalonga',
        debugShowCheckedModeBanner: false,
        title: 'Kalonga',
        theme: AppTheme.main(),
        initialRoute: Routes.welcome,
        onGenerateRoute: RouteGenerator.getRoute,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalonga/src/core/routing/router.dart';
import 'package:kalonga/src/core/theming/theme.dart';
import 'package:kalonga/src/presentation/home/cubit/game_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc(),
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

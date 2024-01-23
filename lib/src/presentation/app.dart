import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalonga/src/core/routing/router.dart';
import 'package:kalonga/src/core/theming/theme.dart';
import 'package:kalonga/src/presentation/game/cubit/game_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GameCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kalonga',
        theme: AppTheme.main(),
        initialRoute: Routes.welcome,
        onGenerateRoute: RouteGenerator.getRoute,
      ),
    );
  }
}

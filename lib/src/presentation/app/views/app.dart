import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalonga/src/core/config/routing/router.dart';
import 'package:kalonga/src/core/config/theming/theme.dart';
import 'package:kalonga/src/presentation/app/cubit/app_cubit.dart';
import 'package:kalonga/src/presentation/navigation/views/navigation_page.dart';
import 'package:kalonga/src/presentation/welcome/welcome_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) => MaterialApp(
        restorationScopeId: 'kalonga',
        debugShowCheckedModeBanner: false,
        title: 'Kalonga',
        theme: AppTheme.main(),
        home: state.status == AppStatus.loggedOut
            ? const WelcomePage()
            : const NavigationPage(),
        onGenerateRoute: RouteGenerator.getRoute,
      ),
    );
  }
}

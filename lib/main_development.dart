// ignore: depend_on_referenced_packages
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalonga/src/core/config/routing/router.dart';
import 'package:kalonga/src/core/config/theming/theme.dart';
import 'package:kalonga/src/presentation/app/cubit/app_cubit.dart';
import 'package:kalonga/src/presentation/injector.dart';
import 'package:kalonga/src/presentation/navigation/views/navigation_page.dart';
import 'package:kalonga/src/presentation/state_observer.dart';
import 'package:kalonga/src/presentation/welcome/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await globalModules();
  Bloc.observer = const Observer();

  runApp(
    MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => serviceLocator<AppCubit>()),
        ],
        child:
            DevicePreview(enabled: true, builder: (context) => const MyApp())),
  );
}

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

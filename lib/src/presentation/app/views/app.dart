import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kalonga/src/core/config/routing/router.dart';
import 'package:kalonga/src/core/config/theming/theme.dart';
import 'package:kalonga/src/presentation/app/cubit/app_cubit.dart';
import 'package:kalonga/src/presentation/navigation/views/navigation_page.dart';
import 'package:kalonga/src/presentation/welcome/welcome_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('fr'),
        ],
        locale: Locale(state.language),
        theme: state.theme == 'main' ? AppTheme.main() : AppTheme.secondary(),
        home: state.status == AppStatus.loggedOut
            ? const WelcomePage()
            : const NavigationPage(),
        onGenerateRoute: RouteGenerator.getRoute,
      ),
    );
  }
}

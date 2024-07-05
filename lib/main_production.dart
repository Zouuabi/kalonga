import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalonga/src/presentation/app/cubit/app_cubit.dart';
import 'package:kalonga/src/presentation/injector.dart';

import 'package:kalonga/src/presentation/state_observer.dart';

import 'src/presentation/app/views/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await globalModules();
  Bloc.observer = const Observer();

  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(create: (context) => serviceLocator<AppCubit>()),
    ], child: const MyApp()),
  );
}

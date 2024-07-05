import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalonga/src/presentation/injector.dart';

import 'package:kalonga/src/presentation/state_observer.dart';

import 'src/presentation/app/views/app.dart';

void main() async {
  // todo : button to restart all levels
  // todo : if next < mawjoud do net write
  WidgetsFlutterBinding.ensureInitialized();
  await globalModules();
  Bloc.observer = const Observer();

  runApp(
    const MyApp(),
  );
}

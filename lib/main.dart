import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalonga/src/presentation/state_observer.dart';

import 'src/presentation/app.dart';

void main() {
  Bloc.observer = const Observer();
  runApp(
    const MyApp(),
  );
}

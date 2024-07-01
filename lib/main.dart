import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalonga/src/data/local.dart';

import 'package:kalonga/src/presentation/state_observer.dart';

import 'src/presentation/app.dart';

void main() async {
  Bloc.observer = const Observer();
  Storage persistentStorage = PersistentStorage(
      sharedPreferences: await SharedPreferences.getInstance());

  runApp(
    MyApp(
      persistentStrorage: persistentStorage,
    ),
  );
}

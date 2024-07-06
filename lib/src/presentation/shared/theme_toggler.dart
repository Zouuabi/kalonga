import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalonga/src/presentation/app/cubit/app_cubit.dart';

class ThemeToggler extends StatelessWidget {
  const ThemeToggler({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
        value: context.watch<AppCubit>().state.theme == 'main' ? false : true,
        onChanged: (value) {
          if (!value) {
            context.read<AppCubit>().changeTheme(theme: 'main');
          } else {
            context.read<AppCubit>().changeTheme(theme: 'secondary');
          }
        });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalonga/src/presentation/app/cubit/app_cubit.dart';

class LanguageMenu extends StatelessWidget {
  const LanguageMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.language_outlined),
      tooltip: 'Language',
      onSelected: (String value) {
        context.read<AppCubit>().changeLanguage(languageCode: value);
      },
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem(
            value: 'en',
            child: Text('English'),
          ),
          const PopupMenuItem(
            value: 'fr',
            child: Text('Français'),
          ),
          // Add more languages here
        ];
      },
    );
  }
}

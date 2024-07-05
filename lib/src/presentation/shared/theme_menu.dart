import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalonga/src/presentation/app/cubit/app_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeMenu extends StatelessWidget {
  const ThemeMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.light_mode),
      tooltip: 'Theme',
      onSelected: (String value) {
        context.read<AppCubit>().changeTheme(theme: value);
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: 'main',
            child: Text(AppLocalizations.of(context)!.mainLanguage),
          ),
          PopupMenuItem(
            value: 'secondary',
            child: Text(AppLocalizations.of(context)!.secondaryLanguage),
          ),
        ];
      },
    );
  }
}

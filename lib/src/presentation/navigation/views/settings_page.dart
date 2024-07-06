import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalonga/src/presentation/app/cubit/app_cubit.dart';
import 'package:kalonga/src/presentation/shared/custome_alert.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kalonga/src/presentation/shared/theme_toggler.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context)!.restartLevels),
            trailing: const Icon(Icons.restart_alt_rounded),
            onTap: () {
              customAlert(
                  context: context,
                  content: AppLocalizations.of(context)!.restartLevelsAlert,
                  onOkPressed: () {
                    context.read<AppCubit>().restartLevels();
                  });
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.secondaryTheme),
            trailing: const ThemeToggler(),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.changeLanguage),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              _showLanguageDialog(context);
            },
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () {
              customAlert(
                  context: context,
                  content: AppLocalizations.of(context)!.signOutAlert,
                  onOkPressed: () {
                    context.read<AppCubit>().logout();
                  });
            },
            child: Text(AppLocalizations.of(context)!.signOut),
          )
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            width: 300,
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: const Text('English'),
                    onTap: () {
                      context
                          .read<AppCubit>()
                          .changeLanguage(languageCode: 'en');
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: const Text('Français'),
                    onTap: () {
                      context
                          .read<AppCubit>()
                          .changeLanguage(languageCode: 'fr');
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        ]);
      },
    );
  }
}

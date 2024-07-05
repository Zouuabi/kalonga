import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalonga/src/presentation/app/cubit/app_cubit.dart';
import 'package:kalonga/src/presentation/shared/custome_alert.dart';

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
            title: const Text('Restart Levels'),
            trailing: const Icon(Icons.restart_alt_rounded),
            onTap: () {
              customAlert(
                  context: context,
                  content: 'Are you sure you want to Restart Levels ?',
                  onOkPressed: () {
                    context.read<AppCubit>().restartLevels();
                  });
            },
          ),
          ListTile(
            title: const Text('Change Theme'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Change Language'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () {
              customAlert(
                  context: context,
                  content: 'All data would be deleted ! ',
                  onOkPressed: () {
                    context.read<AppCubit>().logout();
                  });
            },
            child: const Text('Sign Out'),
          )
        ],
      ),
    );
  }
}

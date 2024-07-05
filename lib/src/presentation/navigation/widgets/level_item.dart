import 'package:flutter/material.dart';
import 'package:kalonga/src/core/config/routing/router.dart';
import 'package:kalonga/src/presentation/shared/custome_alert.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LevelItem extends StatelessWidget {
  const LevelItem({
    super.key,
    required this.level,
    required this.locked,
  });

  final int level;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (locked) {
          customAlert(
              context: context, content: AppLocalizations.of(context)!.locked);
        } else {
          Navigator.of(context).pushNamed(Routes.game, arguments: level);
        }
      },
      child: Card(
          child: locked == false
              ? Center(
                  child: Text(
                  'Level $level',
                  style: Theme.of(context).textTheme.headlineSmall,
                ))
              : const Icon(
                  Icons.lock_outline,
                  size: 50,
                  color: Colors.white,
                )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kalonga/src/presentation/shared/custome_alert.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HowButton extends StatelessWidget {
  const HowButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        customAlert(
            context: context, content: AppLocalizations.of(context)!.howTo);
      },
      child: const SizedBox(
        width: 40,
        height: 40,
        child: Card(
          elevation: 3,
          child: Icon(
            Icons.question_mark_rounded,
          ),
        ),
      ),
    );
  }
}

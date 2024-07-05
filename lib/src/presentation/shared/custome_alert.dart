import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<dynamic> customAlert(
    {required BuildContext context,
    required String content,
    VoidCallback? onOkPressed}) {
  return showDialog(
      context: context,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 100,
              child: Card(
                child: DefaultTextStyle(
                  style: const TextStyle(color: Colors.black),
                  child: Center(
                      child: Text(
                    content,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  )),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DialogButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: AppLocalizations.of(context)!.cancel,
                ),
                const SizedBox(width: 20),
                onOkPressed == null
                    ? const SizedBox.shrink()
                    : DialogButton(
                        onPressed: () {
                          onOkPressed();
                          Navigator.pop(context);
                        },
                        label: AppLocalizations.of(context)!.okay,
                      ),
              ],
            ),
          ],
        );
      });
}

class DialogButton extends StatelessWidget {
  const DialogButton({
    super.key,
    required this.onPressed,
    required this.label,
  });
  final VoidCallback onPressed;
  final String label;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(label));
  }
}

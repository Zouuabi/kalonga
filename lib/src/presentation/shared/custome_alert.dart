import 'package:flutter/material.dart';

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
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xffa6b1e1),
                  borderRadius: BorderRadius.circular(30)),
              width: 300,
              height: 100,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DialogButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: 'Cancel',
                ),
                const SizedBox(width: 20),
                onOkPressed == null
                    ? const SizedBox.shrink()
                    : DialogButton(
                        onPressed: () {
                          onOkPressed();
                          Navigator.pop(context);
                        },
                        label: 'Okay',
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
    return MaterialButton(
        onPressed: onPressed,
        child: Container(
          alignment: Alignment.center,
          width: 70,
          height: 40,
          decoration: const BoxDecoration(
              color: Color(0xffa6b1e1),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ));
  }
}

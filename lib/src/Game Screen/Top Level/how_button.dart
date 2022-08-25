import 'package:flutter/material.dart';

import 'info_dialog.dart';

class HowButton extends StatelessWidget {
  const HowButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        infoDialog(context);
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: Color(0xffb4869f)),
        child: const Icon(
          Icons.question_mark_rounded,
          color: Color(0xffdcd6f7),
        ),
      ),
    );
  }
}

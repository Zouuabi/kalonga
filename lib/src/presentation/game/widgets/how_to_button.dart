import 'package:flutter/material.dart';
import 'package:kalonga/src/core/utils/app_colors.dart';
import 'package:kalonga/src/presentation/shared/custome_alert.dart';

class HowButton extends StatelessWidget {
  const HowButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        customAlert(
            context: context,
            content: ' USE \n Q ,Z, S D \n keys  To Move Kalonga');
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
            // todo : change this color with [AppColors] value
            shape: BoxShape.circle,
            color: Color(0xffb4869f)),
        child: const Icon(
          Icons.question_mark_rounded,
          color: AppColors.yellow,
        ),
      ),
    );
  }
}

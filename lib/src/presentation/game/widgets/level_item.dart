import 'package:flutter/material.dart';
import 'package:kalonga/src/core/config/routing/router.dart';
import 'package:kalonga/src/presentation/game/widgets/widgets.dart';

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
    return GestureDetector(
      onTap: () {
        if (locked) {
          infoDialog(context, 'Level is not unlocked \n pass the previous one');
        } else {
          Navigator.of(context).pushNamed(Routes.game);
        }
      },
      child: Container(
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(20),
          ),
          child: locked == false
              ? Center(
                  child: Text(
                  'Level $level',
                  style: const TextStyle(
                    fontFamily: 'Permanent Marker',
                    color: Colors.white,
                  ),
                ))
              : const Icon(
                  Icons.lock_outline,
                  size: 50,
                  color: Colors.white,
                )),
    );
  }
}

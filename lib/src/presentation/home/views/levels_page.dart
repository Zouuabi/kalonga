import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kalonga/src/presentation/home/cubit/game_bloc.dart';
import 'package:kalonga/src/presentation/home/widgets/level_item.dart';
import 'package:kalonga/src/utils/levels.dart';

class LevelsPage extends StatelessWidget {
  const LevelsPage({super.key});
  static const String id = 'home-screen';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: width * 0.03,
                mainAxisSpacing: width * 0.03,
              ),
              itemCount: levels.length,
              itemBuilder: (context, index) => LevelItem(
                  level: index,
                  locked: state.levelNumber >= index ? false : true),
            ));
      },
    );
  }
}

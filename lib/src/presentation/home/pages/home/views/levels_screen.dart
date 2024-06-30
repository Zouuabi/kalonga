import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalonga/src/core/utils/constants.dart';
import 'package:kalonga/src/presentation/home/cubit/game_bloc.dart';
import 'package:kalonga/src/presentation/home/pages/home/widgets/level_card.dart';

class LevelsScreen extends StatelessWidget {
  const LevelsScreen({super.key});
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
              itemBuilder: (context, index) => Level(
                  level: index,
                  locked: context.read<GameBloc>().currentlevel >= index
                      ? false
                      : true),
            ));
      },
    );
  }
}

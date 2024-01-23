import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalonga/src/presentation/game/cubit/game_cubit.dart';
import 'package:kalonga/src/presentation/game/pages/home/widgets/level.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String id = 'home-screen';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: width * 0.03,
                mainAxisSpacing: width * 0.03,
              ),
              children: state.data
                  .map((e) => Level(
                        level: e['level'],
                        locked: e['locked'],
                      ))
                  .toList(),
            ));
      },
    );
  }
}

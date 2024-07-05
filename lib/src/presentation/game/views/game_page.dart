import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalonga/src/utils/app_strings.dart';
import 'package:kalonga/src/utils/image_manager.dart';
import 'package:kalonga/src/entities/level.dart';
import 'package:kalonga/src/presentation/app/cubit/app_cubit.dart';
import 'package:kalonga/src/presentation/game/bloc/game_bloc.dart';
import 'package:kalonga/src/presentation/game/widgets/widgets.dart';
import 'package:kalonga/src/presentation/shared/language_menu.dart';

class GamePage extends StatelessWidget {
  const GamePage({
    super.key,
  });

  static const String id = 'gamepage';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameBloc, GameState>(
      listener: (context, state) {
        if (state.status == GameStatus.nextLevel) {
          celebrateLevelUp(context: context);
        }
      },
      builder: (contex, state) {
        return Scaffold(
          appBar: _appBar(
            context: context,
            level: state.levelNumber,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _game(context, state),
                  Text(' Score : ${context.watch<AppCubit>().state.score}',
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        context.read<GameBloc>().add(Restart());
                      },
                      child: const Text(
                        AppStrings.restart,
                      )),
                  const SizedBox(height: 20),
                  CharacterControllers(moveUp: () {
                    context.read<GameBloc>().add(MoveUp());
                  }, moveDown: () {
                    context.read<GameBloc>().add(MoveDown());
                  }, moveLeft: () {
                    context.read<GameBloc>().add(MoveLeft());
                  }, moveRight: () {
                    context.read<GameBloc>().add(MoveRight());
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget? _buildGameComponents(int index, Level level, int characterPosition) {
    if (index == characterPosition) {
      return const Character();
    } else if (level.bananasPositions.contains(index)) {
      if (level.holesPositions.contains(index)) {
        return const HappyBanana();
      }

      return const Banana();
    } else if (level.holesPositions.contains(index)) {
      return const Hole();
    } else if (level.borders.contains(index)) {
      return const Borderr();
    } else {
      return null;
    }
  }

  SizedBox _game(BuildContext context, GameState state) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).height * 0.5,
      height: MediaQuery.sizeOf(context).height * 0.5,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 9,
        ),
        itemCount: 81,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(1),
            child: _buildGameComponents(
                index, state.level, state.characterPosition),
          );
        },
      ),
    );
  }

  AppBar _appBar({
    required BuildContext context,
    required int level,
  }) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      actions: [
        const LanguageMenu(),
        Switch(
            value:
                context.watch<AppCubit>().state.theme == 'main' ? false : true,
            onChanged: (value) {
              if (!value) {
                context.read<AppCubit>().changeTheme(theme: 'main');
              } else {
                context.read<AppCubit>().changeTheme(theme: 'secondary');
              }
            }),
      ],
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
          Text(
            '${AppStrings.level} $level',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const HowButton(),
        ],
      ),
    );
  }
}

void celebrateLevelUp({required BuildContext context}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Container(
          alignment: Alignment.bottomCenter,
          child: Image.asset(ImageManager.happyMonkey),
        );
      });
  Timer(
    const Duration(seconds: 2),
    () {
      Navigator.of(context).pop();
    },
  );
}

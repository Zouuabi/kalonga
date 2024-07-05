import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalonga/src/core/utils/app_colors.dart';
import 'package:kalonga/src/core/utils/app_strings.dart';
import 'package:kalonga/src/core/utils/image_manager.dart';
import 'package:kalonga/src/entities/level.dart';
import 'package:kalonga/src/presentation/game/bloc/game_bloc.dart';
import 'package:kalonga/src/presentation/game/widgets/character_contollers.dart';
import 'package:kalonga/src/presentation/game/widgets/widgets.dart';

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
            child: Column(
              children: [
                const SizedBox(height: 50),
                _game(context, state),
                Text(' Score : ${state.movesNum}',
                    style: Theme.of(context).textTheme.headlineMedium),
                ElevatedButton(
                    onPressed: () {
                      context.read<GameBloc>().add(Restart());
                    },
                    child: Text(
                      AppStrings.restart,
                      style: Theme.of(context).textTheme.headlineMedium,
                    )),
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
        );
      },
    );
  }

  Widget? _buildGame(int index, Level level, int characterPosition) {
    if (index == characterPosition) {
      // display Monkey
      return Image.asset(
        ImageManager.monkey,
        fit: BoxFit.cover,
      );
    } else if (level.bananasPositions.contains(index)) {
      // diplay bananas

      // we check if any hole index equal to any banana position
      // if so we check we have to display a happyBanana
      if (level.holesPositions.contains(index)) {
        return Image.asset(
          ImageManager.happyBanana,
          fit: BoxFit.cover,
        );
      }

      return Image.asset(
        ImageManager.banana,
        fit: BoxFit.cover,
      );
    } else if (level.holesPositions.contains(index)) {
      return Image.asset(
        ImageManager.hole,
        fit: BoxFit.cover,
      );
    } else if (level.borders.contains(index)) {
      //  display borders
      // this is already handled by the test in the
      // of the color in the return of the grid view
      return null;
    } else {
      // empty box ==> nothing in our case
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
            decoration: BoxDecoration(
                color: state.level.borders.contains(index)
                    ? const Color(0xff4e4c67)
                    : null,
                borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(1),
            child: _buildGame(index, state.level, state.characterPosition),
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
      backgroundColor: AppColors.scaffoldColor,
      automaticallyImplyLeading: false,
      centerTitle: true,
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
          const HowButton()
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

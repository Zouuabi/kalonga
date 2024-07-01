import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalonga/src/utils/image_manager.dart';
import 'package:kalonga/src/utils/app_colors.dart';
import 'package:kalonga/src/utils/app_strings.dart';
import 'package:kalonga/src/entities/level.dart';
import 'package:kalonga/src/presentation/home/cubit/game_bloc.dart';
import 'package:kalonga/src/presentation/home/widgets/character_contollers.dart';
import 'package:kalonga/src/presentation/home/widgets/widgets.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key, required this.currentLevel});
  final int currentLevel;
  static const String id = 'game-page';

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<GameBloc, GameState>(
        listener: (context, state) {},
        builder: (contex, state) {
          return Scaffold(
            appBar: _appBar(context),
            body: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  SizedBox(
                    width: size.height * 0.5,
                    height: size.height * 0.5,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                          child: _buildGame(
                              index, state.level, state.characterPosition),
                        );
                      },
                    ),
                  ),
                  Text(' Score : ${14654}',
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 50),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        AppStrings.restart,
                        style: Theme.of(context).textTheme.headlineMedium,
                      )),
                  const SizedBox(height: 50),
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
        });
  }

  AppBar _appBar(BuildContext context) {
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
            '${AppStrings.level} ${0}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const HowButton()
        ],
      ),
    );
  }
}

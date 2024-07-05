import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalonga/src/utils/levels.dart';
import 'package:kalonga/src/entities/level.dart';
import 'package:kalonga/src/presentation/app/cubit/app_cubit.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc({required this.initialLevel, required this.appCubit})
      : super(
          GameState(
              characterPosition: levels[initialLevel].characterPosition,
              level: levels[initialLevel],
              status: GameStatus.initial,
              levelNumber: initialLevel,
              movesNum: 0),
        ) {
    on<MoveLeft>(_moveLeft);
    on<MoveRight>(_moveRight);
    on<MoveUp>(_moveUp);
    on<MoveDown>(_moveDown);
    on<Restart>(_restart);
  }
  final AppCubit appCubit;
  final int initialLevel;

  /// Handles the MoveLeft event by moving the character left.
  void _moveLeft(GameEvent event, Emitter<GameState> emit) {
    _moveCharacter(-1, emit);
  }

  /// Handles the MoveRight event by moving the character right.
  void _moveRight(GameEvent event, Emitter<GameState> emit) {
    _moveCharacter(1, emit);
  }

  /// Handles the MoveUp event by moving the character up.
  void _moveUp(GameEvent event, Emitter<GameState> emit) {
    _moveCharacter(-9, emit);
  }

  /// Handles the MoveDown event by moving the character down.
  void _moveDown(GameEvent event, Emitter<GameState> emit) {
    _moveCharacter(9, emit);
  }

  /// Handles character movement based on the provided offset.
  /// This method checks if the character can move to the new position.
  void _moveCharacter(int offset, Emitter<GameState> emit) {
    final currentPosition = state.characterPosition;
    final nextPosition = currentPosition + offset;

    // Check if the character can move to the next position
    if (_canMoveTo(nextPosition, offset)) {
      List<int>? newBananasPositons;
      if (_isBanana(nextPosition)) {
        if (_canMoveTo(nextPosition + offset, offset)) {
          newBananasPositons =
              _moveBanana(bananana: nextPosition, offset: offset);
        } else {
          return;
        }
      }

      emit(state.copyWith(
          movesNum: state.movesNum + 1,
          status: GameStatus.characterMoved,
          characterPosition: nextPosition,
          level: state.level.copyWith(
            bananasPositions: newBananasPositons,
          )));
      _areBananasInHoles(emit);
    }
  }

  bool _canMoveTo(int position, int offset) {
    // Check if the next position is a border
    if (state.level.borders.contains(position)) {
      return false;
    }
    if (state.level.bananasPositions.contains(position) &&
        state.level.bananasPositions.contains(position + offset)) {
      return false;
    }
    return true;
  }

  bool _isBanana(int position) {
    return state.level.bananasPositions.contains(position);
  }

  List<int> _moveBanana({required int bananana, required int offset}) {
    List<int> bananas = List.from(state.level.bananasPositions);
    int banananaIndex = bananas.indexOf(bananana);
    bananas.add(bananana + offset);
    bananas.removeAt(banananaIndex);

    return bananas;
  }

  void _levelUp(Emitter<GameState> emit) {
    int nextLevelNumber = state.levelNumber + 1;

    appCubit.levelUp(level: nextLevelNumber);

    if (nextLevelNumber < levels.length) {
      emit(
        state.copyWith(
            characterPosition: levels[nextLevelNumber].characterPosition,
            level: levels[nextLevelNumber],
            status: GameStatus.nextLevel,
            levelNumber: nextLevelNumber,
            movesNum: 0),
      );
    } else {
      emit(
        state.copyWith(
          status: GameStatus.completed,
        ),
      );
    }
  }

  void _areBananasInHoles(Emitter<GameState> emit) {
    if (state.level.bananasPositions
        .every((pos) => state.level.holesPositions.contains(pos))) {
      appCubit.upDateScore(numberOfMoves: state.movesNum);
      _levelUp(emit);
    }
  }

  void _restart(GameEvent event, Emitter<GameState> emit) {
    int currentLevel = state.levelNumber;
    emit(
      state.copyWith(
        characterPosition: levels[currentLevel].characterPosition,
        level: levels[currentLevel],
        status: GameStatus.restarted,
      ),
    );
  }
}

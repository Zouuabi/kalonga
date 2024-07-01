import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalonga/src/data/local.dart';
import 'package:kalonga/src/entities/level.dart';
import 'package:kalonga/src/utils/levels.dart';

part 'game_event.dart';
part 'game_state.dart';

///major hhh todo: a graph algrothim BFS/DFS/A* plays the game in the most effient
///way
///a3ml li theb w khalili li theb
///? el qerd barka gaad yetharek b shih w yehtarem fl border
///todo: lezm ywalli ydezz banaa if possible
///todo : if the banana* is in the hole twalli 7ayrana*
///todo: if the bananans are all in correct places we
///
///automatically to the next map w ndhahrou akl qardoun li yachta7
///todo: we have to calculate the score
///todo : charcter must be moved by keyboard keys if
/// we are on desktop
/// todo: in mobile we have to be able to move kalonga by an analog
/// (if we are on mobile arrow icons must be invisible)
/// todo : implement multiple themes (minimum 3 , colors character ...)
/// todo : for reference we can have a look on legacy kalong via https://oubeid.com

class GameBloc extends Bloc<GameEvent, GameState> {
  final Storage persistentStorage;
  GameBloc({required this.persistentStorage})
      : super(
          GameState(
            characterPosition: levels[0].characterPosition,
            level: levels[0],
            status: GameStatus.initial,
            levelNumber: 0,
          ),
        ) {
    // Registering event handlers
    on<MoveLeft>(_moveLeft);
    on<MoveRight>(_moveRight);
    on<MoveUp>(_moveUp);
    on<MoveDown>(_moveDown);
    on<Restart>(_restart);
    on<Check>(_areBananasInHoles);
    on<LevelChange>(_changeLevel);
  }

  void _changeLevel(GameEvent event, Emitter<GameState> emit) {
    event as LevelChange;
    emit(state.copyWith(
        characterPosition: levels[event.toLevel].characterPosition,
        level: levels[event.toLevel],
        levelNumber: event.toLevel,
        status: GameStatus.changeLevel));
  }

  void _moveToNextLevel(Emitter<GameState> emit) {
    int nextLevelNumber = state.levelNumber + 1;
    persistentStorage.write(
        key: StorageKeys.attendedLevel, value: nextLevelNumber);
    if (nextLevelNumber < levels.length) {
      emit(
        state.copyWith(
          characterPosition: levels[nextLevelNumber].characterPosition,
          level: levels[nextLevelNumber],
          status: GameStatus.nextLevel,
          levelNumber: nextLevelNumber,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: GameStatus.completed,
        ),
      );
    }
  }

  void _areBananasInHoles(GameEvent event, Emitter<GameState> emit) {
    if (state.level.bananasPositions
        .every((pos) => state.level.holesPositions.contains(pos))) {
      _moveToNextLevel(emit);
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
          status: GameStatus.characterMoved,
          characterPosition: nextPosition,
          level: state.level.copyWith(bananasPositions: newBananasPositons)));
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
}
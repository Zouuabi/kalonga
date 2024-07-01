import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalonga/src/entities/level.dart';
import 'package:kalonga/src/utils/levels.dart';

part 'game_event.dart';
part 'game_state.dart';

///major hhh todo: a graph algrothim BFS/DFS/A* plays the game in the most effient 
///way
///a3ml li theb w khalili li theb   
///? el qerd barka gaad yetharek b shih w yehtarem fl border 
///todo: lezm ywalli ydezz banaa if possible
///todo: if the bananans are all in correct places we 
///automatically to the next map w ndhahrou akl qardoun li yachta7
///todo: we have to calculate the score
///todo : charcter must be moved by keyboard keys if 
/// we are on desktop
/// todo: in mobile we have to be able to move kalonga by an analog 
/// (if we are on mobile arrow icons must be invisible)
/// todo : implement multiple themes (minimum 3 , colors character ...) 





class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc()
      : super(
          GameState(
              characterPosition: levels[0].characterPosition,
              level: levels[0],
              status: GameStatus.initial,
              levelNumber: 0),
        ) {
    on<MoveLeft>(_moveLeft);
    on<MoveRight>(_moveRight);
    on<MoveUp>(_moveUp);
    on<MoveDown>(_moveDown);
  }

  void _moveLeft(GameEvent event, Emitter<GameState> emit) {
    _moveCharacter(-1, emit);
  }

  void _moveRight(GameEvent event, Emitter<GameState> emit) {
    _moveCharacter(1, emit);
  }

  void _moveUp(GameEvent event, Emitter<GameState> emit) {
    _moveCharacter(-9, emit);
  }

  void _moveDown(GameEvent event, Emitter<GameState> emit) {
    _moveCharacter(9, emit);
  }

  void _moveCharacter(int offset, Emitter<GameState> emit) {
    final currentPosition = state.characterPosition;
    final nextPosition = currentPosition + offset;

    if (_canMoveTo(nextPosition, offset)) {
      emit(state.copyWith(
        status: GameStatus.characterMoved,
        characterPosition: nextPosition,
      ));
    }
  }

  bool _canMoveTo(int position, int offset) {
    if (state.level.borders.contains(position)) {
      return false;
    }

    return true;
  }
}

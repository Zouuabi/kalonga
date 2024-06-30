import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_state.dart';
part 'game_event.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  int currentlevel = 0;
  GameBloc() : super(const GameState(data: null, status: GameStatus.initial)) {
    on<CharacterMovedLeft>(_onCharacterMovedLeft);
  }

  void _onCharacterMovedLeft(GameEvent event, Emitter<GameState> emit) {
    emit(state.copyWith(data: null, status: GameStatus.characterMoved));
  }
}

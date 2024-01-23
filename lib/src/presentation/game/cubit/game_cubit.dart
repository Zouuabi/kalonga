import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_state.dart';

final List<Map<String, dynamic>> unlocked = [
  {
    'level': 0,
    'locked': false,
  },
  {
    'level': 1,
    'locked': true,
  },
  {
    'level': 2,
    'locked': true,
  },
  {
    'level': 3,
    'locked': true,
  },
  {
    'level': 4,
    'locked': true,
  },
  {
    'level': 5,
    'locked': true,
  },
  {
    'level': 6,
    'locked': true,
  },
  {
    'level': 7,
    'locked': true,
  },
  {
    'level': 8,
    'locked': true,
  },
  {
    'level': 9,
    'locked': true,
  },
];

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameState(status: Status.initial, data: unlocked));

  void unlockNextLevel({required int nextLevel}) {
    List<Map<String, dynamic>> modifiedList = List.from(state.data);
    modifiedList[nextLevel]['locked'] = false;
    emit(GameState(status: Status.initial, data: unlocked));
  }
}

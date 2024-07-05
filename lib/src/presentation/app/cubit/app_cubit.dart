import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalonga/src/data/local.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(this._persistentStorage)
      : super(const AppState(score: 0, level: 0)) {
    init();
  }

  final PersistentStorage _persistentStorage;

  void init() async {
    int level;
    int score;
    try {
      level =
          await _persistentStorage.read(key: StorageKeys.attendedLevel) ?? 0;
      score = await _persistentStorage.read(key: StorageKeys.score) ?? 0;
    } catch (_) {
      level = 0;
      score = 0;
    }
    emit(state.copyWith(level: level, score: score));
  }

  void levelUp() {
    int newLevel = state.level + 1;
    try {
      _persistentStorage.write(key: StorageKeys.attendedLevel, value: newLevel);
    } catch (_) {}
    emit(state.copyWith(level: newLevel));
  }

  void upDateScore({required int numberOfMoves}) {
    double newScore = 1000 * (0.2 * (state.level + 1)) - numberOfMoves;
    try {
      _persistentStorage.write(key: StorageKeys.score, value: newScore.toInt());
    } catch (_) {}
    emit(state.copyWith(score: newScore.toInt()));
  }
}

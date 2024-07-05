import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalonga/src/data/local.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(this._persistentStorage)
      : super(const AppState(
            score: 0,
            level: 0,
            status: AppStatus.loggedOut,
            theme: 'main',
            language: 'en')) {
    init();
  }
  final PersistentStorage _persistentStorage;

  void init() async {
    int level;
    int score;

    level = await _persistentStorage.read(key: StorageKeys.attendedLevel) ?? 0;
    score = await _persistentStorage.read(key: StorageKeys.score) ?? 0;
    String? username =
        await _persistentStorage.readString(key: StorageKeys.username);
    String theme =
        await _persistentStorage.readString(key: StorageKeys.theme) ?? 'main';
    String language =
        await _persistentStorage.readString(key: StorageKeys.language) ?? 'en';

    emit(state.copyWith(
      language: language,
      level: level,
      score: score,
      theme: theme,
      status: username == null ? AppStatus.loggedOut : AppStatus.loggeIN,
    ));
  }

  void changeLanguage({required String languageCode}) {
    _persistentStorage.writeString(
        key: StorageKeys.language, value: languageCode);
    emit(state.copyWith(language: languageCode));
  }

  void changeTheme({required String theme}) {
    _persistentStorage.writeString(key: StorageKeys.theme, value: theme);
    emit(state.copyWith(theme: theme));
  }

  void login({required String username}) {
    _persistentStorage.writeString(key: StorageKeys.username, value: username);
    emit(state.copyWith(status: AppStatus.loggeIN));
  }

  void logout() {
    _persistentStorage.clear();
    emit(state.copyWith(level: 0, score: 0, status: AppStatus.loggedOut));
  }

  void restartLevels() {
    _persistentStorage.writeInt(key: StorageKeys.attendedLevel, value: 0);
    _persistentStorage.writeInt(key: StorageKeys.score, value: 0);
    emit(state.copyWith(level: 0, score: 0));
  }

  void levelUp({required int level}) {
    if (state.level < level) {
      _persistentStorage.writeInt(key: StorageKeys.attendedLevel, value: level);
      emit(state.copyWith(level: level));
    }
  }

  void upDateScore({required int numberOfMoves}) {
    double newScore = 1000 * (0.2 * (state.level + 1)) - numberOfMoves;

    _persistentStorage.writeInt(
        key: StorageKeys.score, value: newScore.toInt());

    emit(state.copyWith(score: newScore.toInt()));
  }
}

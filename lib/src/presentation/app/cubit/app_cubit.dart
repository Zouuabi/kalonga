import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalonga/src/data/local.dart';
import 'package:kalonga/src/data/local/persistent_storage.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(this._persistentStorage)
      : super(const AppState(score: 0, level: 0)) {}

  final PersistentStorage _persistentStorage;

  void levelUp() {
    emit(state.copyWith(level: state.level + 1));
  }

  void upDateScore({required int numberOfMoves}) {
    emit(state.copyWith(level: state.score + 1));
  }
}

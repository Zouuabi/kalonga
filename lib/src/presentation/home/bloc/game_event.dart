part of 'game_bloc.dart';

sealed class GameEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class MoveLeft extends GameEvent {}

final class MoveRight extends GameEvent {}

final class MoveUp extends GameEvent {}

final class MoveDown extends GameEvent {}

final class Restart extends GameEvent {}

final class Check extends GameEvent {}

final class LevelChange extends GameEvent {
  LevelChange({required this.toLevel});
  final int toLevel;
}

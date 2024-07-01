part of 'game_bloc.dart';

sealed class GameEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class MoveLeft extends GameEvent {}

final class MoveRight extends GameEvent {}

final class MoveUp extends GameEvent {}

final class MoveDown extends GameEvent {}

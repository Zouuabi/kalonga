part of 'game_bloc.dart';

sealed class GameEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class CharacterMovedLeft extends GameEvent {}

final class CharacterMovedRight extends GameEvent {}

final class CharacterMovedUp extends GameEvent {}

final class CharacterMovedDown extends GameEvent {}

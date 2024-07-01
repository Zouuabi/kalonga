part of 'game_bloc.dart';

enum GameStatus { initial, characterMoved }

class GameState extends Equatable {
  final int characterPosition;
  final Level level;
  final GameStatus status;
  final int levelNumber;

  const GameState({
    required this.characterPosition,
    required this.level,
    required this.status,
    required this.levelNumber,
  });

  GameState copyWith({
    int? characterPosition,
    Level? level,
    GameStatus? status,
    int? levelNumber,
  }) {
    return GameState(
      characterPosition: characterPosition ?? this.characterPosition,
      level: level ?? this.level,
      status: status ?? this.status,
      levelNumber: levelNumber ?? this.levelNumber,
    );
  }

  @override
  List<Object> get props => [characterPosition, level, status, levelNumber];
}

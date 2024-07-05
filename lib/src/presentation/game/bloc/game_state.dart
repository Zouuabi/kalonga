part of 'game_bloc.dart';

enum GameStatus {
  initial,
  characterMoved,
  restarted,
  completed,
  nextLevel,
  changeLevel
}

class GameState extends Equatable {
  const GameState(
      {required this.characterPosition,
      required this.level,
      required this.status,
      required this.levelNumber,
      required this.movesNum});
  final int characterPosition;
  final Level level;
  final GameStatus status;
  final int levelNumber;
  final int movesNum;

  GameState copyWith(
      {int? characterPosition,
      Level? level,
      GameStatus? status,
      int? levelNumber,
      int? movesNum}) {
    return GameState(
      movesNum: movesNum ?? this.movesNum,
      characterPosition: characterPosition ?? this.characterPosition,
      level: level ?? this.level,
      status: status ?? this.status,
      levelNumber: levelNumber ?? this.levelNumber,
    );
  }

  @override
  String toString() {
    return """Character Positon : $characterPosition """;
  }

  @override
  List<Object> get props => [characterPosition, level, status, levelNumber];
}

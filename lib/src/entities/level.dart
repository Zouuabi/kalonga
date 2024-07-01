import 'package:equatable/equatable.dart';

class Level extends Equatable {
  final int characterPosition;
  final List<int> bananasPositions;
  final List<int> holesPositions;
  final List<int> borders;

  const Level({
    required this.characterPosition,
    required this.bananasPositions,
    required this.holesPositions,
    required this.borders,
  });

  Level copyWith({
    int? characterPosition,
    List<int>? bananasPositions,
    List<int>? holesPositions,
    List<int>? borders,
  }) {
    return Level(
      characterPosition: characterPosition ?? this.characterPosition,
      bananasPositions: bananasPositions ?? this.bananasPositions,
      holesPositions: holesPositions ?? this.holesPositions,
      borders: borders ?? this.borders,
    );
  }

  @override
  List<Object> get props => [
        bananasPositions,
        holesPositions,
        borders,
      ];
}

part of 'game_cubit.dart';

enum Status { initial, levelUnlocked }

class GameState extends Equatable {
  const GameState({required this.data, required this.status});
  final List<Map<String, dynamic>> data;
  final Status status;

  @override
  List<Object> get props => [data, status];
}

part of 'game_bloc.dart';

enum GameStatus { initial, characterMoved }

class GameState extends Equatable {
  const GameState({required this.data, required this.status});
  // final List<Map<String, dynamic>> data;
  final dynamic data;
  final GameStatus status;

  GameState copyWith({GameStatus? status, dynamic data}) {
    return GameState(data: data ?? this.data, status: status ?? this.status);
  }

  @override
  String toString() {
    return '''GameState {status: $status}''';
  }

  @override
  List<Object> get props => [data, status];
}

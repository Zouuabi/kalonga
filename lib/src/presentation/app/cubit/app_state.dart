part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({required this.score, required this.level});
  final int score;
  final int level;

  AppState copyWith({int? score, int? level}) => AppState(
        level: level ?? this.level,
        score: score ?? this.score,
      );

  @override
  List<Object?> get props => [score, level];
}

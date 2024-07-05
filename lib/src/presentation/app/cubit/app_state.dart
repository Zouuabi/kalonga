part of 'app_cubit.dart';

enum AppStatus { loggedOut, loggeIN }

class AppState extends Equatable {
  const AppState(
      {required this.score, required this.level, required this.status});
  final int score;
  final int level;
  final AppStatus status;

  AppState copyWith({int? score, int? level, AppStatus? status}) => AppState(
        status: status ?? this.status,
        level: level ?? this.level,
        score: score ?? this.score,
      );

  @override
  String toString() {
    return """Status : ${status.toString()}  """;
  }

  @override
  List<Object?> get props => [score, level, status];
}

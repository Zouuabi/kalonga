part of 'app_cubit.dart';

enum AppStatus { loggedOut, loggeIN }

class AppState extends Equatable {
  const AppState(
      {required this.score,
      required this.language,
      required this.level,
      required this.status,
      required this.theme});
  final int score;
  final int level;
  final AppStatus status;
  final String theme;
  final String language;

  AppState copyWith(
          {int? score,
          int? level,
          AppStatus? status,
          String? theme,
          String? language}) =>
      AppState(
        language: language ?? this.language,
        theme: theme ?? this.theme,
        status: status ?? this.status,
        level: level ?? this.level,
        score: score ?? this.score,
      );

  @override
  String toString() {
    return """Status : ${status.toString()}  """;
  }

  @override
  List<Object?> get props => [score, level, status, theme, language];
}

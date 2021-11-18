part of 'game_bloc.dart';

enum LoadingStatus { pure, loading, success, failure }

class GameState extends Equatable {
  final List<Game> games;
  final LoadingStatus status;
  final int? nextPage;
  final String? error;

  const GameState(
      {this.games = const [],
      this.status = LoadingStatus.pure,
      this.error,
      this.nextPage});

  GameState copyWith(
          {LoadingStatus? status,
          List<Game>? games,
          String? error,
          int? nextPage}) =>
      GameState(
        status: status ?? this.status,
        games: games ?? this.games,
        error: error ?? this.error,
        nextPage: nextPage ?? this.nextPage,
      );

  @override
  List<Object?> get props => [status, games, error, nextPage];
}

part of 'game_bloc.dart';

enum LoadingStatus { pure, loading, success, failure }

class GameState extends Equatable {
  final List<Game> games;
  final List<Game> favourites;
  final LoadingStatus status;
  final int? nextPage;
  final String? error;
  final DateTime? date;

  const GameState(
      {this.games = const [],
      this.favourites = const [],
      this.status = LoadingStatus.pure,
      this.error,
      this.nextPage,
      this.date});

  GameState copyWith({
    LoadingStatus? status,
    List<Game>? games,
    List<Game>? favourites,
    String? error,
    int? nextPage,
    DateTime? date,
  }) =>
      GameState(
          status: status ?? this.status,
          games: games ?? this.games,
          error: error ?? this.error,
          nextPage: nextPage ?? this.nextPage,
          date: date ?? this.date,
          favourites: favourites ?? this.favourites);

  @override
  List<Object?> get props => [status, games, error, nextPage, date, favourites];
}

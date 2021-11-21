part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
}

class GetGamesRequested extends GameEvent {
  final int page;
  final DateTime day;

  const GetGamesRequested({
    required this.page,
    required this.day,
  });

  @override
  List<Object?> get props => [page, day];
}

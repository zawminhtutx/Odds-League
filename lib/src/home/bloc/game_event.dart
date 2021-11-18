part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
}

class GetGamesRequested extends GameEvent {
  final int page;

  const GetGamesRequested({required this.page});

  @override
  List<Object?> get props => [];
}

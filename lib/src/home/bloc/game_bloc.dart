import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:odds_league/src/home/data/api_requests/api_requests.dart';
import 'package:odds_league/src/home/data/models/game.dart';
import 'package:odds_league/src/home/data/models/query.dart';

part 'game_event.dart';

part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final ApiRequests _apiRequests;

  GameBloc(this._apiRequests) : super(const GameState()) {
    on<GetGamesRequested>((event, emit) async {
      emit(state.copyWith(status: LoadingStatus.loading));
      final failureOrSuccess =
          await _apiRequests.getPrematchGames(Query(page: event.page));
      failureOrSuccess.fold(
        (l) => emit(
            state.copyWith(status: LoadingStatus.failure, error: l.message)),
        (r) => emit(
          state.copyWith(
            status: LoadingStatus.success,
            games: [...state.games, ...r],
            nextPage: r.isNotEmpty ? event.page + 1 : null,
          ),
        ),
      );
    });
  }
}

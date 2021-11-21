import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:odds_league/src/home/data/api_requests/api_requests.dart';
import 'package:odds_league/src/home/data/models/game.dart';
import 'package:odds_league/src/home/data/models/odd_option.dart';
import 'package:odds_league/src/home/data/models/query.dart';
import 'package:odds_league/src/utility.dart';

part 'game_event.dart';

part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final ApiRequests _apiRequests;
  List<Game> _games = [];

  GameBloc(this._apiRequests) : super(const GameState()) {
    on<GetGamesRequested>((event, emit) async {
      emit(state.copyWith(status: LoadingStatus.loading));
      final failureOrSuccess = await _apiRequests.getPrematchGames(
        Query(
          page: event.page,
          day: state.date!,
        ),
      );
      failureOrSuccess.fold(
        (l) => emit(
            state.copyWith(status: LoadingStatus.failure, error: l.message)),
        (r) {
          _games = <Game>{..._games, ...r}.toList();
          emit(
            state.copyWith(
              status: LoadingStatus.success,
              games: _filterGames(),
              nextPage: r.isNotEmpty ? event.page + 1 : null,
            ),
          );
        },
      );
    });
    on<DateSet>((event, emit) async {
      emit(state.copyWith(date: event.date));
    });
    on<AddedToFavourite>((event, emit) async {
      final game =
          _games.where((element) => element.gameId == event.gameId).first;
      final index = _games.indexOf(game);
      final newGame = game.copyWith(oddOption: event.option);
      _games.replaceRange(index, index + 1, [newGame]);
      emit(
        state.copyWith(
          games: [..._filterGames()],
          status: LoadingStatus.success,
          favourites: [..._selectFavourites()],
        ),
      );
    });
    on<RemovedFromFavourite>((event, emit) async {
      final game =
          _games.where((element) => element.gameId == event.gameId).first;
      final index = _games.indexOf(game);
      final newGame = game.copyWith(oddOption: OddOption.pure);
      _games.replaceRange(index, index + 1, [newGame]);
      emit(
        state.copyWith(
          games: [..._filterGames()],
          status: LoadingStatus.success,
          favourites: [..._selectFavourites()],
        ),
      );
    });
  }

  List<Game> _filterGames() {
    return _games
        .where(
            (element) => isSameDay(dayOne: element.time, dayTwo: state.date!))
        .toList();
  }

  List<Game> _selectFavourites() {
    return _games
        .where((element) => element.oddOption != OddOption.pure)
        .toList();
  }
}

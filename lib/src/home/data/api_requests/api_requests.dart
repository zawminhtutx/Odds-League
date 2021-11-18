import 'dart:convert';

import 'package:dartz/dartz.dart';

import 'package:http/http.dart' as http;
import 'package:odds_league/src/home/data/failures/api_failure.dart';
import 'package:odds_league/src/home/data/models/game.dart';
import 'package:odds_league/src/home/data/models/query.dart';

import '../../../../secrets.dart';

class ApiRequests {
  final List<String> _bookMakers = [
    'Bet365',
    '10Bet',
    'Ladbrokes',
    'YSB88',
    'BetClic',
    'PinnacleSports',
    '188Bet',
    'BWin',
    'BetFair',
    'CloudBet',
    'PaddyPower',
    'SBOBET',
    'TitanBet',
    'BetAtHome',
    'DafaBet',
    'Marathonbet',
    'BetVictor',
    'Interwetten',
    '1XBet',
    'NitrogenSports',
    'BetRegal',
    'CashPoint',
    'Coral',
    'Macauslot',
    'MansionBet',
    'GGBet',
  ];

  Future<Either<ApiFailure, List<Game>>> getPrematchGames(Query query) async {
    final queryParams = query.toJson();
    final uri = Uri.https('spoyer.ru', 'api/get.php', {
      ...queryParams,
      'sport': 'soccer',
      'login': apiLogin.toString(),
      'token': apiToken.toString(),
      'task': 'predatapage',
      'day': 'today'
    });

    final response = await http.get(
      uri,
    );

    if (response.statusCode == 200) {
      final gamesJsonList =
          (jsonDecode(response.body)['games_pre'] as List<dynamic>);
      final games = await Future.wait<Game>(gamesJsonList.map((e) {
        return getOddsJson(e['game_id']).then((value) => Game.fromJson(
            {...e, ...queryParams, 'is_live': false, 'odd': value}));
      }));

      return right(games);
    } else {
      return left(ApiFailure(response.body));
    }
  }

  Future<Map<String, dynamic>?> getOddsJson(String gameId) async {
    final uri = Uri.https('spoyer.ru', 'api/get.php', {
      'login': apiLogin.toString(),
      'token': apiToken.toString(),
      'task': 'allodds',
      'game_id': gameId
    });

    final response = await http.get(
      uri,
    );

    if (response.statusCode == 200) {
      final resultsMap =
          jsonDecode(response.body)['results'] as Map<String, dynamic>;
      for (var bookMaker in _bookMakers) {
        if (resultsMap.containsKey(bookMaker)) {
          if (resultsMap[bookMaker]['odds'] is Map) {
            final oddsMap =
                resultsMap[bookMaker]['odds'] as Map<String, dynamic>;
            for (var d in oddsMap.values) {
              if (d is Map) {
                final dataOdds = d as Map<String, dynamic>;
                for (var odd in dataOdds.values) {
                  if (odd is Map) {
                    final oddMap = odd as Map<String, dynamic>;
                    final containsKeys = oddMap.containsKey('home_od') ||
                        oddMap.containsKey('draw_od') ||
                        oddMap.containsKey('away_od');

                    if (containsKeys) {
                      return oddMap;
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

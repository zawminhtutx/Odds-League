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
    });

    final response = await http.get(
      uri,
    );

    if (response.statusCode == 200) {
      final gamesJsonList =
          (jsonDecode(response.body)['games_pre'] as List<dynamic>)
              .where((element) {
        final homeId = int.parse(element['home']['id']);
        final awayId = int.parse(element['away']['id']);
        return homeId < 60000 && awayId < 60000;
      });
      final nullableGames = await Future.wait<Game?>(gamesJsonList.map((e) {
        return getOddsJson(
          gameId: e['game_id'],
          isTopOdd: query.isTopOdds,
        ).then((value) {
          if (value == null) {
            return null;
          }
          return Game.fromJson(
              {...e, ...queryParams, 'is_live': false, 'odd': value});
        });
      }));
      final games = nullableGames.whereType<Game>().toList();

      return right(games);
    } else {
      return left(ApiFailure(response.body));
    }
  }

  Future<Map<String, dynamic>?> getOddsJson({
    required String gameId,
    required bool isTopOdd,
  }) async {
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
      double totalOdds = 0;
      Map<String, dynamic>? oddMapToBeReturned;

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
                      if (!isTopOdd) {
                        return oddMap;
                      }
                      final homeOdd = double.parse(oddMap['home_od'] ?? '0');
                      final awayOdd = double.parse(oddMap['away_od'] ?? '0');
                      final drawOdd = double.parse(oddMap['draw_od'] ?? '0');
                      final sumOfOdds = homeOdd + awayOdd + drawOdd;

                      if (sumOfOdds > totalOdds) {
                        oddMapToBeReturned = oddMap;
                        totalOdds = sumOfOdds;
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }

      return oddMapToBeReturned;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:odds_league/custom_theme.dart';
import 'package:odds_league/src/home/data/models/game.dart';
import 'package:odds_league/src/home/data/models/team.dart';
import 'package:odds_league/src/odd_text.dart';

import '../team_logo.dart';

class GameDetailCard extends StatelessWidget {
  final Game game;
  const GameDetailCard({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('d.M.y');
    final timeFormat = DateFormat('HH:mm');

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              dateFormat.format(game.time),
              textAlign: TextAlign.center,
            ),
            Text(
              timeFormat.format(game.time),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: _Team(
                    team: game.home,
                  ),
                ),
                Expanded(
                  child: _Team(
                    team: game.away,
                  ),
                )
              ],
            ),
            if (game.odd != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: _BettingOption(
                        team: 'П1',
                        odd: game.odd!.homeOdd,
                      ),
                    ),
                    Expanded(
                      child: _BettingOption(
                        team: 'П2',
                        odd: game.odd!.awayOdd,
                      ),
                    ),
                    Expanded(
                      child: _BettingOption(
                        team: 'X',
                        odd: game.odd!.drawOdd,
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}

class _Team extends StatelessWidget {
  final Team team;
  const _Team({Key? key, required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TeamLogo(
          team: team,
          size: 64,
        ),
        Text(team.name, textAlign: TextAlign.center)
      ],
    );
  }
}

class _BettingOption extends StatelessWidget {
  final String team;
  final double? odd;

  const _BettingOption({Key? key, required this.team, this.odd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: CustomColors.buttonBackground,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(
          child: OddText(
            team: team,
            odd: odd,
          ),
        ),
      ),
    );
  }
}

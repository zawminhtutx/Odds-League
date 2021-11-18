import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:odds_league/custom_theme.dart';
import 'package:odds_league/src/game_detail/game_detail_view.dart';
import 'package:odds_league/src/odd_text.dart';
import 'package:odds_league/src/team_logo.dart';

import 'data/models/game.dart';
import 'data/models/odd.dart';
import 'data/models/team.dart';

class GameListItem extends StatelessWidget {
  final Game game;

  const GameListItem({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('d.M.y - H:mm');

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          GameDetailView.routeName,
          arguments: game,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              dateFormat.format(game.time),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: _Teams(
                      game: game,
                    ),
                  ),
                  if (game.odd != null)
                    _OddOptionButtons(
                      odd: game.odd!,
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

class _Teams extends StatelessWidget {
  final Game game;

  const _Teams({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Team(
          team: game.home,
        ),
        const SizedBox(
          height: 8.0,
        ),
        _Team(
          team: game.away,
        ),
      ],
    );
  }
}

class _Team extends StatelessWidget {
  final Team team;
  final List<Color> colors = [
    Colors.grey,
    Colors.green,
    Colors.blue,
    Colors.black,
    Colors.purple,
    Colors.cyan,
  ];

  _Team({Key? key, required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TeamLogo(team: team),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            team.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _OddOptionButtons extends StatelessWidget {
  final Odd odd;

  const _OddOptionButtons({Key? key, required this.odd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: CustomColors.buttonBackground,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Center(
                  child: OddText(team: 'П1', odd: odd.homeOdd),
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: CustomColors.buttonBackground,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Center(
                  child: OddText(team: 'П2', odd: odd.awayOdd),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          width: 6.0,
        ),
        Container(
          height: double.infinity,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: CustomColors.buttonBackground,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Center(
            child: OddText(
              team: 'X',
              odd: odd.drawOdd,
            ),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:odds_league/src/game_detail/game_detail_card.dart';
import 'package:odds_league/src/home/data/models/game.dart';

class GameDetailView extends StatelessWidget {
  final Game game;

  const GameDetailView({Key? key, required this.game}) : super(key: key);

  static const routeName = '/detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GameDetailCard(game: game),
      ),
    );
  }
}

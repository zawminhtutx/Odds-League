import 'package:flutter/material.dart';
import 'package:odds_league/src/home/game_list_item.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: GameListItem(),
          ),
        ],
      ),
    );
  }
}

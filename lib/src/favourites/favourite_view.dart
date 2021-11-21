import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odds_league/src/home/bloc/game_bloc.dart';
import 'package:odds_league/src/home/game_list_item.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({Key? key}) : super(key: key);

  static const String routeName = 'favourite';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Text('Избранное'),
                SizedBox(
                  width: 8.0,
                ),
                Icon(Icons.star),
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            return ListView.separated(
              itemBuilder: (context, i) => Dismissible(
                key: Key(state.favourites[i].gameId),
                child: GameListItem(
                  game: state.favourites[i],
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (_) {
                  context.read<GameBloc>().add(
                      RemovedFromFavourite(gameId: state.favourites[i].gameId));
                },
              ),
              itemCount: state.favourites.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 4.0,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

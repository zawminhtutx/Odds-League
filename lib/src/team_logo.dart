import 'dart:math';

import 'package:flutter/material.dart';

import '../custom_theme.dart';
import 'home/data/models/team.dart';

class TeamLogo extends StatelessWidget {
  final Team team;
  final double size;
  final List<Color> colors = [
    Colors.grey,
    Colors.green,
    Colors.blue,
    Colors.black,
    Colors.purple,
    Colors.cyan,
  ];
  TeamLogo({Key? key, required this.team, this.size = 48.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: CustomColors.buttonBackground,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Image.network(
        'https://spoyer.ru/api/team_img/soccer/${team.id}.png',
        errorBuilder: (context, exception, stackTrace) {
          final teamName = team.name
              .split(' ')
              .take(2)
              .fold<String>('', (value, element) => value + element[0]);
          return CircleAvatar(
            backgroundColor: colors[Random().nextInt(colors.length)],
            child: Text(teamName),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:odds_league/custom_icons.dart';
import 'package:odds_league/src/calendar/calendar_view.dart';
import 'package:odds_league/src/favourites/favourite_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../custom_theme.dart';
import 'home/home_view.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 32.0,
          horizontal: 8.0,
        ),
        decoration: const BoxDecoration(
          color: CustomColors.drawerBackground,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close),
            ),
            const SizedBox(
              height: 32,
            ),
            DrawerMenu(
              icon: CustomIcons.soccer,
              text: 'Матчи',
              onPressed: () {
                Navigator.pushReplacementNamed(context, HomeView.routeName);
              },
            ),
            DrawerMenu(
              icon: CustomIcons.fire,
              text: 'Top Odds',
              onPressed: () {
                Navigator.pushReplacementNamed(context, HomeView.routeName);
              },
            ),
            DrawerMenu(
              icon: CustomIcons.group,
              text: 'Календарь',
              onPressed: () {
                Navigator.pushNamed(context, CalendarView.routeName);
              },
            ),
            DrawerMenu(
              icon: Icons.star,
              text: 'Избранное',
              onPressed: () {
                Navigator.pushNamed(context, FavouriteView.routeName);
              },
            ),
            const Spacer(),
            TextButton(
              onPressed: () async {
                const url = 'https://odds-league.flycricket.io/privacy.html';
                const snackBar =
                    SnackBar(content: Text('Could not launch $url.'));
                await canLaunch(url)
                    ? await launch(url)
                    : ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: const Text(
                'Политика конфиденциальности',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DrawerMenu extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const DrawerMenu({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(
            icon,
            color: CustomColors.accentColor,
          ),
          const SizedBox(width: 8.0),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

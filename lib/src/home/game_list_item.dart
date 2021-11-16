import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:odds_league/custom_theme.dart';

class GameListItem extends StatelessWidget {
  const GameListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text(
            '19.10.2021 - 22:00',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          IntrinsicHeight(
            child: Row(
              children: const [
                Expanded(
                  child: _Teams(),
                ),
                _OddOptionButtons(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Teams extends StatelessWidget {
  const _Teams({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _Team(),
        SizedBox(
          height: 8.0,
        ),
        _Team(),
      ],
    );
  }
}

class _Team extends StatelessWidget {
  const _Team({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: CustomColors.buttonBackground,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Image.network(
            'https://spoyer.ru/api/team_img/soccer/4734.png',
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const Text('Атлетико Мадрид'),
      ],
    );
  }
}

class _OddOptionButtons extends StatelessWidget {
  const _OddOptionButtons({Key? key}) : super(key: key);

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
                child: const Center(
                  child: Text('П1 5.80'),
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
                child: const Center(
                  child: Text('П1 5.80'),
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
          child: const Center(
            child: Text(
              'X  4.30',
            ),
          ),
        )
      ],
    );
  }
}

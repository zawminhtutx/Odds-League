import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OddText extends StatelessWidget {
  final double? odd;
  final String team;
  const OddText({Key? key, this.odd, required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat("###.00", "en_US");

    return Text('$team ${numberFormat.format(odd)}');
  }
}

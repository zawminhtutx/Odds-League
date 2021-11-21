import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:odds_league/custom_theme.dart';
import 'package:odds_league/src/custom_drawer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../custom_icons.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  static const String routeName = 'calendar';

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _focusedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(
              CustomIcons.burger,
              size: 16,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            splashRadius: 32.0,
          );
        }),
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: const [
                Text('Календарь'),
                SizedBox(
                  width: 8.0,
                ),
                Icon(CustomIcons.group),
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: _focusedDate,
          headerStyle: HeaderStyle(
            titleCentered: true,
            titleTextStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            formatButtonVisible: false,
            leftChevronPadding: EdgeInsets.zero,
            rightChevronPadding: EdgeInsets.zero,
            leftChevronIcon: const Icon(
              Icons.chevron_left,
              color: Colors.black,
              size: 32,
            ),
            rightChevronIcon: const Icon(
              Icons.chevron_right,
              color: Colors.black,
              size: 32,
            ),
            decoration: BoxDecoration(
              color: CustomColors.accentColor,
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          daysOfWeekVisible: false,
          calendarStyle: CalendarStyle(
            defaultTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            outsideDaysVisible: false,
            weekendTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            todayDecoration: BoxDecoration(
              color: CustomColors.accentColor,
              borderRadius: BorderRadius.circular(24.0),
            ),
            todayTextStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            selectedDecoration: const BoxDecoration(
              color: CustomColors.accentColor,
            ),
          ),
          onDaySelected: (dayOne, dayTwo) {
            setState(() {
              _focusedDate = dayTwo;
            });
          },
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}

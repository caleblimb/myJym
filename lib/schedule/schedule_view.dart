import 'package:flutter/material.dart';
import 'package:myjym/workout/workout_summary.dart';
import 'package:table_calendar/table_calendar.dart';
import '../auxiliary/preference_manager.dart';
import '../auxiliary/styles.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({Key? key}) : super(key: key);

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  // var workout =;

  final DateTime _firstDay = DateTime.utc(2022, 5, 22);
  final DateTime _lastDay = DateTime.utc(2022, 9, 11);

  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        TableCalendar(
          firstDay: _firstDay,
          lastDay: _lastDay,
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          eventLoader: (day) {
            return PreferenceManager.getWorkout(day);
          },
          calendarBuilders:
              CalendarBuilders(singleMarkerBuilder: (context, date, event) {
            return Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: date.isAfter(DateTime.now())
                      ? Styles.yellow
                      : (event as Map)['completed'] == true
                          ? Styles.blue
                          : Styles.orange),
              width: 5.0,
              height: 5.0,
              margin: const EdgeInsets.symmetric(horizontal: 1.5),
            );
          }),
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        ),
        Expanded(
          child: new ListView(
            children: [WorkoutSummary(day: _selectedDay)],
          ),
        ),
      ],
    ));
  }
}

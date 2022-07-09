import 'package:flutter/material.dart';
import 'package:myjym/workout/deprecated_workout.dart';
import 'package:table_calendar/table_calendar.dart';
import '../auxiliary/preference_manager.dart';

class DeprecatedCalendar extends StatefulWidget {
  const DeprecatedCalendar({Key? key}) : super(key: key);

  @override
  State<DeprecatedCalendar> createState() => _DeprecatedCalendarState();
}

class _DeprecatedCalendarState extends State<DeprecatedCalendar> {
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
            children: [
              DeprecatedWorkout(day: _selectedDay)
            ],
          ),
          // height: 300,
          // child: DeprecatedWorkout(
          //   day: _selectedDay,
          // ),
        ),
      ],
    ));
  }
}

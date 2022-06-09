import 'package:flutter/material.dart';
import 'package:myjym/auxiliary/data.dart';
import 'package:myjym/auxiliary/styles.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../tailor/workout_intensity.dart';

class PlanWorkout extends StatefulWidget {
  const PlanWorkout({Key? key, required DateTime this.date}) : super(key: key);

  final DateTime date;

  @override
  State<PlanWorkout> createState() => _PlanWorkoutState();
}

class _PlanWorkoutState extends State<PlanWorkout> {
  _PlanWorkoutState() {
    _getPreferences();
  }

  static const weekday = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  static const month = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  String _name = '';
  int _duration = 45;
  double _restLevel = 2;
  List<Map<String, Object>> _exercises = [];

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<void> _getPreferences() async{
    var prefs = await _prefs;
    _restLevel = prefs.getDouble('rest-level') ?? 0.0;
    setState(() {});
  }

  void addWorkout() {
    var _workout = {
      'name':
          _name == '' ? weekday[widget.date.weekday - 1] + "'s Workout" : _name,
      'duration': _duration.toDouble(),
      'exercises': _exercises,
    };

    workouts[getHashCode(widget.date)] = _workout;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Text(
            'Plan Workout',
            style: Styles.header1,
          ),
          Text(
              weekday[widget.date.weekday - 1] +
                  ' - ' +
                  month[widget.date.month] +
                  ' ' +
                  widget.date.day.toString() +
                  ', ' +
                  widget.date.year.toString(),
              style: Styles.header3),
          TextField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: weekday[widget.date.weekday - 1] + "'s Workout",
            ),
            onChanged: (text) {
              _name = text;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Duration', style: Styles.header3),
              NumberPicker(
                  axis: Axis.horizontal,
                  itemWidth: 46,
                  minValue: 15,
                  maxValue: 120,
                  step: 1,
                  value: _duration,
                  onChanged: (newDuration) {
                    setState(() => _duration = newDuration);
                  }),
              const Text('minutes', style: Styles.header3),
            ],
          ),
          Text(workoutIntensityRestLevels[_restLevel.toInt()]['description'].toString(),
              style: Styles.header3),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  addWorkout();
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ],
          ),

        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myjym/auxiliary/data.dart';
import 'package:myjym/auxiliary/styles.dart';
import 'package:numberpicker/numberpicker.dart';

class PlanWorkout extends StatefulWidget {
  const PlanWorkout({Key? key, required DateTime this.day}) : super(key: key);

  final DateTime day;

  @override
  State<PlanWorkout> createState() => _PlanWorkoutState();
}

class _PlanWorkoutState extends State<PlanWorkout> {
  static const weekday = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  String _name = '';
  int _duration = 45;
  List<Map<String, Object>> _exercises = [];

  void addWorkout() {
    var _workout = {
      'name': _name == '' ? weekday[widget.day.weekday] + "'s Workout" : _name,
      'duration': _duration.toDouble(),
      'exercises': [],
    };

    workouts[getHashCode(widget.day)] = _workout;
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
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: weekday[widget.day.weekday - 1] + "'s Workout",
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
          ElevatedButton(
            onPressed: () {
              addWorkout();
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

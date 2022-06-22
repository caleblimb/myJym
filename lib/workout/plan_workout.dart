import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myjym/auxiliary/data.dart';
import 'package:myjym/auxiliary/preference_manager.dart';
import 'package:myjym/auxiliary/styles.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';


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

  int _durationWarmup = 5;
  int _durationLifting = 45;
  int _durationCooldown = 5;
  int _categorySelected = 0;
  int _strengthLevel = 0;
  int _gender = 0;
  int _weight = 0;

  var _categories = [
    Category.legs,
    Category.torso,
  ];

  double _restLevel = 2;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> _getPreferences() async {
    var prefs = await _prefs;
    _restLevel = prefs.getDouble('rest-level') ?? 0.0;
    _strengthLevel = prefs.getDouble('strength-level')?.toInt() ?? 0;
    _gender = prefs.getInt('gender') ?? 0;
    _weight = prefs.getInt('weight') ?? 100;
    setState(() {});
  }

  void addWorkout() {
    var duration = _durationLifting.toDouble();
    var exercises = populateWorkout(duration);

    var _workout = {
      'name':
          _name == '' ? weekday[widget.date.weekday - 1] + "'s Workout" : _name,
      'duration_warmup': _durationWarmup.toDouble(),
      'duration_lifting': duration,
      'duration_cooldown': _durationCooldown.toDouble(),
      'exercises': exercises,
    };
    String hashCode = getHashCode(widget.date).toString();
    PreferenceManager.addWorkout(hashCode, _workout);
  }

  List<Map<String, Object>> populateWorkout(double duration) {
    List<Map<String, Object>> exercises = [];
    var time = 0.0;
    Category category = _categories[_categorySelected];
    var possibleWorkouts = List.from(Data.categoryInfo[category] as List);
    var rng = Random();

    while (time < duration) {
      if (possibleWorkouts.isNotEmpty) {
        Exercise type = possibleWorkouts[rng.nextInt(possibleWorkouts.length)];

        var multiplierList = (_gender == 0
            ? Data.exerciseInfo[type]!['female_levels']
            : Data.exerciseInfo[type]!['male_levels']) as List;
        var multiplier = multiplierList[_strengthLevel];
        List<Map<String, num?>> sets = [];

        if (Data.exerciseInfo[type]!['units'] == repUnit.bodyWeightRatio) {
          double maxRep = (_weight * multiplier).toDouble();
          Data.setStyleInfo[setStyle.standard]?.forEach((set) {
            sets.add(
                {'weight': (set['weight']! * maxRep), 'reps': set['reps']});
          });
        } else if (Data.exerciseInfo[type]!['units'] == repUnit.count || true) {
          Data.setStyleInfo[setStyle.standard]?.forEach((set) {
            sets.add({'weight': 0.0, 'reps': multiplier});
          });
        }
        exercises.add({'type': type.index, 'sets': sets});

        possibleWorkouts.remove(type);
        time += 5.0;
      } else {
        _durationCooldown += (duration - time).toInt();
        duration = 0;
      }
    }
    return exercises;
  }

  Widget _categoryIcon(int index,
      {required String text, required IconData iconData}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: InkResponse(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                iconData,
                color: _categorySelected == index ? Styles.orange : null,
              ),
              Text(
                text,
                style: TextStyle(
                    color: _categorySelected == index ? Styles.orange : null),
              ),
            ],
          ),
          onTap: () => setState(
            () {
              _categorySelected = index;
            },
          ),
        ),
      ),
    );
  }

  Widget _categorySelect() {
    return Container(
      child: Row(
        children: [
          _categoryIcon(0,
              text: 'Legs', iconData: Icons.airline_seat_legroom_normal),
          // _icon(1, text: 'Core', iconData: Icons.airline_seat_flat),
          _categoryIcon(1, text: 'Torso', iconData: Icons.paragliding),
        ],
      ),
    );
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
          Styles.horizontalRule(
            top: 4,
            bottom: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Warmup', style: Styles.header3),
              NumberPicker(
                  axis: Axis.horizontal,
                  itemWidth: 46,
                  minValue: 0,
                  maxValue: 30,
                  step: 1,
                  value: _durationWarmup,
                  onChanged: (newDuration) {
                    setState(() => _durationWarmup = newDuration);
                  }),
              const Text('minutes', style: Styles.header3),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Lifting', style: Styles.header3),
              NumberPicker(
                  axis: Axis.horizontal,
                  itemWidth: 46,
                  minValue: 15,
                  maxValue: 120,
                  step: 1,
                  value: _durationLifting,
                  onChanged: (newDuration) {
                    setState(() => _durationLifting = newDuration);
                  }),
              const Text('minutes', style: Styles.header3),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Cooldown', style: Styles.header3),
              NumberPicker(
                  axis: Axis.horizontal,
                  itemWidth: 46,
                  minValue: 0,
                  maxValue: 30,
                  step: 1,
                  value: _durationCooldown,
                  onChanged: (newDuration) {
                    setState(() => _durationCooldown = newDuration);
                  }),
              const Text('minutes', style: Styles.header3),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Workout Duration: ' +
                    (_durationWarmup + _durationLifting + _durationCooldown)
                        .toString() +
                    ' minutes',
                style: Styles.header3,
              )
            ],
          ),
          Styles.horizontalRule(
            top: 8,
          ),
          // Text(
          //     workoutIntensityRestLevels[_restLevel.toInt()]['description']
          //         .toString(),
          //     style: Styles.header3),
          _categorySelect(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(32),
                child: ElevatedButton(
                  onPressed: () {
                    addWorkout();
                    Navigator.pop(context);
                  },
                  child: const Text('Add'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

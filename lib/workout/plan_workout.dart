import 'dart:math';
import 'package:flutter/material.dart';
import 'package:myjym/auxiliary/data.dart';
import 'package:myjym/auxiliary/preference_manager.dart';
import 'package:myjym/auxiliary/styles.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:myjym/auxiliary/myjym_icons.dart';

class PlanWorkout extends StatefulWidget {
  const PlanWorkout({Key? key, required this.date}) : super(key: key);

  final DateTime date;

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

  final _categories = [
    Category.torso,
    Category.push,
    Category.pull,
    Category.legs,
    Category.full,
  ];

  double _restLevel = 2;

  void addWorkout() {
    var duration = _durationLifting.toDouble();
    var exercises = populateWorkout(duration);

    var workout = {
      'name':
          _name == '' ? "${weekday[widget.date.weekday - 1]}'s Workout" : _name,
      'duration_warmup': _durationWarmup.toDouble(),
      'warmup_completed': false,
      'duration_lifting': duration,
      'duration_cooldown': _durationCooldown.toDouble(),
      'cooldown_completed': false,
      'exercises': exercises,
      'completed': false,
    };
    String hashCode = getHashCode(widget.date).toString();
    PreferenceManager.addWorkout(hashCode, workout);
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

        var hasEquipment = true;
        List<dynamic> equipNeed =
            Data.exerciseInfo[type]!['equipment'] as List<dynamic>;
        var equipLevel = PreferenceManager.getEquipmentLevel();
        List<dynamic> equipHave =
            Data.equipmentInfo[equipLevel] as List<dynamic>;

        if (equipNeed.isNotEmpty) {
          if (equipHave.isEmpty) {
            hasEquipment = false;
          } else {
            for (var need in equipNeed) {
              var found = false;
              for (var have in equipHave) {
                if (have == need) {
                  found = true;
                  break;
                }
              }
              if (!found) {
                hasEquipment = false;
                break;
              }
            }
          }
        }
        if (hasEquipment) {
          var multiplierList = (PreferenceManager.getGender() == 0
              ? Data.exerciseInfo[type]!['female_levels']
              : Data.exerciseInfo[type]!['male_levels']) as List;
          var multiplier =
              multiplierList[PreferenceManager.getStrengthLevel().toInt()];
          List<Map<String, num?>> sets = [];

          if (Data.exerciseInfo[type]!['units'] == repUnit.bodyWeightRatio) {
            double maxRep =
                (PreferenceManager.getWeight() * multiplier).toDouble();
            Data.setStyleInfo[setStyle.standard]?.forEach((set) {
              sets.add(
                  {'weight': (set['weight']! * maxRep), 'reps': set['reps']});
            });
          } else if (Data.exerciseInfo[type]!['units'] == repUnit.count) {
            Data.setStyleInfo[setStyle.standard]?.forEach((set) {
              sets.add({
                'weight': 0.0,
                'reps': (set['weight']! * multiplier).toInt()
              });
            });
          }
          exercises.add({'type': type.index, 'sets': sets, 'completed': false});
          time += 5.0;
        }

        possibleWorkouts.remove(type);
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
          _categoryIcon(0, text: 'Torso', iconData: MyJymIcons.arm),
          _categoryIcon(1, text: 'Push', iconData: MyJymIcons.push),
          _categoryIcon(2, text: 'Pull', iconData: MyJymIcons.pull),
        ],
      ),
    );
  }

  Widget _categorySelect2() {
    return Container(
      child: Row(
        children: [
          _categoryIcon(3, text: 'Leg', iconData: MyJymIcons.leg),
          _categoryIcon(4,
              text: 'Full Body', iconData: MyJymIcons.accessibility)
        ],
      ),
    );
  }

  Widget _categorySelect3() {
    return Container(
      child: Row(
        children: [],
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
              '${weekday[widget.date.weekday - 1]} - ${month[widget.date.month]} ${widget.date.day}, ${widget.date.year}',
              style: Styles.header3),
          TextField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: "${weekday[widget.date.weekday - 1]}'s Workout",
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
                'Workout Duration: ${_durationWarmup + _durationLifting + _durationCooldown} minutes',
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
          _categorySelect2(),
          _categorySelect3(),
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

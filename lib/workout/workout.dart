import 'package:flutter/material.dart';
import 'package:myjym/auxiliary/preference_manager.dart';
import 'package:myjym/auxiliary/styles.dart';
import 'package:myjym/workout/plan_workout.dart';

import '../auxiliary/data.dart';
import '../auxiliary/modal.dart';
import 'instruction.dart';

class Workout extends StatelessWidget {
  Workout({Key? key, required this.day}) : super(key: key);
  final DateTime? day;

  Widget _noWorkout({required context}) {
    return Container(
      child: Column(
        children: [
          const Text(
            'No Workout Planned',
            style: Styles.header1,
          ),
          ElevatedButton(
            onPressed: (() {
              Modal.open(context: context, child: PlanWorkout(date: day!));
            }),
            child: const Text('Plan Workout'),
          ),
        ],
      ),
    );
  }

  static const _backgroundColor = Colors.white;
  static const _margin = EdgeInsets.fromLTRB(8, 4, 8, 4);
  static const _padding = EdgeInsets.fromLTRB(8, 4, 8, 4);
  static const _borderRadius = BorderRadius.all(Radius.circular(20));
  static var _border = Border.all(
    width: 2,
    color: Styles.brown,
  );

  Widget _workoutDisplay({required workout, required context}) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Text(
              workout['name'] as String,
              style: Styles.header1,
            ),
            Styles.horizontalRule(),
            Text(
              'Warm up for ' +
                  (workout['duration_warmup']).toInt().toString() +
                  ' minutes',
              style: Styles.header2,
            ),
            ...(workout['exercises']).map((exercise) {
              return Container(
                  margin: _margin,
                  padding: _padding,
                  decoration: BoxDecoration(
                    color: _backgroundColor,
                    borderRadius: _borderRadius,
                    border: _border,
                  ),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Text(
                            Data.exerciseInfo[Exercise.values[exercise['type']]]!['name']
                                as String,
                            style: Styles.header2,
                          ),
                          ...(exercise['sets']).map((set) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                set['weight'] == 0.0
                                    ? const Text('')
                                    : Text(
                                        set['weight'].toStringAsFixed(1),
                                        style: Styles.header3,
                                      ),
                                set['weight'] == 0.0
                                    ? const Text(
                                        'Body Weight * ',
                                        style: Styles.header3,
                                      )
                                    : const Text(
                                        ' lbs * ',
                                        style: Styles.header3,
                                      ),
                                Text(
                                  set['reps'].toString(),
                                  style: Styles.header3,
                                ),
                                const Text(
                                  ' reps',
                                  style: Styles.header3,
                                ),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: FloatingActionButton.small(
                          onPressed: () => Modal.open(
                              context: context, child: Instruction(exercise: exercise['type'])),
                          child: const Icon(Icons.question_mark_rounded),
                        ),
                      ),
                    ],
                  ));
            }).toList(),
            Text(
              'Cool down for ' +
                  (workout['duration_cooldown']).toInt().toString() +
                  ' minutes',
              style: Styles.header2,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: day == null
            ? const Text(
                'No day selected',
                style: Styles.header1,
              )
            : PreferenceManager.getWorkout(day).isNotEmpty
                ? _workoutDisplay(
                    workout: PreferenceManager.getWorkout(day)[0] as Map<String, dynamic>,
                    context: context)
                : _noWorkout(context: context));
  }
}

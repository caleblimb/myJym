import 'package:flutter/material.dart';
import 'package:myjym/auxiliary/preference_manager.dart';
import 'package:myjym/auxiliary/styles.dart';
import 'package:myjym/workout/plan_workout.dart';

import '../auxiliary/data.dart';
import '../auxiliary/modal.dart';
import 'instruction.dart';

class DeprecatedWorkout extends StatefulWidget {
  const DeprecatedWorkout({Key? key, required this.day}) : super(key: key);
  final DateTime? day;

  static const _backgroundColor = Colors.white;
  static const _margin = EdgeInsets.fromLTRB(8, 4, 8, 4);
  static const _padding = EdgeInsets.fromLTRB(8, 4, 8, 4);
  static const _borderRadius = BorderRadius.all(Radius.circular(20));
  static final _border = Border.all(
    width: 2,
    color: Styles.brown,
  );

  @override
  State<DeprecatedWorkout> createState() => _DeprecatedWorkoutState();
}

class _DeprecatedWorkoutState extends State<DeprecatedWorkout> {
  Widget _noWorkout({required context}) {
    return Container(
      child: Column(
        children: [
          const Text(
            'No Workout Planned',
            style: Styles.header1,
          ),
          ElevatedButton(
            onPressed: () async {
              await Modal.open(
                  context: context, child: PlanWorkout(date: widget.day!));
              setState(() {});
            },
            child: const Text('Plan Workout'),
          ),
        ],
      ),
    );
  }

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
                  margin: DeprecatedWorkout._margin,
                  padding: DeprecatedWorkout._padding,
                  decoration: BoxDecoration(
                    color: DeprecatedWorkout._backgroundColor,
                    borderRadius: DeprecatedWorkout._borderRadius,
                    border: DeprecatedWorkout._border,
                  ),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Text(
                            Data.exerciseInfo[Exercise
                                .values[exercise['type']]]!['name'] as String,
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
                          onPressed: () async {
                            await Modal.open(
                                context: context,
                                child: Instruction(exercise: Exercise.values[exercise['type']]));
                            setState(() {});
                          },
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
        child: widget.day == null
            ? const Text(
                'No day selected',
                style: Styles.header1,
              )
            : PreferenceManager.getWorkout(widget.day).isNotEmpty
                ? _workoutDisplay(
                    workout: PreferenceManager.getWorkout(widget.day)[0]
                        as Map<String, dynamic>,
                    context: context)
                : _noWorkout(context: context));
  }
}

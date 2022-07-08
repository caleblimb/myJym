import 'package:flutter/material.dart';
import 'package:myjym/workout/plan_workout.dart';

import '../auxiliary/data.dart';
import '../auxiliary/modal.dart';
import '../auxiliary/preference_manager.dart';
import '../auxiliary/styles.dart';
import 'instruction.dart';

class InteractivePageViewWorkout extends StatefulWidget {
  const InteractivePageViewWorkout({Key? key, required this.day})
      : super(key: key);
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
  State<InteractivePageViewWorkout> createState() =>
      _InteractivePageViewWorkoutState();
}

class _InteractivePageViewWorkoutState
    extends State<InteractivePageViewWorkout> {
  final PageController _controllerHorizontal =
      PageController(viewportFraction: 0.9);

  void _completeWorkout() {}

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

  Widget _card({required child}) {
    return Container(
        width: double.infinity,
        margin: InteractivePageViewWorkout._margin,
        padding: InteractivePageViewWorkout._padding,
        decoration: BoxDecoration(
          color: InteractivePageViewWorkout._backgroundColor,
          borderRadius: InteractivePageViewWorkout._borderRadius,
          border: InteractivePageViewWorkout._border,
        ),
        child: child);
  }

  Widget _warmup({required workout}) {
    return SizedBox(
      width: double.infinity,
      child: _card(
        child: Text(
          'Warm up for ' +
              (workout['duration_warmup']).toInt().toString() +
              ' minutes',
          style: Styles.header2,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _listWorkout({required workout, required context}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _warmup(workout: workout),
          ...(workout['exercises']).map((exercise) {
            return _card(
                child: Stack(
              children: [
                Column(
                  children: [
                    Text(
                      Data.exerciseInfo[Exercise.values[exercise['type']]]![
                          'name'] as String,
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
                          child: Instruction(
                              exercise: Exercise.values[exercise['type']]));
                      setState(() {});
                    },
                    child: const Icon(Icons.question_mark_rounded),
                  ),
                ),
              ],
            ));
          }).toList(),
          _card(
            child: Column(
              children: [
                Text(
                  'Cool down for ' +
                      (workout['duration_cooldown']).toInt().toString() +
                      ' minutes',
                  style: Styles.header2,
                ),
                ElevatedButton(
                  onPressed: () {
                    _completeWorkout();
                  },
                  child: const Text('Complete Workout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pagedWorkout({required workout, required context}) {
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: _controllerHorizontal,
      pageSnapping: !PreferenceManager.getWorkoutViewIsVertical(),
      children: [
        _warmup(workout: workout),
        ...(workout['exercises']).map((exercise) {
          return _card(
              child: Stack(
            children: [
              Column(
                children: [
                  Text(
                    Data.exerciseInfo[Exercise.values[exercise['type']]]![
                        'name'] as String,
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
                        child: Instruction(
                            exercise: Exercise.values[exercise['type']]));
                    setState(() {});
                  },
                  child: const Icon(Icons.question_mark_rounded),
                ),
              ),
            ],
          ));
        }).toList(),
        _card(
          child: Column(
            children: [
              Text(
                'Cool down for ' +
                    (workout['duration_cooldown']).toInt().toString() +
                    ' minutes',
                style: Styles.header2,
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _completeWorkout();
                      },
                      child: const Text('Complete Workout'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _workoutDisplay({required workout, required context}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton.small(
              onPressed: () {
                setState(() {});
              },
              child: const Icon(Icons.delete),
            ),
            Expanded(
              child: Text(
                workout['name'] as String,
                style: Styles.header1,
                textAlign: TextAlign.center,
              ),
            ),
            FloatingActionButton.small(
              onPressed: () {
                setState(() {
                  PreferenceManager.toggleWorkoutViewIsVertical();
                });
              },
              child: PreferenceManager.getWorkoutViewIsVertical()
                  ? const Icon(Icons.swap_vert)
                  : const Icon(Icons.swap_horiz),
            ),
          ],
        ),
        SizedBox(
          height: 600,
          child: PreferenceManager.getWorkoutViewIsVertical()
              ? _listWorkout(workout: workout, context: context)
              : _pagedWorkout(workout: workout, context: context),
        ),
      ],
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

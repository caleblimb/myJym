import 'package:flutter/material.dart';
import 'package:myjym/workout/plan_workout.dart';

import '../auxiliary/data.dart';
import '../auxiliary/modal.dart';
import '../auxiliary/preference_manager.dart';
import '../auxiliary/styles.dart';
import 'instruction.dart';

class WorkoutDetailed extends StatefulWidget {
  const WorkoutDetailed({Key? key, required this.day}) : super(key: key);
  final DateTime? day;

  static const _margin = EdgeInsets.fromLTRB(8, 4, 8, 4);
  static const _padding = EdgeInsets.fromLTRB(8, 4, 8, 4);
  static const _borderRadius = BorderRadius.all(Radius.circular(20));
  static final _border = Border.all(
    width: 2,
    color: Styles.brown,
  );

  @override
  State<WorkoutDetailed> createState() => _WorkoutDetailedState();
}

class _WorkoutDetailedState extends State<WorkoutDetailed> {
  void _completeWorkout() {
    //Set workout to complete
    var workout =
        PreferenceManager.getWorkout(widget.day)[0] as Map<String, dynamic>;
    DateTime day = widget.day ?? DateTime.now();
    workout['completed'] = !workout['completed'];
    PreferenceManager.addWorkout(getHashCode(day).toString(), workout);
  }

  Widget _completeWorkoutButton({required workout}) {
    return ElevatedButton(
      onPressed: () {
        _completeWorkout();
        setState(() {});
      },
      child: workout['completed']
          ? const Text('Completed')
          : const Text('Complete Workout'),
    );
  }

  Widget _card({required child}) {
    return Container(
        width: double.infinity,
        margin: WorkoutDetailed._margin,
        padding: WorkoutDetailed._padding,
        decoration: BoxDecoration(
          borderRadius: WorkoutDetailed._borderRadius,
          border: WorkoutDetailed._border,
        ),
        child: child);
  }

  Widget _warmup({required workout}) {
    return SizedBox(
      width: double.infinity,
      child: InkResponse(
        onTap: () {
          setState(() {
            workout['warmup_completed'] = !workout['warmup_completed'];
          });
        },
        child: _card(
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              Column(
                children: [
                  Text(
                    'Warm up for ${(workout['duration_warmup']).toInt()} minutes',
                    style: Styles.header1,
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'Stretch your muscles to prevent injury.',
                    style: Styles.header3,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 46,
                  )
                ],
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: FloatingActionButton.small(
                  onPressed: () {
                    setState(() {
                      workout['warmup_completed'] =
                          !workout['warmup_completed'];
                    });
                  },
                  child: Icon(
                    Icons.done,
                    color: workout['warmup_completed']
                        ? Colors.green
                        : Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _cooldown({required workout}) {
    return InkResponse(
      onTap: () {
        setState(() {
          workout['cooldown_completed'] = !workout['cooldown_completed'];
        });
      },
      child: _card(
        child: Column(
          children: [
            Text(
              'Cool down for ${(workout['duration_cooldown']).toInt()} minutes',
              style: Styles.header1,
              textAlign: TextAlign.center,
            ),
            PreferenceManager.getWorkoutViewIsVertical()
                ? _completeWorkoutButton(workout: workout)
                : Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [_completeWorkoutButton(workout: workout)],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _exerciseInfo({
    required exercise,
    titleFont = Styles.header2,
    setFont = Styles.header3,
  }) {
    return Column(
      children: [
        Text(
          Data.exerciseInfo[Exercise.values[exercise['type']]]!['name']
              as String,
          textAlign: TextAlign.center,
          style: titleFont,
        ),
        ...(exercise['sets']).map((set) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              set['weight'] == 0.0
                  ? const Text('')
                  : Text(
                      set['weight'].toStringAsFixed(1),
                      style: setFont,
                    ),
              set['weight'] == 0.0
                  ? Text(
                      'Body Weight * ',
                      style: setFont,
                    )
                  : Text(
                      ' lbs * ',
                      style: setFont,
                    ),
              Text(
                set['reps'].toString(),
                style: setFont,
              ),
              Text(
                ' reps',
                style: setFont,
              ),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget _listWorkout({required workout, required context}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _warmup(workout: workout),
          ...(workout['exercises']).map((exercise) {
            return InkResponse(
              onTap: () {
                setState(() {
                  exercise['completed'] = !exercise['completed'];
                });
              },
              onDoubleTap: () async {
                await Modal.open(
                    context: context,
                    child: Instruction(
                        exercise: Exercise.values[exercise['type']]));
                setState(() {});
              },
              child: _card(
                child: Stack(
                  children: [
                    _exerciseInfo(exercise: exercise),
                  ],
                ),
              ),
            );
          }).toList(),
          _cooldown(workout: workout),
        ],
      ),
    );
  }

  Widget _workoutDisplay({required workout, required context}) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  workout['name'] as String,
                  style: Styles.header1,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Expanded(child: _listWorkout(workout: workout, context: context)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Text('Detailed Workout View');
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
                : const Text(
                    'No workout selected',
                    style: Styles.header1,
                  ));
  }
}

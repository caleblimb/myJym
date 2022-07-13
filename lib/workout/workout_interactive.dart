import 'package:flutter/material.dart';
import 'package:myjym/workout/plan_workout.dart';

import '../auxiliary/data.dart';
import '../auxiliary/modal.dart';
import '../auxiliary/preference_manager.dart';
import '../auxiliary/styles.dart';
import 'instruction.dart';

class WorkoutInteractive extends StatefulWidget {
  const WorkoutInteractive({Key? key, required this.day}) : super(key: key);
  final DateTime? day;

  static const _margin = EdgeInsets.fromLTRB(8, 4, 8, 4);
  static const _padding = EdgeInsets.fromLTRB(8, 4, 8, 4);
  static const _borderRadius = BorderRadius.all(Radius.circular(20));
  static final _border = Border.all(
    width: 2,
    color: Styles.brown,
  );

  @override
  State<WorkoutInteractive> createState() => _WorkoutInteractiveState();
}

class _WorkoutInteractiveState extends State<WorkoutInteractive> {
  PageController _controllerHorizontal = PageController(viewportFraction: 0.9);

  void _completeWorkout() {
    //Set workout to complete
    var workout =
        PreferenceManager.getWorkout(widget.day)[0] as Map<String, dynamic>;
    DateTime day = widget.day ?? DateTime.now();
    workout['completed'] = !workout['completed'];
    PreferenceManager.addWorkout(getHashCode(day).toString(), workout);
  }

  Widget _noWorkout({required context}) {
    return Flexible(
      child: Column(
        children: [
          const Text(
            'No Workout Planned',
            style: Styles.header1,
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await Modal.open(
                        context: context,
                        child: PlanWorkout(date: widget.day!));
                    setState(() {});
                  },
                  child: const Text('Plan Workout'),
                ),
                const SizedBox(
                  height: 32,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _questionMarkButton({required exercise}) {
    return Positioned(
      bottom: 0,
      left: 0,
      child: FloatingActionButton.small(
        onPressed: () async {
          await Modal.open(
              context: context,
              child: Instruction(exercise: Exercise.values[exercise['type']]));
          setState(() {});
        },
        // child: const Icon(Icons.question_mark_rounded),
        child: const Icon(Icons.question_mark_rounded),
      ),
    );
  }

  Widget _exerciseCheckmarkButton({required exercise, required workout}) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: FloatingActionButton.small(
        onPressed: () {
          setState(() {
            exercise['completed'] = !exercise['completed'];
          });
        },
        child: Icon(
          Icons.done,
          color: exercise['completed'] || workout['completed'] ? Colors.green : Colors.white,
        ),
      ),
    );
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
        margin: WorkoutInteractive._margin,
        padding: WorkoutInteractive._padding,
        decoration: BoxDecoration(
          borderRadius: WorkoutInteractive._borderRadius,
          border: WorkoutInteractive._border,
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
                    _exerciseCheckmarkButton(exercise: exercise, workout: workout),
                    _questionMarkButton(exercise: exercise),
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

  Widget _pagedWorkout({required workout, required context}) {
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: _controllerHorizontal,
      pageSnapping: !PreferenceManager.getWorkoutViewIsVertical(),
      onPageChanged: (index) {
        setState(() {
          if (index == 1) {
            workout['warmup_completed'] = true;
          } else {
            workout['exercises'][index - 2]['completed'] = true;
          }
        });
      },
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
                  child:
                      Instruction(exercise: Exercise.values[exercise['type']]));
              setState(() {});
            },
            child: _card(
              child: Stack(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: Container()),
                        _exerciseInfo(
                            exercise: exercise,
                            titleFont: const TextStyle(
                              color: Styles.brown,
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                            setFont: const TextStyle(
                              color: Styles.brown,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            )),
                        Expanded(child: Container()),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 16,
                          ),
                          child: Instruction.exerciseTips(
                            exerciseType: Exercise.values[exercise['type']],
                            textStyle: const TextStyle(fontSize: 18),
                            iconTop: 4,
                          ),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                  ),
                  _exerciseCheckmarkButton(exercise: exercise, workout: workout),
                  _questionMarkButton(exercise: exercise),
                ],
              ),
            ),
          );
        }).toList(),
        _cooldown(workout: workout),
      ],
    );
  }

  Widget _workoutDisplay({required workout, required context}) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton.small(
                onPressed: () {
                  DateTime day = widget.day ?? DateTime.now();
                  PreferenceManager.deleteWorkout(getHashCode(day).toString());
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
                    if (!PreferenceManager.getWorkoutViewIsVertical()) {
                      var i = 0;
                      if (workout['warmup_completed']) {
                        i++;
                        for (var exercise in workout['exercises']) {
                          if (!exercise['completed']) {
                            break;
                          }
                          i++;
                        }
                      }
                      _controllerHorizontal =
                          PageController(viewportFraction: 0.9, initialPage: i);
                    }
                  });
                },
                child: PreferenceManager.getWorkoutViewIsVertical()
                    ? const Icon(Icons.view_agenda)
                    : const Icon(Icons.view_array),
              ),
            ],
          ),
          Expanded(
            child: PreferenceManager.getWorkoutViewIsVertical()
                ? _listWorkout(workout: workout, context: context)
                : _pagedWorkout(workout: workout, context: context),
          ),
        ],
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

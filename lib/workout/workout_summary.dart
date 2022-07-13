import 'package:flutter/material.dart';
import 'package:myjym/auxiliary/preference_manager.dart';
import 'package:myjym/auxiliary/styles.dart';
import 'package:myjym/workout/plan_workout.dart';
import 'package:myjym/workout/workout_detailed.dart';

import '../auxiliary/data.dart';
import '../auxiliary/modal.dart';
import 'instruction.dart';

class WorkoutSummary extends StatefulWidget {
  const WorkoutSummary({Key? key, required this.day}) : super(key: key);
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
  State<WorkoutSummary> createState() => _WorkoutSummaryState();
}

class _WorkoutSummaryState extends State<WorkoutSummary> {
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
              await Modal.openFull(
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
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(width: 2, color: Styles.brown),
        ),
        child: InkResponse(
          onDoubleTap: () async {
            await Modal.openFull(
              context: context,
              child: WorkoutDetailed(day: widget.day),
            );
            setState(() {});
          },
          child: Stack(
            children: [
              Column(
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
                      Text(
                        workout['name'] as String,
                        style: Styles.header1,
                      ),
                      FloatingActionButton.small(
                        onPressed: () async {
                          await Modal.openFull(
                            context: context,
                            child: WorkoutDetailed(day: widget.day),
                          );
                          setState(() {});
                        },
                        child: const Icon(Icons.lightbulb),
                      ),
                    ],
                  ),

                  Styles.horizontalRule(),
                  Text(
                    'Warm up for ${(workout['duration_warmup']).toInt()} minutes',
                    style: Styles.header3,
                  ),
                  ...(workout['exercises']).map((exercise) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Data.exerciseInfo[Exercise.values[exercise['type']]]![
                              'name'] as String,
                          style: Styles.header3,
                        ),
                        const Text(
                          ' * ',
                          style: Styles.header3,
                        ),
                        Text(
                          (exercise['sets'] as List).length.toString(),
                          style: Styles.header3,
                        ),
                      ],
                    );
                  }).toList(),
                  Text(
                    'Cool down for ${(workout['duration_cooldown']).toInt()} minutes',
                    style: Styles.header3,
                  ),
                ],
              ),
            ],
          ),
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

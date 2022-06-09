import 'package:flutter/material.dart';
import 'package:myjym/auxiliary/styles.dart';
import 'package:myjym/workout/plan_workout.dart';

import '../auxiliary/data.dart';
import '../auxiliary/modal.dart';

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

  Widget _workoutDisplay({required workout}) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Text(
              workout['name'] as String,
              style: Styles.header1,
            ),
            ...(workout['exercises']).map((exercise) {
              return Column(
                children: [
                  Styles.horizontalRule,
                  Text(
                    Data.exerciseInfo[exercise['type']]!['name'] as String,
                    style: Styles.header2,
                  ),
                  ...(exercise['sets']).map((set) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          set['weight'].toString(),
                          style: Styles.header3,
                        ),
                        const Text(
                          ' lbs * ',
                          style: Styles.header3,
                        ),
                        Text(
                          set['reps'].toString(),
                          style: Styles.header3,
                        ),
                      ],
                    );
                  }).toList(),
                ],
              );
            }).toList(),
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
            : getWorkout(day).isNotEmpty
                ? _workoutDisplay(
                    workout: getWorkout(day)[0] as Map<String, Object>)
                : _noWorkout(context: context));
  }
}

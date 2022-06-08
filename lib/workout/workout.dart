import 'package:flutter/material.dart';
import 'package:myjym/auxiliary/styles.dart';

import '../auxiliary/data.dart';

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

final events = {
  getHashCode(DateTime.utc(2022, 6, 8)): {
    'name': 'Upper Body',
    'duration': 45.0,
    'exercises': [
      {
        'type': 'bench_press',
        'sets': [
          {'weight': 100.0, 'reps': 10},
          {'weight': 100.0, 'reps': 10},
          {'weight': 100.0, 'reps': 10},
        ]
      },
      {
        'type': 'shoulder_press',
        'sets': [
          {'weight': 120.0, 'reps': 12},
          {'weight': 120.0, 'reps': 10},
          {'weight': 120.0, 'reps': 8},
        ]
      },
      {
        'type': 'deadlift',
        'sets': [
          {'weight': 100.0, 'reps': 10},
          {'weight': 100.0, 'reps': 10},
          {'weight': 100.0, 'reps': 10},
        ]
      },
      {
        'type': 'barbell_curl',
        'sets': [
          {'weight': 120.0, 'reps': 12},
          {'weight': 120.0, 'reps': 10},
          {'weight': 120.0, 'reps': 8},
        ]
      },
    ]
  },
  getHashCode(DateTime.utc(2022, 6, 10)): {
    'name': 'Upper Body',
    'duration': 45.0,
    'exercises': [
      {
        'type': 'bench_press',
        'sets': [
          {'weight': 100.0, 'reps': 10},
          {'weight': 100.0, 'reps': 10},
          {'weight': 100.0, 'reps': 10},
        ]
      },
      {
        'type': 'shoulder_press',
        'sets': [
          {'weight': 120.0, 'reps': 12},
          {'weight': 120.0, 'reps': 10},
          {'weight': 120.0, 'reps': 8},
        ]
      },
      {
        'type': 'deadlift',
        'sets': [
          {'weight': 100.0, 'reps': 10},
          {'weight': 100.0, 'reps': 10},
          {'weight': 100.0, 'reps': 10},
        ]
      },
      {
        'type': 'barbell_curl',
        'sets': [
          {'weight': 120.0, 'reps': 12},
          {'weight': 120.0, 'reps': 10},
          {'weight': 120.0, 'reps': 8},
        ]
      },
    ]
  },
};

List<Map<String, Object>?> getEventsForDay(DateTime? day) {
  return day == null
      ? []
      : events[getHashCode(day)] == null
      ? []
      : [events[getHashCode(day)]];
}

class Workout extends StatelessWidget {
  Workout({Key? key, required this.workout}) : super(key: key);

  var workout;

  Widget _noWorkout() {
    return Container(
      child: Column(
        children: [
          const Text(
            'No Workout Planned',
            style: Styles.header1,
          ),
          ElevatedButton(
            onPressed: (() {}),
            child: const Text('Plan Workout'),
          ),
        ],
      ),
    );
  }

  Widget _workoutDisplay() {
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
                    Data.workouts[exercise['type']]!['name'] as String,
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
      child: workout == null ? _noWorkout() : _workoutDisplay(),
    );
  }
}

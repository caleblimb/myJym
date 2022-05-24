import 'package:flutter/material.dart';

import '../auxiliary/styles.dart';

class WorkoutIntensity extends StatefulWidget {
  const WorkoutIntensity({Key? key}) : super(key: key);

  @override
  State<WorkoutIntensity> createState() => _WorkoutIntensityState();
}

class _WorkoutIntensityState extends State<WorkoutIntensity> {
  double restLevel = 2;
  static const restLevels = [
    {'label': 'Leisure', 'description': '~2min between workouts', 'rest': 120},
    {'label': 'Paced', 'description': '~1.5min between workouts', 'rest': 90},
    {'label': 'Dedicated', 'description': '~45s between workouts', 'rest': 45},
    {'label': 'Intense', 'description': '~30s between workouts', 'rest': 30},
    {'label': 'EXTREME', 'description': 'No rest between workouts', 'rest': 10},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(restLevels[restLevel.toInt()]['description'].toString(),
              style: Styles.header3),
          Slider(
            value: restLevel,
            onChanged: (newRest) {
              setState(() => restLevel = newRest);
            },
            min: 0,
            max: (restLevels.length - 1).toDouble(),
            divisions: restLevels.length - 1,
            label: restLevels[restLevel.toInt()]['label'].toString(),
          ),
        ],
      ),
    );
  }
}

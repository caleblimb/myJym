import 'package:flutter/material.dart';
import 'package:myjym/auxiliary/preference_manager.dart';

import '../auxiliary/styles.dart';

const workoutIntensityRestLevels = [
   {'label': 'Leisure', 'description': '~2min between workouts', 'rest': 120},
   {'label': 'Paced', 'description': '~1.5min between workouts', 'rest': 90},
   {'label': 'Dedicated', 'description': '~45s between workouts', 'rest': 45},
   {'label': 'Intense', 'description': '~30s between workouts', 'rest': 30},
   {'label': 'EXTREME', 'description': 'No rest between workouts', 'rest': 10},
];

class WorkoutIntensity extends StatefulWidget {
  const WorkoutIntensity({Key? key}) : super(key: key);

  @override
  State<WorkoutIntensity> createState() => _WorkoutIntensityState();
}

class _WorkoutIntensityState extends State<WorkoutIntensity> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(workoutIntensityRestLevels[preferenceManager.getRestLevel().toInt()]['description'].toString(),
              style: Styles.header3),
          Slider(
            value: preferenceManager.getRestLevel(),
            onChanged: (newRest){
              setState(() => preferenceManager.setRestLevel(newRest, save: false));
            },
            onChangeEnd: (newRest) {
              setState(() => preferenceManager.setRestLevel(newRest));
            },
            min: 0,
            max: (workoutIntensityRestLevels.length - 1).toDouble(),
            divisions: workoutIntensityRestLevels.length - 1,
            label: workoutIntensityRestLevels[preferenceManager.getRestLevel().toInt()]['label'].toString(),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myjym/auxiliary/preference_manager.dart';

import '../auxiliary/data.dart';
import '../auxiliary/styles.dart';

class WorkoutIntensity extends StatefulWidget {
  const WorkoutIntensity({Key? key}) : super(key: key);

  @override
  State<WorkoutIntensity> createState() => _WorkoutIntensityState();
}

class _WorkoutIntensityState extends State<WorkoutIntensity> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(workoutIntensityRestLevels[PreferenceManager.getRestLevel().toInt()]['description'].toString(),
            style: Styles.header3),
        Slider(
          value: PreferenceManager.getRestLevel(),
          onChanged: (newRest){
            setState(() => PreferenceManager.setRestLevel(newRest, save: false));
          },
          onChangeEnd: (newRest) {
            setState(() => PreferenceManager.setRestLevel(newRest));
          },
          min: 0,
          max: (workoutIntensityRestLevels.length - 1).toDouble(),
          divisions: workoutIntensityRestLevels.length - 1,
          label: workoutIntensityRestLevels[PreferenceManager.getRestLevel().toInt()]['label'].toString(),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  _WorkoutIntensityState(){
    _getPreferences();
  }

  double restLevel = 2;

  Future<void> _getPreferences() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    restLevel = prefs.getDouble('rest-level') ?? 0.0;
    setState(() {});
  }

  Future<void> _setPreferences(value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('rest-level', value );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(workoutIntensityRestLevels[restLevel.toInt()]['description'].toString(),
              style: Styles.header3),
          Slider(
            value: restLevel,
            onChanged: (newRest){
              setState(() => restLevel = newRest);
            },
            onChangeEnd: (newRest) {
              _setPreferences(newRest);
            },
            min: 0,
            max: (workoutIntensityRestLevels.length - 1).toDouble(),
            divisions: workoutIntensityRestLevels.length - 1,
            label: workoutIntensityRestLevels[restLevel.toInt()]['label'].toString(),
          ),
        ],
      ),
    );
  }
}

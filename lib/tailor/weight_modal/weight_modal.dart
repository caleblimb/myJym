import 'package:flutter/material.dart';

import '../../auxiliary/styles.dart';

class WeightModal extends StatefulWidget {
  const WeightModal({Key? key}) : super(key: key);

  @override
  State<WeightModal> createState() => _WeightModalState();
}

class _WeightModalState extends State<WeightModal> {
  static const strengthStandards = {
    'male': {
      'bench_press': {'level': 1, 'levels': [0.50,0.625,0.75,1.00,1.25,1.5,1.75,1.875,2.00]},
      'squat': {'level': 1, 'levels': [0.75,1.00,1.25,1.375,1.50,1.875,2.25,2.5,2.75]},
      'deadlift': {'level': 1, 'levels': [1.00,1.125,1.25,1.625,2.00,2.25,2.50,2.75,3.00]},
      'shoulder_press': {'level': 1, 'levels': [0.35,0.45,0.55,0.675,0.80,0.925,1.05,1.20,1.35]},
      'pull_ups': {'level': 1, 'levels': [0,1,4,8,13,18,24,30,36]},
      'dumbbell_bench_press': {'level': 1, 'levels': [0.20,0.275,0.35,0.425,0.50,0.60,0.70,0.85,0.95]},
      'dumbbel_curl': {'level': 1, 'levels': [0.10,0.125,0.15,0.225,0.30,0.375,0.45,0.55,0.65]},
      'barbell_curl': {'level': 1, 'levels': [0.20,0.30,0.40,0.50,0.60,0.725,0.85,1.00,1.15]},
      'bent_over_row': {'level': 1, 'levels': [0.50,0.625,0.75,0.875,1.00,1.25,1.50,1.625,1.75]},
      'push_ups': {'level': 1, 'levels': [0,5,16,26,40,52,68,82,100]},
      'dumbbell_shoulder_press': {'level': 1, 'levels': [0.15,0.20,0.25,0.325,0.40,0.475,0.55,1.30,0.75]},
      'front_squat': {'level': 1, 'levels': [0.75,0.875,1.00,1.125,1.25,1.50,1.75,1.875,2.00]}
    },
    'female': {
      'bench_press': {'level': 1, 'levels': [0.25,0.375,0.50,0.625,0.75,0.875,1.00,1.25,1.50]},
      'squat': {'level': 1, 'levels': [0.50,0.625,0.75,1,1.25,1.375,1.50,1.75,2.0]},
      'deadlift': {'level': 1, 'levels': [0.50,0.75,1.00,1.125,1.25,1.50,1.75,2.125,2.50]},
      'shoulder_press': {'level': 1, 'levels': [0.20,0.55,0.35,0.425,0.50,0.625,0.75,0.85,0.95]},
      'pull_ups': {'level': 1, 'levels': [0,0,0,1,6,10,14,19,24]},
      'dumbbell_bench_press': {'level': 1, 'levels': [0.10,0.15,0.20,0.25,0.30,0.40,0.50,0.60,0.70]},
      'dumbbel_curl': {'level': 1, 'levels': [0.05,0.075,0.10,0.15,0.20,0.25,0.30,0.375,0.45]},
      'barbell_curl': {'level': 1, 'levels': [0.10,0.15,0.20,0.30,0.40,0.50,0.60,0.725,0.85]},
      'bent_over_row': {'level': 1, 'levels': [0.25,0.325,0.40,0.525,0.65,0.775,0.90,1.05,1.20]},
      'push_ups': {'level': 1, 'levels': [0,1,5,10,18,25,35,44,54]},
      'dumbbell_shoulder_press': {'level': 1, 'levels': [0.10,0.125,0.15,0.20,0.25,0.30,0.35,0.40,0.45]},
      'front_squat': {'level': 1, 'levels': [0.50,0.625,0.75,0.875,1.00,1.125,1.25,1.375,1.50]}
    }
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'Strength Level',
              style: Styles.header1,
            ),
          ],
        ),
      ),
    );
  }
}

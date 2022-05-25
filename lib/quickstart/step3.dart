import 'package:flutter/material.dart';
import 'package:myjym/tailor/workout_intensity.dart';

import '../auxiliary/styles.dart';

class Step3 extends StatelessWidget {
  const Step3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: const [
        Text(
          'Workout Intensity',
          style: Styles.header1,
        ),
        WorkoutIntensity(),
      ],
    ));
  }
}

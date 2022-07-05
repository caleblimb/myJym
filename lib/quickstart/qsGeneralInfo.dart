import 'package:flutter/material.dart';
import 'package:myjym/tailor/available_equipment.dart';

import '../auxiliary/styles.dart';
import '../tailor/body_info.dart';
import '../tailor/strength_level.dart';
import '../tailor/workout_intensity.dart';

class GeneralInfo extends StatelessWidget {
  const GeneralInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: const [
          Text(
            'Basics',
            style: Styles.header1,
          ),
          BodyInfo(),
          Text(
            'Available Equipment',
            style: Styles.header1,
          ),
          AvailableEquipment(),
          Text(
            'Workout Intensity',
            style: Styles.header1,
          ),
          WorkoutIntensity(),
          StreangthLevel(),
        ],
      ),
    );
  }
}

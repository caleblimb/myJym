import 'package:flutter/material.dart';

import '../auxiliary/styles.dart';
import '../tailor/available_equipment.dart';
import '../tailor/body_info.dart';
import '../tailor/strength_level.dart';
import '../tailor/workout_intensity.dart';

class QuickStart extends StatefulWidget {
  const QuickStart({Key? key, required this.doneButtonAction})
      : super(key: key);

  final VoidCallback? doneButtonAction;

  @override
  State<QuickStart> createState() => _QuickStartState();
}

class _QuickStartState extends State<QuickStart> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Container()),
          const Text(
            'Get Started',
            style: Styles.header1,
          ),
          const Text(
            "All settings can be changed later",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
          ),
          Expanded(child: Container()),
          const Text(
            'Basics',
            style: Styles.header1,
          ),
          const BodyInfo(),
          Expanded(child: Container()),
          const Text(
            'Available Equipment',
            style: Styles.header1,
          ),
          const AvailableEquipment(),
          Expanded(child: Container()),
          const Text(
            'Workout Intensity',
            style: Styles.header1,
          ),
          const WorkoutIntensity(),
          const StreangthLevel(),
          Expanded(child: Container()),
          SizedBox(
            width: double.infinity,
            child: Container(
              margin: const EdgeInsets.only(
                left: 24,
                right: 24,
              ),
              child: ElevatedButton(
                onPressed: widget.doneButtonAction,
                child: const Text(
                  "Done",
                ),
              ),
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}

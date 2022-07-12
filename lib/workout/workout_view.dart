import 'package:flutter/material.dart';
import 'package:myjym/workout/workout_interactive.dart';

import 'quickstart.dart';
import '../auxiliary/preference_manager.dart';

class WorkoutView extends StatefulWidget {
  const WorkoutView({Key? key}) : super(key: key);

  @override
  State<WorkoutView> createState() => _WorkoutViewState();
}

class _WorkoutViewState extends State<WorkoutView> {
  @override
  Widget build(BuildContext context) {
    if (!PreferenceManager.getSetup()) {
      return QuickStart(
        doneButtonAction: () {
          PreferenceManager.setSetup(true);
          setState(() {});
        }
      );
    } else {
      return Container(
        child: Column(
          children: [
            WorkoutInteractive(
              day: DateTime.now(),
            ),
          ],
        ),
      );
    }
  }
}

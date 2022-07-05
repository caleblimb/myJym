import 'package:flutter/material.dart';
import 'package:myjym/workout/deprecated_workout.dart';
import 'package:myjym/workout/interactive_page_view_workout.dart';

import '../auxiliary/modal.dart';
import '../quickstart/quickstart.dart';
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
      return Container(
        child: Column(
          children: [
            Container(
              child: const Image(
                image: AssetImage('assets/ui/myJym.png'),
              ),
              margin: const EdgeInsets.all(16),
            ),
            SizedBox(
              width: double.infinity,
              height: 64,
              child: ElevatedButton(
                onPressed: () async {
                  await Modal.open(
                    context: context,
                    child: const QuickStart(),
                  );
                  setState(() {});
                },
                child: const Text("Get Started"),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        child: Column(
          children: [
            Container(
              child: const Image(
                image: AssetImage('assets/ui/myJym.png'),
              ),
              margin: const EdgeInsets.all(16),
            ),
            // Flexible(
            //   child: SingleChildScrollView(
            //     child: InteractivePageViewWorkout(
            //       day: DateTime.now(),
            //     ),
            //   ),
            // ),
            InteractivePageViewWorkout(
              day: DateTime.now(),
            ),
          ],
        ),
      );
    }
  }
}

// class WorkoutView extends StatelessWidget {
//   const WorkoutView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//   }
// }

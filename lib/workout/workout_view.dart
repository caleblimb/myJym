import 'package:flutter/material.dart';
import 'package:myjym/workout/workout.dart';

import '../auxiliary/modal.dart';
import '../quickstart/quickstart.dart';
import '../auxiliary/preference_manager.dart';

class WorkoutView extends StatelessWidget {
  const WorkoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(!PreferenceManager.getSetup())
      {
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
                    Modal.open(
                      context: context,
                      child: const QuickStart(),
                    );
                    (context as Element).markNeedsBuild();
                  },
                  child: const Text("Get Started"),
                ),
              ),
              Workout(
                day: DateTime.now(),
              ),
            ],
          ),
        );
      }
    else{
      return Container(
        child: Column(
          children: [
            Container(
              child: const Image(
                image: AssetImage('assets/ui/myJym.png'),
              ),
              margin: const EdgeInsets.all(16),
            ),
            Workout(
              day: DateTime.now(),
            ),
          ],
        ),
      );
    }

  }
}

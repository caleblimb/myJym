import 'package:flutter/material.dart';

import '../auxiliary/data.dart';
import '../auxiliary/styles.dart';

class Instruction extends StatelessWidget {
  const Instruction({Key? key, required this.exercise}) : super(key: key);

  final Exercise exercise;

  static final Map<Object, Map<String, Object>> exerciseInstructions = {
    Exercise.benchPress: {
      'title': 'Bench Press',
      'tips': [
        'Lay back flat down on bench',
        'Place feet on ground',
        'Put both arms up at the same time because we like to party a lot',
        'Don\'t over exert yourself',
      ],
    },
    Exercise.squat: {
      'title': 'Squat',
      'tips': [
        'Rest bar on shoulders',
        'Place feet same distance as shoulders',
        'Place hands on bar about a foot away from shoulders',
        'Don\'t over exert yourself',
      ],
    },
    Exercise.deadLift: {
      'title': 'Deadlift',
      'tips': [
        'Keep back straight',
        'Pop chest out',
        'Bend your knees',
        'Don\'t over exert yourself',
      ],
    },
    Exercise.shoulderPress: {
      'title': 'Shoulder Press',
      'tips': [
        'Rest bar front of shoulders',
        'Place feet same distance as shoulders',
        'Place hands on bar about a foot away from shoulders',
        'Don\'t over exert yourself',
      ],
    },
    Exercise.pullUps: {
      'title': 'Pull-Up',
      'tips': [
        'Rest bar on shoulders',
        'Place feet same distance as shoulders',
        'Place hands on bar about a foot away from shoulders',
        'Don\'t over exert yourself',
      ],
    },
    Exercise.dumbbellBenchPress: {
      'title': 'Dumbbell Bench Press',
      'tips': [
        'Rest bar on shoulders',
        'Place feet same distance as shoulders',
        'Place hands on bar about a foot away from shoulders',
        'Don\'t over exert yourself',
      ],
    },
    Exercise.dumbbellCurl: {
      'title': 'Dumbbell Curl',
      'tips': [
        'Rest bar on shoulders',
        'Place feet same distance as shoulders',
        'Place hands on bar about a foot away from shoulders',
        'Don\'t over exert yourself',
      ],
    },
    Exercise.barbellCurl: {
      'title': 'Barbell Curl',
      'tips': [
        'Keep back straight',
        'Place feet shoulder distance',
        'Don\'t rock with barbell; Use LESS weight',
        'Don\'t over exert yourself',
      ],
    },
    Exercise.bentOverRow: {
      'title': 'BentOver Row',
      'tips': [
        'Rest bar on shoulders',
        'Place feet same distance as shoulders',
        'Place hands on bar about a foot away from shoulders',
        'Don\'t over exert yourself',
      ],
    },
    Exercise.pushUps: {
      'title': 'Push-Up',
      'tips': [
        'Rest bar on shoulders',
        'Place feet same distance as shoulders',
        'Place hands on bar about a foot away from shoulders',
        'Don\'t over exert yourself',
      ],
    },
    Exercise.dumbbellShoulderPress: {
      'title': 'Dumbbell Shoulder Press',
      'tips': [
        'Rest bar on shoulders',
        'Place feet same distance as shoulders',
        'Place hands on bar about a foot away from shoulders',
        'Don\'t over exert yourself',
      ],
    },
    Exercise.frontSquat: {
      'title': 'Front Squat',
      'tips': [
        'Rest bar on shoulders',
        'Place feet same distance as shoulders',
        'Place hands on bar about a foot away from shoulders',
        'Don\'t over exert yourself',
      ],
    },
  };

  static Widget exerciseTips({required exerciseType, TextStyle? textStyle, double? iconTop}) {
    return Column(
      children: [
        ...(exerciseInstructions[exerciseType]!['tips'] as List<String>).map(
          (tip) {
            return Stack(children: [
              Positioned(
                top: iconTop ?? 2,
                left: 0,
                child: const Icon(Icons.task_alt),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                      child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                    child: Text(
                      tip,
                      style: textStyle ?? const TextStyle(),
                    ),
                  )),
                ],
              ),
            ]);
          },
        ).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              exerciseInstructions[exercise]!['title'] as String,
              style: Styles.header1,
            ),
            Container(
              padding: const EdgeInsets.all(30),
              child: exerciseTips(exerciseType: exercise),
            ),
          ],
        ));
  }
}

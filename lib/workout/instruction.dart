import 'package:flutter/material.dart';

import '../auxiliary/data.dart';
import '../auxiliary/styles.dart';

class Instruction extends StatelessWidget {
  const Instruction({Key? key, required this.exercise}) : super(key: key);

  final Exercise exercise;

  static Widget exerciseTips(
      {required exerciseType, TextStyle? textStyle, double? iconTop}) {
    return Column(
      children: [
        ...(Data.exerciseInstructions[exerciseType]!['tips'] as List<String>)
            .map(
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
              Data.exerciseInstructions[exercise]!['title'] as String,
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

import 'package:flutter/material.dart';

import '../auxiliary/data.dart';

class Instruction extends StatelessWidget {
  Instruction({Key? key, required this.exercise}) : super(key: key);

  final exercise;

  final instructions = {
    Exercise.benchPress: 'Do a bench press',
    Exercise.squat: 'Have fun squatting',
  };


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(instructions[exercise].toString(),),
    );
  }
}

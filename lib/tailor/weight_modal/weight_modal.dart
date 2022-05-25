import 'dart:core';

import 'package:flutter/material.dart';
import 'package:myjym/tailor/body_info.dart';

import '../../auxiliary/data.dart';
import '../../auxiliary/styles.dart';

class WeightModal extends StatefulWidget {
  const WeightModal({Key? key}) : super(key: key);

  @override
  State<WeightModal> createState() => _WeightModalState();
}

class _WeightModalState extends State<WeightModal> {
  final List<double> _strengthLevels =
      List.filled(Data.workouts.length, 1.0);

  List<Widget> _exercises() {
    List<Widget> _exercises = [];
    Data.workouts.forEach((key, value) {
      _exercises.add(
        Column(
          children: [
            Text(
              value['name'] as String,
              style: Styles.header3,
            ),
            Text(
              'Strength Level: ' +
                  Data.strengthLevels[_strengthLevels[value['index'] as int]
                          .toInt()]['label']
                      .toString(),
            ),
            Text((value['units'] as String) +
                ': ' +
                ((value['male_levels'] as List<double>)[
                        _strengthLevels[value['index'] as int].toInt()])
                    .toString() + 'x'),
            Slider(
              value: _strengthLevels[value['index'] as int],
              onChanged: (newLevel) {
                setState(
                    () => _strengthLevels[value['index'] as int] = newLevel);
              },
              min: 0,
              max: (Data.strengthLevels.length - 1).toDouble(),
              divisions: Data.strengthLevels.length - 1,
              label: Data.strengthLevels[
                      _strengthLevels[value['index'] as int].toInt()]['label']
                  .toString(),
            )
          ],
        ),
      );
    });
    return _exercises;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'Weight Class',
              style: Styles.header1,
            ),
            const BodyInfo(),
            const Text('Maximum Repetition', style: Styles.header2,),
            Column(
              children: _exercises(),
            ),
          ],
        ),
      ),
    );
  }
}

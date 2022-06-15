import 'dart:core';

import 'package:flutter/material.dart';
import 'package:myjym/tailor/body_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auxiliary/data.dart';
import '../../auxiliary/styles.dart';

class WeightModal extends StatefulWidget {
  const WeightModal({Key? key}) : super(key: key);

  @override
  State<WeightModal> createState() => _WeightModalState();
}

class _WeightModalState extends State<WeightModal> {
  List<double> _strengthLevels =
      List.filled(Data.exerciseInfo.length, 0.0);

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  /* * * * * * * * * * * * * * * * * * * * * * * *
  * Set the preferences on change
  * * * * * * * * * * * * * * * * * * * * * * * */
  Future <void> _setPreference(key, value)async {
    final prefs = await _prefs;
    await prefs.setDouble(key, value);
  }

  /* * * * * * * * * * * * * * * * * * * * * * * *
  * Get the preferences from the app shared preference
  * Set _strengthLevels value from default
  * * * * * * * * * * * * * * * * * * * * * * * */
  Future <void> _getPreference(index, key) async{
    final prefs = await _prefs;
    _strengthLevels[index] = await prefs.getDouble(key) ?? 0.0;
    setState(() {
    });
  }

  List<Widget> _exercises() {
    List<Widget> _exercises = [];
    Data.exerciseInfo.forEach((key, value) {
      _getPreference(value['index'], value['key']);
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
            Text(((value['male_levels'] as List<double>)[
                        _strengthLevels[value['index'] as int].toInt()])
                    .toString() + 'x'),
            Slider(
              // value: _getPreference(value['key'])/*_strengthLevels[value['index'] as int]*/,
              value: _strengthLevels[value['index'] as int],
              // onChanged: (newLevel) {
              //   _setPreference(value['key'], newLevel);
              //   setState(
              //       () => _strengthLevels[value['index'] as int] = newLevel
              //   );
              // },
              onChanged: (newLevel){
                setState(() => _strengthLevels[value['index'] as int] = newLevel);
              },
              onChangeEnd: (newLevel) {
                _setPreference(value['key'], newLevel);
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

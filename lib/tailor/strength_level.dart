import 'package:flutter/material.dart';
import 'package:myjym/auxiliary/preference_manager.dart';
import '../auxiliary/data.dart';

import '../auxiliary/styles.dart';

class StreangthLevel extends StatefulWidget {
  const StreangthLevel({Key? key}) : super(key: key);

  @override
  State<StreangthLevel> createState() => _StreangthLevelState();
}

class _StreangthLevelState extends State<StreangthLevel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Strength Level: ' +
              Data.strengthLevels[PreferenceManager.getStrengthLevel().toInt()]
                      ['label']
                  .toString(),
          style: Styles.header3,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Slider(
                value: PreferenceManager.getStrengthLevel(),
                onChanged: (newWeight) {
                  setState(() => PreferenceManager.setStrengthLevel(newWeight));
                },
                min: 0,
                max: (Data.strengthLevels.length - 1).toDouble(),
                divisions: Data.strengthLevels.length - 1,
                label: Data.strengthLevels[
                        PreferenceManager.getStrengthLevel().toInt()]['label']
                    .toString(),
              ),
            ),
            // IconButton(
            //   onPressed: () {
            //     Modal.open(context: context, child: const WeightModal());
            //   },
            //   icon: const Icon(Icons.tune),
            // ),
          ],
        ),
      ],
    );
  }
}

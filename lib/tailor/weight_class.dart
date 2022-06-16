import 'package:flutter/material.dart';
import 'package:myjym/auxiliary/preference_manager.dart';
import 'package:myjym/tailor/body_info.dart';

import '../auxiliary/data.dart';
import '../auxiliary/styles.dart';

class WeightClass extends StatefulWidget {
  const WeightClass({Key? key}) : super(key: key);

  @override
  State<WeightClass> createState() => _WeightClassState();
}

class _WeightClassState extends State<WeightClass> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const BodyInfo(),
          Text(
            'Strength Level: ' +
                Data.strengthLevels[preferenceManager.getStrengthLevel().toInt()]['label'].toString(),
            style: Styles.header3,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Slider(
                  value: preferenceManager.getStrengthLevel(),
                  onChanged: (newWeight) {
                    setState(() => preferenceManager.setStrengthLevel(newWeight));
                  },
                  min: 0,
                  max: (Data.strengthLevels.length - 1).toDouble(),
                  divisions: Data.strengthLevels.length - 1,
                  label: Data.strengthLevels[preferenceManager.getStrengthLevel().toInt()]['label']
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
      ),
    );
  }
}

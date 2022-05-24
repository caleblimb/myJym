import 'package:flutter/material.dart';
import 'package:myjym/tailor/body_info.dart';
import 'package:myjym/tailor/weight_modal/weight_modal.dart';

import '../auxiliary/data.dart';
import '../auxiliary/modal.dart';
import '../auxiliary/styles.dart';

class WeightClass extends StatefulWidget {
  const WeightClass({Key? key}) : super(key: key);

  @override
  State<WeightClass> createState() => _WeightClassState();
}

class _WeightClassState extends State<WeightClass> {
  double _strengthLevel = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const BodyInfo(),
          Text(
            'Strength Level: ' +
                Data.strengthLevels[_strengthLevel.toInt()]['label'].toString(),
            style: Styles.header3,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Slider(
                  value: _strengthLevel,
                  onChanged: (newWeight) {
                    setState(() => _strengthLevel = newWeight);
                  },
                  min: 0,
                  max: (Data.strengthLevels.length - 1).toDouble(),
                  divisions: Data.strengthLevels.length - 1,
                  label: Data.strengthLevels[_strengthLevel.toInt()]['label']
                      .toString(),
                ),
              ),
              IconButton(
                onPressed: () {
                  Modal.open(context: context, child: const WeightModal());
                },
                icon: const Icon(Icons.tune),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

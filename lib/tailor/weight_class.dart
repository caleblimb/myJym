import 'package:flutter/material.dart';
import 'package:myjym/tailor/weight_modal/weight_modal.dart';

import '../auxiliary/modal.dart';
import '../auxiliary/styles.dart';

class WeightClass extends StatefulWidget {
  const WeightClass({Key? key}) : super(key: key);

  @override
  State<WeightClass> createState() => _WeightClassState();
}

class _WeightClassState extends State<WeightClass> {
  double weightLevel = 0;

  static const weightLevels = [
    {'label': 'Beginner'},
    {'label': 'Beginner-Novice'},
    {'label': 'Novice'},
    {'label': 'Novice-Intermediate'},
    {'label': 'Intermediate'},
    {'label': 'Intermediate-Advanced'},
    {'label': 'Advanced'},
    {'label': 'Advanced-Elite'},
    {'label': 'Elite'}
  ];

  // 0 = Male, 1 = Female
  int _gender = 0;

  Widget _icon(int index, {required String text, required IconData iconData}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkResponse(
        child: Row(
          children: [
            Icon(
              iconData,
              color: _gender == index ? Styles.orange : null,
            ),
            Text(
              text,
              style: TextStyle(color: _gender == index ? Styles.orange : null),
            ),
          ],
        ),
        onTap: () => setState(
          () {
            _gender = index;
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Text(
            'Gender',
            style: Styles.header3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _icon(0, text: 'Male', iconData: Icons.male),
              _icon(1, text: 'Female', iconData: Icons.female),
            ],
          ),
          Text(
            'Strength Level: ' +
                weightLevels[weightLevel.toInt()]['label'].toString(),
            style: Styles.header3,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Slider(
                  value: weightLevel,
                  onChanged: (newWeight) {
                    setState(() => weightLevel = newWeight);
                  },
                  min: 0,
                  max: (weightLevels.length - 1).toDouble(),
                  divisions: weightLevels.length - 1,
                  label: weightLevels[weightLevel.toInt()]['label'].toString(),
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

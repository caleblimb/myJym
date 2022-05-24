import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import '../auxiliary/styles.dart';

class BodyInfo extends StatefulWidget {
  const BodyInfo({Key? key}) : super(key: key);

  @override
  State<BodyInfo> createState() => _BodyInfoState();
}

class _BodyInfoState extends State<BodyInfo> {
  // 0 = Male, 1 = Female
  int _gender = 0;
  int _weight = 100;
  var unitTypes = ['lbs', 'kg'];
  var units = 0;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Gender:',
                style: Styles.header3,
              ),
              _icon(0, text: 'Male', iconData: Icons.male),
              _icon(1, text: 'Female', iconData: Icons.female),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Weight:',
                style: Styles.header3,
              ),
              NumberPicker(
                axis: Axis.horizontal,
                itemWidth: 46,
                value: _weight,
                minValue: 0,
                maxValue: 300,
                step: 1,
                onChanged: (newWeight) {
                  setState(() => _weight = newWeight);
                },
              ),
              InkResponse(
                child: Text(
                  unitTypes[units],
                  style: const TextStyle(color: Styles.orange, fontSize: 24),
                ),
                onTap: () => setState(
                  () {
                    units = units == 0 ? 1 : 0;
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

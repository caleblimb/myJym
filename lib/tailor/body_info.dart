import 'package:flutter/material.dart';
import 'package:myjym/auxiliary/preference_manager.dart';
import 'package:numberpicker/numberpicker.dart';

import '../auxiliary/styles.dart';

class BodyInfo extends StatefulWidget {
  const BodyInfo({Key? key}) : super(key: key);

  @override
  State<BodyInfo> createState() => _BodyInfoState();
}

class _BodyInfoState extends State<BodyInfo> {
  Widget _icon(int index, {required String text, required IconData iconData}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkResponse(
        child: Row(
          children: [
            Icon(
              iconData,
              color:
                  preferenceManager.getGender() == index ? Styles.orange : null,
            ),
            Text(
              text,
              style: TextStyle(
                  color: preferenceManager.getGender() == index
                      ? Styles.orange
                      : null),
            ),
          ],
        ),
        onTap: () => setState(
          () {
            preferenceManager.setGender(index);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //_getPreferences();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Gender:',
              style: Styles.header3,
            ),
            _icon(0, text: 'Female', iconData: Icons.female),
            _icon(1, text: 'Male', iconData: Icons.male),
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
              value: preferenceManager.getWeight(),
              minValue: 0,
              maxValue: 300,
              step: 1,
              onChanged: (newWeight) {
                setState(() => preferenceManager.setWeight(newWeight));
              },
            ),
            InkResponse(
              child: Text(
                preferenceManager.getUnitTypes()[preferenceManager.getUnits()],
                style: const TextStyle(color: Styles.orange, fontSize: 24),
              ),
              onTap: () => setState(
                () {
                  preferenceManager
                      .setUnits(preferenceManager.getUnits() == 0 ? 1 : 0);
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}

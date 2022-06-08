import 'package:flutter/material.dart';
import 'package:myjym/auxiliary/data.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auxiliary/styles.dart';

class BodyInfo extends StatefulWidget {
  const BodyInfo({Key? key}) : super(key: key);

  @override
  State<BodyInfo> createState() => _BodyInfoState();
}

class _BodyInfoState extends State<BodyInfo> {
  // 0 = Female, 1 = Male
  int _gender = 0;
  int _weight = 100;
  var unitTypes = ['lbs', 'kg'];
  var units = Units.lbs.index;

  _BodyInfoState(){
    _getPreferences();
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> _getPreferences() async{
    final prefs = await _prefs;
    _gender = prefs.getInt('gender') ?? 0;
    _weight = prefs.getInt('weight') ?? 100;
    units = prefs.getInt('units') ?? Units.lbs.index;
    setState(() {});
  }

  Future<void> _setPreferences(key, value) async{
    final prefs = await _prefs;
    prefs.setInt(key, value);
    setState(() {
      _getPreferences();
    });
  }

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
        onTap:
            () => setState(
          () {
            _gender = index;
            _setPreferences('gender', index);
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
              value: _weight,
              minValue: 0,
              maxValue: 300,
              step: 1,
              onChanged: (newWeight) {
                _setPreferences('weight', newWeight);
                // setState(() => _weight = newWeight);
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
                  _setPreferences('units', units);
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}

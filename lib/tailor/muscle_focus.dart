import 'package:flutter/material.dart';

import '../auxiliary/styles.dart';

class MuscleFocus extends StatefulWidget {
  const MuscleFocus({Key? key}) : super(key: key);

  @override
  State<MuscleFocus> createState() => _MuscleFocusState();
}

class _MuscleFocusState extends State<MuscleFocus> {
  var focusCategories = {
    'legs': {'label': 'Legs', 'level': 1.0},
    'core': {'label': 'Core', 'level': 1.0},
    'torso': {'label': 'Torso', 'level': 1.0},
  };
  static const focusLevels = ["None", "Occasional", "Regular", "Focused"];

  Widget _muscleFocus({required String category}) {
    return Expanded(
      child: Column(
        children: [
          Text(
            focusCategories[category]!["label"] as String,
            style: Styles.header3,
          ),
          SizedBox(
            height: 128.0,
            child: RotatedBox(
              quarterTurns: 3,
              child: Slider(
                value: focusCategories[category]!["level"] as double,
                onChanged: (newFocus) {
                  setState(
                      () => focusCategories[category]!["level"] = newFocus);
                },
                min: 0,
                max: focusLevels.length - 1,
                divisions: focusLevels.length - 1,
              ),
            ),
          ),
          Text(focusLevels[
              (focusCategories[category]!["level"] as double).toInt()]),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          _muscleFocus(category: 'legs'),
          _muscleFocus(category: 'core'),
          _muscleFocus(category: 'torso'),
        ],
      ),
    );
  }
}

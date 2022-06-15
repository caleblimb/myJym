import 'package:flutter/material.dart';
import 'package:myjym/tailor/body_info.dart';
import 'package:myjym/tailor/weight_modal/weight_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  _WeightClassState(){
    _getPreferences();
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> _getPreferences() async{
    var prefs = await _prefs;
    _strengthLevel = prefs.getDouble('strength-level') ?? 0.0;
    setState(() {

    });
  }

  Future<void> _setPreferences(value) async{
    var prefs = await _prefs;
    prefs.setDouble('strength-level', value);
  }

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
                  onChanged: (newRest){
                    setState(() => _strengthLevel = newRest);
                  },
                  onChangeEnd: (newRest) {
                    _setPreferences(newRest);
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

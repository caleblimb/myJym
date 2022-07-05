import 'package:flutter/material.dart';
import 'package:myjym/auxiliary/data.dart';
import 'package:myjym/auxiliary/preference_manager.dart';
import '../auxiliary/styles.dart';

class AvailableEquipment extends StatefulWidget {
  const AvailableEquipment({Key? key}) : super(key: key);

  @override
  State<AvailableEquipment> createState() => _AvailableEquipmentState();
}

class _AvailableEquipmentState extends State<AvailableEquipment> {
  Widget _icon(int index, {required String text, required IconData iconData}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: InkResponse(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                iconData,
                color: PreferenceManager.getEquipmentLevel() == EquipmentLevel.values[index] ? Styles.orange : null,
              ),
              Text(
                text,
                style: TextStyle(
                    color: PreferenceManager.getEquipmentLevel() == EquipmentLevel.values[index] ? Styles.orange : null),
              ),
            ],
          ),
          onTap: () => setState(
            () {
              PreferenceManager.setEquipmentLevel(index);
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          _icon(0, text: 'None', iconData: Icons.grass),
          _icon(1, text: 'Basic', iconData: Icons.house),
          _icon(2, text: 'Gym', iconData: Icons.store),
        ],
      ),
    );
  }
}

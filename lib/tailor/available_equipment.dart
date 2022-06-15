import 'package:flutter/material.dart';
import 'package:myjym/auxiliary/data.dart';
import 'package:myjym/tailor/equipment_modal/equipment_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auxiliary/modal.dart';
import '../auxiliary/styles.dart';

class AvailableEquipment extends StatefulWidget {
  const AvailableEquipment({Key? key}) : super(key: key);

  @override
  State<AvailableEquipment> createState() => _AvailableEquipmentState();
}

class _AvailableEquipmentState extends State<AvailableEquipment> {
  EquipmentLevels _equipmentSelected = EquipmentLevels.none;


  _AvailableEquipmentState(){
    _getPreferences();
  }
  Future<void> _getPreferences() async{
    final prefs = await SharedPreferences.getInstance();
    int SelectedEquip = prefs.getInt('EquipmentLevels') ?? 0;
    _equipmentSelected = EquipmentLevels.values[SelectedEquip];
    setState(() {

    });
  }

  Future<void> _setPreferences(value) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('EquipmentLevels', value);
  }

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
                color: _equipmentSelected == EquipmentLevels.values[index] ? Styles.orange : null,
              ),
              Text(
                text,
                style: TextStyle(
                    color: _equipmentSelected == EquipmentLevels.values[index] ? Styles.orange : null),
              ),
            ],
          ),
          onTap: () => setState(
            () {
              _setPreferences(index);
              _equipmentSelected = EquipmentLevels.values[index];
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

import 'package:flutter/material.dart';
import 'package:myjym/tailor/equipment_modal/equipment_modal.dart';

import '../auxiliary/modal.dart';
import '../auxiliary/styles.dart';

class AvailableEquipment extends StatefulWidget {
  const AvailableEquipment({Key? key}) : super(key: key);

  @override
  State<AvailableEquipment> createState() => _AvailableEquipmentState();
}

class _AvailableEquipmentState extends State<AvailableEquipment> {
  int _equipmentSelected = 0;

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
                color: _equipmentSelected == index ? Styles.orange : null,
              ),
              Text(
                text,
                style: TextStyle(
                    color: _equipmentSelected == index ? Styles.orange : null),
              ),
            ],
          ),
          onTap: () => setState(
            () {
              _equipmentSelected = index;
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
          _icon(3, text: 'Full', iconData: Icons.location_city),
          Expanded(
            child: IconButton(
              onPressed: () {
                Modal.open(context: context, child: const EquipmentModal());
              },
              icon: const Icon(Icons.tune),
            ),
          ),
        ],
      ),
    );
  }
}

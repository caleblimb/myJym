import 'package:flutter/material.dart';
import 'package:myjym/tailor/available_equipment.dart';

import '../auxiliary/styles.dart';

class Step2 extends StatelessWidget {
  const Step2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: const [
          Text(
            'Available Equipment',
            style: Styles.header1,
          ),
          AvailableEquipment(),
        ],
      ),
    );
  }
}

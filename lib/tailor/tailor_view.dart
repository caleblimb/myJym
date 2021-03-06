import 'package:flutter/material.dart';
import 'package:myjym/tailor/available_equipment.dart';
import 'package:myjym/tailor/ex_im_modal/ex_im_buttons.dart';
import 'package:myjym/tailor/weight_class.dart';
import 'package:myjym/tailor/workout_intensity.dart';

import '../auxiliary/styles.dart';

class TailorView extends StatelessWidget {
  const TailorView({Key? key}) : super(key: key);

  Widget _section({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: Column(
        children: [
          Text(
            title,
            style: Styles.header2,
          ),
          child,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _section(
                  title: 'Available Equipment',
                  child: const AvailableEquipment()),
              Styles.horizontalRule(),
              _section(
                  title: 'Workout Intensity', child: const WorkoutIntensity()),
              Styles.horizontalRule(),
              _section(title: 'Weight Class', child: const WeightClass()),
              Styles.horizontalRule(),
              _section(
                  title: 'Export/Import Preferences',
                  child: const ExImButtons()),
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:myjym/tailor/body_info.dart';
import 'package:myjym/tailor/strength_level.dart';

class WeightClass extends StatefulWidget {
  const WeightClass({Key? key}) : super(key: key);

  @override
  State<WeightClass> createState() => _WeightClassState();
}

class _WeightClassState extends State<WeightClass> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const BodyInfo(),
          const StreangthLevel()
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'calendar.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: const [
          Calendar(),
        ],
      ),
    );
  }
}

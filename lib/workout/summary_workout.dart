import 'package:flutter/material.dart';
import 'package:myjym/workout/plan_workout.dart';

import '../auxiliary/modal.dart';
import '../auxiliary/preference_manager.dart';
import '../auxiliary/styles.dart';

class SummaryWorkout extends StatefulWidget {
  const SummaryWorkout({Key? key, required this.day}) : super(key: key);
  final DateTime? day;

  static const _backgroundColor = Colors.white;
  static const _margin = EdgeInsets.fromLTRB(8, 4, 8, 4);
  static const _padding = EdgeInsets.fromLTRB(8, 4, 8, 4);
  static const _borderRadius = BorderRadius.all(Radius.circular(20));
  static final _border = Border.all(
    width: 2,
    color: Styles.brown,
  );

  @override
  State<SummaryWorkout> createState() => _SummaryWorkoutState();
}

class _SummaryWorkoutState extends State<SummaryWorkout> {

  Widget _noWorkout({required context}) {
    return Container(
      child: Column(
        children: [
          const Text(
            'No Workout Planned',
            style: Styles.header1,
          ),
          ElevatedButton(
            onPressed: () async {
              await Modal.open(
                  context: context, child: PlanWorkout(date: widget.day!));
              setState(() {});
            },
            child: const Text('Plan Workout'),
          ),
        ],
      ),
    );
  }

  Widget _card({required child}) {
    return Container(
        margin: SummaryWorkout._margin,
        padding: SummaryWorkout._padding,
        decoration: BoxDecoration(
          color: SummaryWorkout._backgroundColor,
          borderRadius: SummaryWorkout._borderRadius,
          border: SummaryWorkout._border,
        ),
        child: child);
  }

  Widget _workoutDisplay({required workout, required context}) {
    return _card(child:
        Column(
          children: [
            Text(
              workout['name'] as String,
              style: Styles.header1,
            ),
          ],
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        child: widget.day == null
            ? const Text(
          'No day selected',
          style: Styles.header1,
        )
            : PreferenceManager.getWorkout(widget.day).isNotEmpty
            ? _workoutDisplay(
            workout: PreferenceManager.getWorkout(widget.day)[0]
            as Map<String, dynamic>,
            context: context)
            : _noWorkout(context: context));
  }
}

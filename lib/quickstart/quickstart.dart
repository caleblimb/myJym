import 'package:flutter/material.dart';
import 'package:myjym/auxiliary/styles.dart';
import 'package:myjym/quickstart/step1.dart';
import 'package:myjym/quickstart/step2.dart';
import 'package:myjym/quickstart/step3.dart';

class QuickStart extends StatefulWidget {
  const QuickStart({Key? key}) : super(key: key);

  @override
  State<QuickStart> createState() => _QuickStartState();
}

class _QuickStartState extends State<QuickStart> {
  static final _views = [const Step1(), const Step2(), const Step3()];
  var currentStep = 0;
  var currentView = _views[0];

  void _nextView() {
    setState(() {
      currentStep += 1;
      currentView = _views[currentStep];
    });
  }

  void _previousView() {
    setState(() {
      currentStep -= 1;
      currentView = _views[currentStep];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: const Image(
              image: AssetImage('assets/ui/myJym.png'),
            ),
            margin: const EdgeInsets.all(16),
          ),
          // Styles.horizontalRule,
          Expanded(child: currentView),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(32, 8, 32, 8),
                  child: currentStep == 0
                      ? null
                      : ElevatedButton(
                          onPressed: () => _previousView(),
                          child: const Text('Back'),
                        ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(32, 8, 32, 8),
                  child: currentStep == _views.length - 1
                      ? ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Done'),
                        )
                      : ElevatedButton(
                          onPressed: () => _nextView(),
                          child: const Text('Next'),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

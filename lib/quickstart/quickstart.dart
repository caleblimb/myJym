import 'package:flutter/material.dart';
import 'package:myjym/auxiliary/preference_manager.dart';
import 'package:myjym/quickstart/qsInstructions.dart';
import 'package:myjym/quickstart/qsGeneralInfo.dart';
class QuickStart extends StatefulWidget {
  const QuickStart({Key? key}) : super(key: key);

  @override
  State<QuickStart> createState() => _QuickStartState();
}

class _QuickStartState extends State<QuickStart> {
  // static final _views = [const Step1(), const Step2(), const Step3()];
  // var currentStep = 0;
  // var currentView = _views[0];

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
          Container(
            child: Instructions(),
          ),
          Container(
            child: GeneralInfo(),
          ),
          ElevatedButton(
              onPressed: (){
            PreferenceManager.setSetup(true);
            Navigator.pop(context);
          },
              child: Text("Done")
          ),
        ],
      ),
    );
  }
}

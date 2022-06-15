import 'package:flutter/material.dart';
import 'package:myjym/schedule/schedule_view.dart';
import 'package:myjym/tailor/tailor_view.dart';
import 'workout/workout_view.dart';

import 'auxiliary/bottom_bar.dart';
import 'auxiliary/styles.dart';

void main() {
  runApp(const MyApp());
//  hard code data into preference file if it doesn't already exist here

//Make sure to check if preferences exist
//if it doesn't, then write out the default similar as shown below
//for example
//final SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setInt('weight', 100);
//
//all this is only good to avoid an error down the road
// as long as ever shared preferences has a '?? default value'
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'myJym',
      theme: ThemeData(
        primarySwatch: Styles.materialOrange,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final _views = [
    {'title': 'Tailor Workout', 'content': const TailorView()},
    {'title': 'Today\'s Workout', 'content': const WorkoutView()},
    {'title': 'Workout Schedule', 'content': const ScheduleView()},
  ];
  var currentView = _views[1];

  void _changeView(int index) {
    setState(() {
      currentView = _views[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentView['title'] as String),
      ),
      body: Center(
        child: Container(
          child: currentView['content'] as StatelessWidget,
          margin: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(
        action: _changeView,
      ),
    );
  }
}

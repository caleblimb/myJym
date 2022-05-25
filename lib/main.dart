import 'package:flutter/material.dart';
import 'package:myjym/schedule/schedule_view.dart';
import 'package:myjym/tailor/tailor_view.dart';
import 'package:myjym/workout/workout_view.dart';

import 'auxiliary/bottom_bar.dart';
import 'auxiliary/styles.dart';

void main() {
  runApp(const MyApp());
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
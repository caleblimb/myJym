import 'package:flutter/material.dart';
import 'package:myjym/auxiliary/preference_manager.dart';
import 'package:myjym/schedule/schedule_view.dart';
import 'package:myjym/tailor/tailor_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'workout/workout_view.dart';

import 'auxiliary/bottom_bar.dart';
import 'auxiliary/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();
  await PreferenceManager.getPreferences(prefs);

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
        actions: [
          Container(
            padding: const EdgeInsets.all(10),
            child: const Image(
              image: AssetImage('assets/ui/myJym_outlined.png'),
            ),
          ),
        ],
      ),
      body: currentView['content'] as Widget,

      bottomNavigationBar: BottomBar(
        action: _changeView,
      ),
    );
  }
}

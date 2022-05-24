import 'package:flutter/material.dart';
import 'package:myjym/auxiliary/styles.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key, required this.action}) : super(key: key);

  final Function(int) action;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 1;

  final double _iconSize = 50.0;

  BottomNavigationBarItem _item({required IconData iconData}) {
    return BottomNavigationBarItem(
      icon: Icon(
        iconData,
        size: _iconSize,
      ),
      label: '',
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      widget.action(_selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        _item(iconData: Icons.design_services),
        _item(iconData: Icons.fitness_center),
        _item(iconData: Icons.calendar_month),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Styles.orange,
      unselectedItemColor: Styles.brown,
      onTap: _onItemTapped,
      selectedFontSize: 0,
      unselectedFontSize: 0,
    );
  }
}

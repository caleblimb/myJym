import 'package:flutter/material.dart';

import '../auxiliary/styles.dart';

class CategorySelect extends StatefulWidget {
  const CategorySelect({Key? key}) : super(key: key);

  @override
  State<CategorySelect> createState() => _CategorySelectState();
}

class _CategorySelectState extends State<CategorySelect> {
  int _itemSelected = 0;

  Widget _icon(int index, {required String text, required IconData iconData}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: InkResponse(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                iconData,
                color: _itemSelected == index ? Styles.orange : null,
              ),
              Text(
                text,
                style: TextStyle(
                    color: _itemSelected == index ? Styles.orange : null),
              ),
            ],
          ),
          onTap: () => setState(
                () {
              _itemSelected = index;
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          _icon(0, text: 'Legs', iconData: Icons.airline_seat_legroom_normal),
          // _icon(1, text: 'Core', iconData: Icons.airline_seat_flat),
          _icon(1, text: 'Torso', iconData: Icons.paragliding),
        ],
      ),
    );
  }
}

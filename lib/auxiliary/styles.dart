import 'package:flutter/material.dart';

class Styles {
  static const Color orange = Color(0xfff55536);
  static const Color blue = Color(0xff81d2c7);
  static const Color yellow = Color(0xffffd791);
  static const Color brown = Color(0xff56494e);

  static final MaterialColor materialOrange =
      MaterialColor(orange.value, const <int, Color>{
    50: orange,
    100: orange,
    200: orange,
    300: orange,
    400: orange,
    500: orange,
    600: orange,
    700: orange,
    800: orange,
    900: orange,
  });

  static const TextStyle header1 = TextStyle(
    color: brown,
    fontWeight: FontWeight.bold,
    fontSize: 28,
  );

  static const TextStyle header2 = TextStyle(
    color: brown,
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );

  static const TextStyle header3 = TextStyle(
    color: brown,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static Container horizontalRule({double top = 0.0, double bottom = 0.0}) {
    return Container(
      padding: EdgeInsets.only(
        top: top,
        bottom: bottom,
      ),
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: brown,
          ),
        ),
      ),
    );
  }
}

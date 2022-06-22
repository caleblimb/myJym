import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

class Modal {
  static const _backgroundColor = Colors.white;
  static const _margin = EdgeInsets.fromLTRB(32, 48, 32, 48);
  static const _padding = EdgeInsets.fromLTRB(8, 8, 8, 8);
  static const _borderRadius = BorderRadius.all(Radius.circular(20));

  static Future<void> open({required BuildContext context, required Widget child}) async {
    await showPlatformDialog(
      context: context,
      builder: (context) => Material(
        color: const Color.fromRGBO(0, 0, 0, 0),
        child: InkResponse(
          child: Container(
            margin: _margin,
            padding: _padding,
            decoration: const BoxDecoration(
              color: _backgroundColor,
              borderRadius: _borderRadius,
            ),
            child: InkResponse(
              child: child,
              onTap: () => {}, //Overwrites Navigation.pop for content
            ),
          ),
          onTap: () => Navigator.pop(context),
        ),
      ),
      useRootNavigator: false,
    );
  }
}

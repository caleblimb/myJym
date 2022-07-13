import 'dart:convert';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

import '../../auxiliary/preference_manager.dart';
import '../../auxiliary/styles.dart';

class Export extends StatefulWidget {
  const Export({Key? key}) : super(key: key);

  @override
  State<Export> createState() => _ExportState();
}

class _ExportState extends State<Export> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String sharedPreferencesJSON = PreferenceManager.toJson();
    controller.text = sharedPreferencesJSON;
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Text(
            "Export Data",
            style: Styles.header1,
          ),
          const Text(
            "Press the copy button along side the text field to copy your data",
            style: Styles.header3,
          ),
          exportField(),
        ],
      ),
    );
  }
  Widget exportField() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: (() async {
            await FlutterClipboard.copy(base64Encode(utf8.encode(controller.text)));
          }),
          child: Row(children: const [Text('Copy '), Icon(Icons.content_copy_outlined)],),
  ),
  ],
      );
}


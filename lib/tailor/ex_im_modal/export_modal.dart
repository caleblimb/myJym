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
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            "Export Data",
            style: Styles.header1,
          ),
          Text(
            "Press the copy button along side the text field to copy your data",
            style: Styles.header3,
          ),
          exportField(),
        ],
      ),
    );
  }
  Widget exportField() => Row(
      children: [
        Expanded(child: TextField(controller: controller,)),
        FloatingActionButton.small(
          onPressed: (() async {
            await FlutterClipboard.copy(controller.text);
          }),
          child: Icon(Icons.content_copy),
  ),
  ],
      );
}


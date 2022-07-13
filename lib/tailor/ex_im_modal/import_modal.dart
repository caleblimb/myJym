import 'dart:convert';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:myjym/auxiliary/preference_manager.dart';
import 'package:myjym/auxiliary/styles.dart';

class Import extends StatefulWidget {
  const Import({Key? key}) : super(key: key);

  @override
  State<Import> createState() => _ImportState();
}

final _formKey = GlobalKey<FormState>();

class _ImportState extends State<Import> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text("Import Data", style: Styles.header1),
      Text(
        "Paste the un-changed information into the text-box",
        style: Styles.header3,
      ),
      Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the Text';
                }
                return null;
              },
            ),
            ElevatedButton.icon(
                onPressed: (() async {
                  final value = await FlutterClipboard.paste();
                  setState((){
                    controller.text = value as String;
                  });
                }),
              label: Text("Paste"),
              icon: Icon(Icons.paste),
            ),
            ElevatedButton(
                onPressed: (() {
                  if (_formKey.currentState!.validate()) {
                    var base64 = base64Decode(controller.text);
                    var jsonString = utf8.decode(base64);

                    bool result = PreferenceManager.fromJson(jsonString);

                    if (result) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Preferences Uploaded')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'ERROR: Check your information and try again')),
                      );
                      //context.pop()
                    }
                    Navigator.pop(context);
                  }
                }),
                child: Text("Submit"))
          ],
        ),
      )
    ]);
  }
}

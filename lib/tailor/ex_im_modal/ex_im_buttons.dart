import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myjym/tailor/ex_im_modal/export_modal.dart';
import 'package:myjym/tailor/ex_im_modal/import_modal.dart';

import '../../auxiliary/modal.dart';

class ExImButtons extends StatefulWidget {
  const ExImButtons({Key? key}) : super(key: key);

  @override
  State<ExImButtons> createState() => _ExImButtonsState();
}

class _ExImButtonsState extends State<ExImButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Wrap(
          spacing: 20,
          children: [
            ElevatedButton.icon(
              onPressed: () async {
                // Open modal
                await Modal.open(child: Import(), context: context);
                setState((){});
              },
              label: Text('Import'),
              icon: Icon(Icons.download),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                await Modal.open(child: Export(), context: context);
                setState((){});
              },
              label: Text('Export'),
              icon: Icon(Icons.upload_file),
            ),
          ],
        )
      ],
    );
  }
}

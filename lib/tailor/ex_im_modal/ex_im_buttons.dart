import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myjym/tailor/ex_im_modal/export_modal.dart';
import 'package:myjym/tailor/ex_im_modal/import_modal.dart';

import '../../auxiliary/modal.dart';

class ExImButtons extends StatelessWidget {
  const ExImButtons({Key? key}) : super(key: key);

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
              },
              label: Text('Import'),
              icon: Icon(Icons.download),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                await Modal.open(child: Export(), context: context);
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

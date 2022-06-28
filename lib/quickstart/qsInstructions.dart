import 'package:flutter/material.dart';

import '../auxiliary/styles.dart';

class Instructions extends StatelessWidget {
  const Instructions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: const [
          Text(
            'Get Started',
            style: Styles.header1,
          ),
          Text(
            "Set your preferences here. All preferences can be set later in tailor workout",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

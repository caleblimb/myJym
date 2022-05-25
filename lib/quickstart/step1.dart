import 'package:flutter/material.dart';
import 'package:myjym/tailor/body_info.dart';

import '../auxiliary/styles.dart';

class Step1 extends StatelessWidget {
  const Step1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: const [
          Text(
            'Get Started',
            style: Styles.header1,
          ),
          BodyInfo(),
        ],
      ),
    );
  }
}

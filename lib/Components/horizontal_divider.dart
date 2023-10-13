import 'package:flutter/material.dart';

import '../constants.dart';

class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          color: sectionColor,
          height: 2,
          width: size.width * 0.277,
        ),
        Text(
          'OR',
          style: TextStyle(
              color: black, fontSize: 12, fontWeight: FontWeight.w700),
        ),
        Container(
          color: sectionColor,
          height: 2,
          width: size.width * 0.277,
        )
      ],
    );
  }
}

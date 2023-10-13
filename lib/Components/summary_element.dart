import 'package:flutter/material.dart';

import '../constants.dart';

class SummaryElement extends StatelessWidget {
  bool isError;
  final String title;
  final String subtitle;
  SummaryElement({
    Key? key,
    required this.title,
    required this.subtitle,
    this.isError = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: primary,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        SizedBox(height: 4 * screenHeight),
        Text(
          subtitle,
          style: TextStyle(
            color: isError ? red : black,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

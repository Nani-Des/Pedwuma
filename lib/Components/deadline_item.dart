import 'package:flutter/material.dart';

import '../constants.dart';

class DeadlineItem extends StatelessWidget {
  final String text;
  const DeadlineItem({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 49 * screenHeight,
      width: 90 * screenWidth,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: appointmentTimeColor, width: 1),
      ),
      child: Center(
          child: Text(
        text,
        style: TextStyle(
          color: black,
          fontSize: 16,
          fontWeight: FontWeight.w100,
        ),
      )),
    );
  }
}

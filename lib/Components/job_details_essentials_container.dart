import 'package:flutter/material.dart';

import '../constants.dart';

class JobDetailsEssentialsContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  const JobDetailsEssentialsContainer({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 116 * screenHeight,
      width: 161 * screenWidth,
      decoration: BoxDecoration(
          color: sectionColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: appointmentTimeColor, width: 1)),
      padding: EdgeInsets.only(
        top: 20 * screenHeight,
        bottom: 30 * screenHeight,
        left: 10 * screenWidth,
        right: 10 * screenWidth,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: black,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(
              color: primary,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

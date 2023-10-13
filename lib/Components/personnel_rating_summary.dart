import 'package:flutter/material.dart';

import '../constants.dart';

class PersonnelRatingSummary extends StatelessWidget {
  String rating;
  PersonnelRatingSummary({
    Key? key,
    this.rating = '4.7',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              top: screenHeight * 2.0, right: 5.94 * screenWidth),
          child: Image.asset('assets/icons/gold_star.png'),
        ),
        Text(
          '($rating)',
          style: TextStyle(
              color: primary, fontWeight: FontWeight.w500, fontSize: 16),
        ),
        SizedBox(width: 4 * screenWidth),
        Text(
          'rating(s)',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w300, color: black),
        ),
      ],
    );
  }
}

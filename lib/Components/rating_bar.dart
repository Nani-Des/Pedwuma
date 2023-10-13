import 'package:flutter/material.dart';

import '../constants.dart';

class RatingBar extends StatelessWidget {
  final double width;
  const RatingBar({
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * 6.0),
      child: Container(
        height: 5 * screenHeight,
        width: 159 * screenWidth,
        color: grey,
        alignment: Alignment.centerLeft,
        child: Container(
          width: width * screenWidth,
          decoration: BoxDecoration(
            color: primary,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }
}

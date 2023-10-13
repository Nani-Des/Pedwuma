import 'package:flutter/material.dart';

import '../constants.dart';

class SocialMediaContainer extends StatelessWidget {
  final String iconLocation;
  final String text;
  const SocialMediaContainer({
    Key? key,
    required this.iconLocation,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53 * screenHeight,
      width: 170.5 * screenWidth,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: appointmentTimeColor, width: 1),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              iconLocation,
              height: 20.94 * screenHeight,
              width: 21.07 * screenWidth,
            ),
            SizedBox(width: 9.5 * screenWidth),
            Text(
              text,
              style: TextStyle(
                color: black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}

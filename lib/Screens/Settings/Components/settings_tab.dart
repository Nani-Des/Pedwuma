import 'package:flutter/material.dart';

import '../../../constants.dart';

class SettingsTab extends StatelessWidget {
  final String title;
  final String iconLocation;
  const SettingsTab({
    Key? key,
    required this.title,
    required this.iconLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'assets/icons/' + iconLocation + '.png',
          color: semiGrey,
        ),
        SizedBox(width: 20 * screenWidth),
        Text(
          title,
          style: TextStyle(
            color: black,
            fontSize: 17,
          ),
        ),
        Spacer(),
        Image.asset(
          'assets/icons/forward_arrow.png',
          color: semiGrey,
        ),
        SizedBox(width: 14.97 * screenWidth),
      ],
    );
  }
}

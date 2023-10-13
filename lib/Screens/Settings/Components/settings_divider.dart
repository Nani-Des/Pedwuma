import 'package:flutter/material.dart';

import '../../../constants.dart';

class SettingsDivider extends StatelessWidget {
  bool isSettings;
  SettingsDivider({
    Key? key,
    this.isSettings = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: EdgeInsets.symmetric(
          vertical: isSettings ? screenHeight * 20.44 : screenHeight * 16),
      child: Container(
        height: 1 * screenHeight,
        width: 350 * screenWidth,
        color: grey,
      ),
    ));
  }
}

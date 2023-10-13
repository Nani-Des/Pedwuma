import 'package:flutter/material.dart';
import 'package:handyman_app/Screens/Notifications/notification_screen.dart';

import '../constants.dart';

class DefaultBackButton extends StatelessWidget {
  bool isNormalBackButton;
  Widget screen;
  DefaultBackButton({
    Key? key,
    this.isNormalBackButton = true,
    this.screen = const NotificationScreen(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      highlightColor: tabLight,
      onPressed: () {
        isNormalBackButton
            ? Navigator.pop(context)
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => screen,
                ));
      },
      icon: Padding(
        padding: EdgeInsets.only(left: screenWidth * 12.0),
        child: Icon(
          Icons.arrow_back_ios_rounded,
          color: primary,
          weight: 15,
        ),
      ),
    );
  }
}

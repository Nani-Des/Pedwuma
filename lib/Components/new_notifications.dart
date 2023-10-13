import 'package:flutter/material.dart';

import '../constants.dart';
import 'notification_item.dart';

class NewNotifications extends StatefulWidget {
  NewNotifications({
    Key? key,
  }) : super(key: key);

  @override
  State<NewNotifications> createState() => _NewNotificationsState();
}

class _NewNotificationsState extends State<NewNotifications> {
  bool isNotificationShowing = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              EdgeInsets.only(left: screenWidth * 6.0, right: 10 * screenWidth),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'New Notification',
                style: TextStyle(
                  color: black,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isNotificationShowing = !isNotificationShowing;
                  });
                },
                child: Container(
                  height: 37 * screenHeight,
                  width: 37 * screenWidth,
                  decoration: BoxDecoration(
                    color: white,
                    border: Border.all(color: appointmentTimeColor, width: 1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: primary,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 23 * screenHeight),
        Container(
          margin: EdgeInsets.only(left: 9 * screenWidth),
          height: 1 * screenHeight,
          width: 350 * screenWidth,
          color: grey,
        ),
        isNotificationShowing
            ? SizedBox(height: 23 * screenHeight)
            : SizedBox(),
        isNotificationShowing
            ? ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return NotificationItem();
                },
                separatorBuilder: (context, index) =>
                    SizedBox(height: 10 * screenHeight),
                itemCount: 3)
            : SizedBox(),
      ],
    );
  }
}

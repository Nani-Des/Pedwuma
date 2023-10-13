import 'package:flutter/material.dart';

import '../../../Components/text_field_bar.dart';
import '../../../constants.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 8 * screenHeight),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 10.0),
            child: Container(
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: primary, width: 2),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: 6 * screenWidth, vertical: screenHeight * 6),
              child: Text(
                'Yesterday',
                style: TextStyle(
                  color: chatTimeColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 10.0, left: 18 * screenWidth),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 280 * screenWidth),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 12 * screenWidth,
                      vertical: 14 * screenHeight),
                  decoration: BoxDecoration(
                    color: chatRed,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Reminder! Complete your task by the 15th. Please make sure to lock the door. Thank you',
                          overflow: TextOverflow.visible,
                          softWrap: true,
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          style: TextStyle(
                            height: 1.3,
                            overflow: TextOverflow.ellipsis,
                            color: white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 18.0,
                  bottom: 10 * screenHeight,
                  top: 8 * screenHeight),
              child: Text(
                'Read',
                style: TextStyle(
                    color: black,
                    fontSize: 24,
                    fontFamily: 'Sacramento',
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 10.0, right: 15 * screenWidth),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 280 * screenWidth),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12 * screenWidth,
                          vertical: 14 * screenHeight),
                      decoration: BoxDecoration(
                        color: chatBlue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Reminder! ',
                              overflow: TextOverflow.visible,
                              softWrap: true,
                              textHeightBehavior: TextHeightBehavior(
                                  applyHeightToFirstAscent: false),
                              style: TextStyle(
                                height: 1.3,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: 15 * screenWidth,
                bottom: 10 * screenHeight,
                top: 8 * screenHeight,
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Delivered',
                  style: TextStyle(
                      color: black,
                      fontSize: 24,
                      fontFamily: 'Sacramento',
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
        TextfieldBar(
          controller: TextEditingController(),
          screen: () {},
        ),
      ],
    );
  }
}

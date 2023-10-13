import 'package:flutter/material.dart';

import '../constants.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120 * screenHeight,
      width: 366 * screenWidth,
      decoration: BoxDecoration(
        color: sectionColor,
        borderRadius: BorderRadius.circular(13),
      ),
      padding: EdgeInsets.only(
        left: 14 * screenWidth,
        right: 29 * screenWidth,
        bottom: 18 * screenHeight,
        top: 24 * screenHeight,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 60 * screenHeight,
            width: 47 * screenWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.36),
              image: DecorationImage(
                  image: AssetImage('assets/images/profile_pic.jpeg'),
                  fit: BoxFit.fill),
            ),
          ),
          SizedBox(width: 14 * screenWidth),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: 'Vienna Castles',
                    style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        fontFamily: 'Inter'),
                    children: <InlineSpan>[
                      TextSpan(
                        text: ' ' + 'has accepted your job offer.',
                        style: TextStyle(
                          color: black,
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 1 * screenHeight),
                Text(
                  '5 mins ago',
                  style: TextStyle(
                    fontSize: 15,
                    color: black,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

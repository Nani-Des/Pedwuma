// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import '../constants.dart';

class SentMessage extends StatelessWidget {
  final String timeStamp;
  final String message;
  const SentMessage({
    Key? key,
    required this.message,
    required this.timeStamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.only(top: screenHeight * 10.0, left: 13 * screenWidth),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
                              message,
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
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 10 * screenHeight,
                      top: 8 * screenHeight,
                    ),
                    child: Align(
                      // alignment: Alignment.centerRight,
                      child: Text(
                        timeStamp,
                        style: TextStyle(
                            color: chatTimeColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

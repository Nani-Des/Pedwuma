import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:handyman_app/constants.dart';

import '../../../Components/received_message.dart';
import '../../../Components/sent_message.dart';
import '../../../Components/text_field_bar.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 18.0, vertical: 10 * screenHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Text(
                  'Yesterday',
                  style: TextStyle(
                    color: grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 13 * screenHeight),
              ReceivedMessage(
                pic: '',
                timeStamp: '',
                message: '',
              ),
              SentMessage(
                message: '',
                timeStamp: '',
              ),
            ],
          ),
        ),
        TextfieldBar(
          controller: TextEditingController(),
          screen: () {},
        ),
      ],
    );
  }
}

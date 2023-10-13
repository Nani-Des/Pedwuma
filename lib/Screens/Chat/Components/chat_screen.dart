import 'package:flutter/material.dart';
import 'package:handyman_app/Components/default_back_button.dart';
import 'package:handyman_app/Screens/Chat/Components/body.dart';
import 'package:handyman_app/constants.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: DefaultBackButton(),
        backgroundColor: white,
        title: Padding(
          padding: EdgeInsets.only(left: screenWidth * 11.0),
          child: Text(
            'Harry Garett',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: black,
              fontSize: 18,
            ),
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Image.asset('assets/icons/search.png'),
          ),
          GestureDetector(
            onTap: () {},
            child: Image.asset('assets/icons/3_dots.png'),
          ),
          SizedBox(width: 12 * screenWidth),
        ],
      ),
      backgroundColor: white,
      body: Body(),
    );
  }
}

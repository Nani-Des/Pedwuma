import 'package:flutter/material.dart';
import 'package:handyman_app/Components/default_back_button.dart';
import '../../../constants.dart';
import 'body_alternate.dart';

class ChatAlternateScreen extends StatelessWidget {
  const ChatAlternateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: DefaultBackButton(),
        backgroundColor: white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 45 * screenHeight,
              width: 45 * screenWidth,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/profile_pic.jpeg'),
                ),
              ),
            ),
            SizedBox(width: 10 * screenWidth),
            Text(
              'Harry Garett',
              style: TextStyle(
                color: black,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
        actions: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                '149.5 km',
                style: TextStyle(
                  color: black,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'away from you',
                style: TextStyle(
                  color: black,
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          SizedBox(width: 14 * screenWidth),
        ],
      ),
      backgroundColor: white,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: SingleChildScrollView(
              child: Image.asset('assets/images/chat_background.jpg',
                  fit: BoxFit.cover),
            ),
          ),
          Body(),
        ],
      ),
    );
  }
}

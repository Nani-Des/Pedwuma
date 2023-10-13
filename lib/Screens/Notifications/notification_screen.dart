import 'package:flutter/material.dart';
import 'package:handyman_app/Components/default_back_button.dart';

import '../../constants.dart';
import '../Notifications/Components/body.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: DefaultBackButton(),
        title: Text(
          'Notification',
          style: TextStyle(
            color: black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: white,
      body: Body(),
    );
  }
}

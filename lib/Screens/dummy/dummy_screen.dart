import 'package:flutter/material.dart';
import 'package:handyman_app/Services/notification_service.dart';

import '../../Components/default_back_button.dart';
import '../../constants.dart';

class DummyScreen extends StatelessWidget {
  const DummyScreen({Key? key}) : super(key: key);

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
        backgroundColor: white,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(vertical: 40, horizontal: 30)),
                onPressed: () {
                  NotificationService().showNotification(
                    title: 'Sample',
                    body: 'It works',
                    payload: '',
                  );
                },
                child: Center(
                  child: Text(
                    'Button',
                    style: TextStyle(color: white),
                  ),
                )),
          ),
        ],
      ),
      backgroundColor: white,
    );
  }
}

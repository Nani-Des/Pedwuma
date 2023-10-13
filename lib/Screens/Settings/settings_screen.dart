import 'package:flutter/material.dart';
import 'package:handyman_app/Components/default_back_button.dart';

import '../../constants.dart';
import '../Settings/Components/body.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: DefaultBackButton(),
        title: Text(
          'Settings',
          style: TextStyle(
            color: black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 0.0,
      ),
      body: Body(),
      backgroundColor: white,
    );
  }
}

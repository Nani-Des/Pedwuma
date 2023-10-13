import 'package:flutter/material.dart';
import 'package:handyman_app/Components/default_back_button.dart';

import '../../../constants.dart';
import '../../Profile/Profile - Handyman/Components/body.dart';

class HandymanProfileScreen extends StatelessWidget {
  const HandymanProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: DefaultBackButton(),
        title: Text(
          'Profile',
          style: TextStyle(
            color: black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 0.0,
      ),
      backgroundColor: white,
      body: Body(),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../Components/default_back_button.dart';
import '../../../constants.dart';
import '../../Profile/Profile - Customer/Components/body.dart';

class ProfileCustomer extends StatelessWidget {
  const ProfileCustomer({Key? key}) : super(key: key);

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

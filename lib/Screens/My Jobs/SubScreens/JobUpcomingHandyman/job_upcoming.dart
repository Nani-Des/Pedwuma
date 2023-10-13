import 'package:flutter/material.dart';
import 'package:handyman_app/Components/default_back_button.dart';

import '../../../../constants.dart';
import '../../../My Jobs/SubScreens/JobUpcomingHandyman/Components/body.dart';

class JobUpcomingScreen extends StatelessWidget {
  const JobUpcomingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: DefaultBackButton(),
        title: Text(
          'Upcoming Job',
          style: TextStyle(
            color: black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: white,
        elevation: 0.0,
      ),
      body: Body(),
      backgroundColor: white,
    );
  }
}

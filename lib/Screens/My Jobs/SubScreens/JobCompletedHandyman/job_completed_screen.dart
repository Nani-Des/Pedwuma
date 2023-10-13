import 'package:flutter/material.dart';

import '../../../../Components/default_back_button.dart';
import '../../../../constants.dart';
import '../../../My Jobs/SubScreens/JobCompletedHandyman/Components/body.dart';

class JobCompletedScreen extends StatelessWidget {
  const JobCompletedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: DefaultBackButton(),
        title: Text(
          'Completed Job',
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

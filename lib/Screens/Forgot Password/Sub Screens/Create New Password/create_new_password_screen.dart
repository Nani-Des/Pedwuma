import 'package:flutter/material.dart';

import '../../../../Components/default_back_button.dart';
import '../../../../constants.dart';
import '../../../Forgot Password/Sub Screens/Create New Password/Components/body.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: DefaultBackButton(),
        backgroundColor: white,
        elevation: 0.0,
      ),
      body: Body(),
      backgroundColor: white,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:handyman_app/Components/default_back_button.dart';
import 'package:handyman_app/constants.dart';

import '../Forgot Password/Components/body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        leading: DefaultBackButton(),
        elevation: 0.0,
      ),
      body: Body(),
      backgroundColor: white,
    );
  }
}

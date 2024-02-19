import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handyman_app/Screens/Home/Components/body.dart';
import '../../Components/default_back_button.dart';

import '../../constants.dart';
import '../Login/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,

      body: Body(),
    );
  }
}

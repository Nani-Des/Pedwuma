import 'package:flutter/material.dart';
import 'package:handyman_app/Screens/Home/Components/body.dart';
import '../../Components/default_back_button.dart';

import '../../constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        elevation: 0.0,
      ),
      body: Body(),
    );
  }
}

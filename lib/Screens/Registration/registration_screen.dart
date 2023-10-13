import 'package:flutter/material.dart';

import '../../constants.dart';
import '../Registration/Components/body.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      backgroundColor: white,
    );
  }
}

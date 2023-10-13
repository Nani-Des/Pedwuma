import 'package:flutter/material.dart';
import '../../Successful/Job Application Successful/Components/body.dart';

import '../../../constants.dart';

class JobApplicationSuccessfulScreen extends StatelessWidget {
  const JobApplicationSuccessfulScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0.0,
      ),
      backgroundColor: primary,
      body: Body(),
    );
  }
}

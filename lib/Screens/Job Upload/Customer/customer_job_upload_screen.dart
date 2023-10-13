// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:handyman_app/Screens/Job%20Upload/Customer/Components/body.dart';
import 'package:handyman_app/Screens/Job%20Upload/Sub%20Screen/Customer/customer_job_upload_list.dart';

import '../../../Components/default_back_button.dart';
import '../../../constants.dart';

class CustomerJobUploadScreen extends StatelessWidget {
  const CustomerJobUploadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: DefaultBackButton(),
        title: Text(
          'Job Upload',
          style: TextStyle(
            color: black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomerJobUploadList(),
                  ),
                );
              },
              icon: Icon(
                Icons.list_rounded,
              ),
              color: primary,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              padding: EdgeInsets.only(right: 20 * screenWidth)),
        ],
      ),
      backgroundColor: white,
      body: Body(),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:handyman_app/Components/credentials_button.dart';
import 'package:handyman_app/Components/horizontal_divider.dart';
import 'package:handyman_app/Services/read_data.dart';

import '../../../../Components/default_back_button.dart';
import '../../../../constants.dart';
import '../../../Job Upload/Modify/Customer/Components/body.dart';
// import '../../Sub Screen/Customer/Components/body.dart';

class EditCustomerJobUpload extends StatefulWidget {
  const EditCustomerJobUpload({Key? key}) : super(key: key);

  @override
  State<EditCustomerJobUpload> createState() => _EditCustomerJobUploadState();
}

class _EditCustomerJobUploadState extends State<EditCustomerJobUpload> {
  ReadData readData = ReadData();

  void deleteJobUpload() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
              child: Text(
            'Delete Job Upload',
            style: TextStyle(
              color: primary,
              fontWeight: FontWeight.w600,
            ),
          )),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 30.0,
                    horizontal: 24 * screenWidth),
                child: Text(
                  'Are you sure you want to delete this Job Upload?',
                  style: TextStyle(
                    color: black,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20 * screenHeight),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 53 * screenHeight,
                      width: 133 * screenWidth,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: screenWidth * 12.0),
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: appointmentTimeColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: primary,
                    endIndent: 0,
                    indent: 0,
                    width: 10,
                    thickness: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      readData.deleteJobUpload(context);
                    },
                    child: Container(
                      height: 53 * screenHeight,
                      width: 133 * screenWidth,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text('Yes, Delete',
                            style: TextStyle(
                              color: red,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6 * screenHeight),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 0),
        );
      },
    );
  }

  @override
  void initState() {
    isJobUploadEditReadOnly = true;
    super.initState();
  }

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
        actions: isJobUploadEditReadOnly
            ? [
                IconButton(
                  highlightColor: sectionColor,
                  splashColor: sectionColor,
                  onPressed: () {
                    setState(() {
                      isJobUploadEditReadOnly = !isJobUploadEditReadOnly;
                    });
                  },
                  icon: Icon(
                    Icons.edit_note_rounded,
                    color: primary,
                    size: 25,
                  ),
                ),
                IconButton(
                  highlightColor: sectionColor,
                  splashColor: sectionColor,
                  onPressed: deleteJobUpload,
                  icon: Icon(
                    Icons.delete_rounded,
                    color: primary,
                  ),
                ),
                SizedBox(width: 6 * screenWidth),
              ]
            : [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isJobUploadEditReadOnly = !isJobUploadEditReadOnly;
                    });
                  },
                  child: Container(
                    height: 30 * screenHeight,
                    width: 30 * screenWidth,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: white,
                      border: Border.all(color: primary, width: 1),
                    ),
                    child: Icon(
                      Icons.clear,
                      color: primary,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(width: 18 * screenWidth),
              ],
      ),
      backgroundColor: white,
      body: Body(),
    );
  }
}

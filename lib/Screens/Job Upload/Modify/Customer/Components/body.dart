// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:handyman_app/Screens/Job%20Upload/Sub%20Screen/Customer/Components/body.dart';
import 'package:handyman_app/Services/read_data.dart';

import '../../../../../Components/deadline_item.dart';
import '../../../../../Components/job_upload_location_info.dart';
import '../../../../../Components/job_upload_optionals_info.dart';
import '../../../../../Components/job_upload_service_info.dart';
import '../../../../../Components/job_upload_work_cert_info.dart';
import '../../../../../Components/profile_item_dropdown.dart';
import '../../../../../Components/upload_button.dart';
import '../../../../../Services/storage_service.dart';
import '../../../../../constants.dart';
import '../../../../Dashboard/Handymen/handymen_dashboard_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final chargeController = TextEditingController();
  ReadData readData = ReadData();

  @override
  void dispose() {
    chargeController.dispose();
    super.dispose();
  }

  Future uploadJob() async {
    if (FieldsCheck()) {
      try {
        deadline = '$deadlineDay-$deadlineMonth-$deadlineYear';
        if (resultList != null) {
          addPortfolio(
              allCustomerJobsUpload[selectedJobUploadIndex].jobUploadId);
        }
        DateTime dateTime = DateTime.now();

        await FirebaseFirestore.instance
            .collection('Jobs')
            .doc(allCustomerJobsUpload[selectedJobUploadIndex].jobUploadId)
            .update({
          'User Pic': imageUrl,
          'Name': allUsers[0].firstName + ' ' + allUsers[0].lastName,
          'Seen By': seenByHintText,
          'Service Information': {
            'Service Category': serviceCatHintText,
            'Service Provided': serviceProvHintText,
            'Charge': int.parse(chargeController.text.trim()),
            'Charge Rate': chargePHint,
            'Expertise': expertHint,
          },
          'Work Detail & Rating': {
            'Portfolio': uploadPortfolioList,
            'Rating': ratingHintText as String,
          },
          'Address Information': {
            'House Number': uploadHouseNum,
            'Street': uploadStreet,
            'Town': uploadTown,
            'Region': uploadRegion,
          },
          'Optional': {
            'Portfolio Present': isPortfolioTicked,
            'References Present': isReferencesTicked,
          },
          'Job Details': {
            'Job Status': jobStatus,
            'Deadline': deadline,
          },
          'Upload Date':
              '${dateTime.day > 9 ? dateTime.day : '0${dateTime.day}'}-${dateTime.month > 9 ? dateTime.month : '0${dateTime.month}'}-${dateTime.year - 2000}',
          'Upload Time':
              '${dateTime.hour > 9 ? dateTime.hour : '0${dateTime.hour}'}:${dateTime.minute > 9 ? dateTime.minute : '0${dateTime.minute}'}',
        });

        //TODO: Change Dialog Image Color to suite app design
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              insetPadding: EdgeInsets.symmetric(horizontal: 10 * screenWidth),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image(image: AssetImage('assets/images/success.gif')),
                  SizedBox(height: 15 * screenHeight),
                  Text(
                    'Job Uploaded Successfully!',
                    style: TextStyle(
                      color: black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            );
          },
        );

        await Future.delayed(Duration(seconds: 3), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HandymanDashboardScreen(),
            ),
          );
        });
      } catch (e) {
        print(e.toString());
      }
    } else {
      print('Some fields are empty. Try again.');
    }
  }

  bool FieldsCheck() {
    if (chargeController.text.trim().isNotEmpty &&
        chargePHint != 'N/A' &&
        expertHint != 'N/A' &&
        deadlineDay != 'Day') {
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.black45,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Center(
              child: Text(
                'One or more required fields is empty. Check them again.',
                style: TextStyle(height: 1.3),
                textAlign: TextAlign.center,
              ),
            )),
      );
      return false;
    }
  }

  Storage storage = Storage();

  Future addPortfolio(String jobId) async {
    if (resultList != null) {
      resultList?.files.forEach((file) async {
        final fileNames = file.name;
        final filePath = file.path;
        await storage.jobUploadFiles(fileNames, 'Portfolio', filePath as String,
            jobId, 'Jobs');
      });
    } else {
      throw ('No file picked');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: readData.getCustomerJobUploadItemData(
            allCustomerJobsUpload[selectedJobUploadIndex].jobUploadId,
            chargeController),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 15.0,
                            vertical: 15 * screenHeight),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 5.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Seen by:',
                                    style: TextStyle(
                                      color: black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 13 * screenHeight),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                        height: 49 * screenHeight,
                                        width: 51 * screenWidth,
                                        decoration: BoxDecoration(
                                          color: white,
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          border: Border.all(
                                              color: appointmentTimeColor,
                                              width: 1),
                                        ),
                                        child: Center(
                                            child: Icon(Icons.visibility,
                                                color: primary)),
                                      ),
                                      SeenBySelect(
                                        isReadOnly: isJobUploadEditReadOnly,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20 * screenHeight),
                            Padding(
                              padding: EdgeInsets.only(left: screenWidth * 5.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Deadline',
                                    style: TextStyle(
                                      color: black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 13 * screenHeight),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: isJobUploadEditReadOnly
                                            ? () {}
                                            : () {
                                                showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime(2024),
                                                ).then((date) {
                                                  setState(() {
                                                    deadlineDay =
                                                        date!.day.toString();
                                                    if (date.month == 10 ||
                                                        date.month == 11 ||
                                                        date.month == 12) {
                                                      deadlineMonth =
                                                          date.month.toString();
                                                    } else {
                                                      deadlineMonth =
                                                          ('0${date.month}');
                                                    }
                                                    deadlineYear =
                                                        date.year.toString();
                                                  });

                                                  print(deadlineDay);
                                                  print(deadlineMonth);
                                                  print(deadlineYear);
                                                });
                                              },
                                        child: Container(
                                          height: 49 * screenHeight,
                                          width: 51 * screenWidth,
                                          decoration: BoxDecoration(
                                            color: white,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            border: Border.all(
                                                color: appointmentTimeColor,
                                                width: 1),
                                          ),
                                          child: Center(
                                              child: Icon(
                                                  Icons.edit_calendar_rounded,
                                                  color: primary)),
                                        ),
                                      ),
                                      DeadlineItem(text: deadlineDay),
                                      DeadlineItem(text: deadlineMonth),
                                      DeadlineItem(text: deadlineYear),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30 * screenHeight),
                            JobUploadServiceInfo(
                              isReadOnly: isJobUploadEditReadOnly,
                              serviceProvided: jobUploadData.serviceProvided,
                              chargeController: chargeController,
                            ),
                            SizedBox(height: 30 * screenHeight),
                            JobUploadWorkCertInfo(
                              isReadOnly: isJobUploadEditReadOnly,
                            ),
                            SizedBox(height: 30 * screenHeight),
                            JobUploadLocationInfo(
                              isReadOnly: isJobUploadEditReadOnly,
                            ),
                            SizedBox(height: 30 * screenHeight),
                            JobUploadOptionalsInfo(
                                isReadOnly: isJobUploadEditReadOnly),
                            SizedBox(height: 30 * screenHeight),
                          ],
                        ),
                      );
                    },
                    itemCount: 1,
                  ),
                ),
                isJobUploadEditReadOnly
                    ? SizedBox()
                    : UploadButton(
                        screen: uploadJob,
                        icon: Icons.save_rounded,
                        buttonText: 'Save',
                        isIconPresent: true,
                      ),
              ],
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

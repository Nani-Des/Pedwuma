// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handyman_app/Components/job_upload_location_info.dart';
import 'package:handyman_app/Components/job_upload_service_info.dart';
import 'package:handyman_app/Components/job_upload_work_cert_info.dart';
import 'package:handyman_app/Components/profile_item_dropdown.dart';
import 'package:handyman_app/Components/upload_button.dart';
import 'package:handyman_app/Screens/Dashboard/Handymen/handymen_dashboard_screen.dart';
import 'package:handyman_app/Services/storage_service.dart';
import 'package:handyman_app/constants.dart';

import '../../../../Components/deadline_item.dart';
import '../../../../Components/job_upload_optionals_info.dart';
import '../../../../Services/read_data.dart';
import '../../../Home/Components/body.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final chargeController = TextEditingController();

  @override
  void dispose() {
    chargeController.dispose();
  }

  late final String jobID;
  //TODO: Add the upload of files
  Future uploadJob() async {
    if (FieldsCheck()) {
      try {
        final document = await FirebaseFirestore.instance
            .collection('Jobs')
            .add({
          'User ID': loggedInUserId,
        });
        final jobID = document.id;

        deadline = '$deadlineDay-$deadlineMonth-$deadlineYear';
        addPortfolio(document.id);

        addDetails(
          imageUrl,
          jobID,
          loggedInUserId,
          allUsers[0].firstName + ' ' + allUsers[0].lastName,
          //Customer's Name
          seenByHintText,
          // Who to see the job upload
          serviceCatHintText,
          // Category of job
          serviceProvHintText,
          // which service in the category to upload
          int.parse(chargeController.text.trim()),
          // Charge
          chargePHint,
          // Charge Rate
          expertHint,
          // Level of expertise
          uploadPortfolioList,
          // Portfolio List
          ratingHintText as String,
          // Overall Rating
          uploadHouseNum,
          //house number
          uploadStreet,
          // street
          uploadTown,
          // town
          uploadRegion,
          // region
          isPortfolioTicked,
          // whether handyman should add portfolio
          isReferencesTicked, // whether handyman should add past work references
          jobStatus,
          peopleApplied,
          deadline,
        );

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

  Future addDetails(
      String pic,
      String jobId,
      String custId,
      String userName,
      String seenBy,
      String serviceCat,
      String serviceProv,
      int charge,
      String chargeRate,
      String expertise,
      List portfolio,
      String rating,
      String houseNum,
      String street,
      String town,
      String region,
      bool isPortfolioPresent,
      bool isReferencePresent,
      bool jobStatus,
      int peopleApplied,
      String deadline,
      ) async {
    DateTime dateTime = DateTime.now();
    await FirebaseFirestore.instance
        .collection('Jobs')
        .doc(jobId)
        .update({
      'User Pic': pic,
      'Job ID': jobId,
      'User ID': custId,
      'Name': userName,
      'Seen By': seenBy,
      'Service Information': {
        'Service Category': serviceCat,
        'Service Provided': serviceProv,
        'Charge': charge,
        'Charge Rate': chargeRate,
        'Expertise': expertise,
      },
      'Work Detail & Rating': {
        'Portfolio': portfolio,
        'Rating': rating,
      },
      'Address Information': {
        'House Number': houseNum,
        'Street': street,
        'Town': town,
        'Region': region,
      },
      'Optional': {
        'Portfolio Present': isPortfolioPresent,
        'References Present': isReferencePresent,
      },
      'Job Details': {
        'Job Status': jobStatus,
        'People Applied': peopleApplied,
        'Applier IDs': [],
        'Deadline': deadline,
      },
      //TODO: CHANGE YEAR TO 2000'S AND LET IT REFLECT EVERYWHERE
      'Upload Date':
      '${dateTime.day > 9 ? dateTime.day : '0${dateTime.day}'}-${dateTime.month > 9 ? dateTime.month : '0${dateTime.month}'}-${dateTime.year - 2000}',
      'Upload Time':
      '${dateTime.hour > 9 ? dateTime.hour : '0${dateTime.hour}'}:${dateTime.minute > 9 ? dateTime.minute : '0${dateTime.minute}'}',
    });
  }

  bool FieldsCheck() {
    if (chargeController.text.isNotEmpty &&
        chargePHint != 'N/A' &&
        expertHint != 'N/A'  &&
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
        final fileNames = file!.name;
        final filePath = file!.path;
        await storage.jobUploadFiles(fileNames, 'Portfolio', filePath as String,
            jobId, 'Jobs');
      });
    } else {
      throw ('No file picked');
    }
  }

  @override
  void initState() {
    if (chargePHint != 'N/A' ||
        uploadTown != '' ||
        deadlineDay != 'Day' ||
        isPortfolioTicked == true ||
        isReferencesTicked == true ||
        uploadPortfolioList.isNotEmpty) {
      seenByHintText = 'All';
      serviceCatHintText = allCategoriesName[0];
      chargePHint = 'N/A';
      expertHint = 'N/A';
      uploadHouseNum = '';
      uploadStreet = '';
      uploadTown = '';
      uploadRegion = '';
      deadlineDay = 'Day';
      deadlineMonth = 'Month';
      deadlineYear = 'Year';
      dropdownvalue = 'N/A';
      uploadPortfolioList.clear();
      isPortfolioTicked = false;
      isReferencesTicked = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      padding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 5.0),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                height: 49 * screenHeight,
                                width: 51 * screenWidth,
                                decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      color: appointmentTimeColor, width: 1),
                                ),
                                child: Center(
                                    child:
                                    Icon(Icons.visibility, color: primary)),
                              ),
                              SeenBySelect(
                                isReadOnly: jobUploadReadOnly,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2024),
                                  ).then((date) {
                                    setState(() {
                                      if (date!.day > 9) {
                                        deadlineDay = date.day.toString();
                                      } else {
                                        deadlineDay = '0${date.day}';
                                      }

                                      if (date.month == 10 ||
                                          date.month == 11 ||
                                          date.month == 12) {
                                        deadlineMonth = date.month.toString();
                                      } else {
                                        deadlineMonth =
                                        ('0' + date.month.toString());
                                      }
                                      deadlineYear = date.year.toString();
                                    });
                                  });
                                },
                                child: Container(
                                  height: 49 * screenHeight,
                                  width: 51 * screenWidth,
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(
                                        color: appointmentTimeColor, width: 1),
                                  ),
                                  child: Center(
                                      child: Icon(Icons.edit_calendar_rounded,
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
                      isReadOnly: jobUploadReadOnly,
                      chargeController: chargeController,
                    ),
                    SizedBox(height: 30 * screenHeight),
                    JobUploadWorkCertInfo(
                      isReadOnly: jobUploadReadOnly,
                    ),
                    SizedBox(height: 30 * screenHeight),

                    SizedBox(height: 30 * screenHeight),
                    JobUploadOptionalsInfo(
                      isReadOnly: jobUploadReadOnly,
                    ),
                    SizedBox(height: 30 * screenHeight),
                  ],
                ),
              );
            },
            itemCount: 1,
          ),
        ),
        UploadButton(
          screen: uploadJob,
          icon: Icons.cloud_upload_rounded,
          buttonText: 'Upload',
          isIconPresent: true,
        ),
      ],
    );
  }
}

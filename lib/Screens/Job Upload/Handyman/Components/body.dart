// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handyman_app/Components/job_upload_work_cert_info.dart';
import 'package:handyman_app/Components/profile_item_dropdown.dart';
import 'package:handyman_app/Components/upload_button.dart';
import 'package:handyman_app/Screens/Dashboard/Jobs/jobs_dashboard_screen.dart';
import 'package:handyman_app/Screens/Home/Components/body.dart';
import 'package:handyman_app/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../Components/job_upload_location_info.dart';
import '../../../../Components/job_upload_service_info.dart';
import '../../../../Services/read_data.dart';
import '../../../../Services/storage_service.dart';

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
    super.dispose();
  }

  late final String jobID;
  //TODO: Add the upload of files
  Future uploadJob() async {
    if (FieldsCheck()) {
      try {
        final document = await FirebaseFirestore.instance
            .collection('Booking Profile')
            .add({
          'User ID': loggedInUserId,
        });

        final jobID = document.id;

        addPortfolio(document.id);
        addExperience(document.id);
        addCertification(document.id);

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
          uploadCertList,
          // Cert List
          uploadExperienceList,
          // Experience List
          ratingHintText as String,
          // Overall Rating
          int.parse(jobTotalHintText.toString()),
          //Job's completed
          uploadHouseNum,
          //house number
          uploadStreet,
          // street
          uploadTown,
          // town
          uploadRegion,
          // region
          jobStatus,
          // current job status of job
          referencesList, // whether handyman should add past work references
          uploadPortfolioList,
        );
//TODO: UPDATE DIALOG TO SHOW JOB UPLOADED SUCCESSFULLY SCREEN
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
                    AppLocalizations.of(context)!.crr,
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
              builder: (context) => JobsDashboardScreen(),
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
    List certification,
    List experience,
    String rating,
    int jobsDone,
    String houseNum,
    String street,
    String town,
    String region,
    bool jobStatus,
    List reference,
    List portfolio,
  ) async {
    DateTime dateTime = DateTime.now();
    DateTime jobDeadline = DateTime.now().add(Duration(days: 10));

    if (jobDeadline.day > 9) {
      deadlineDay = jobDeadline.day.toString();
    } else {
      deadlineDay = '0${jobDeadline.day}';
    }

    if (jobDeadline.month == 10 ||
        jobDeadline.month == 11 ||
        jobDeadline.month == 12) {
      deadlineMonth = jobDeadline.month.toString();
    } else {
      deadlineMonth = ('0${jobDeadline.month}');
    }
    deadlineYear = jobDeadline.year.toString();
    deadline = '$deadlineDay-$deadlineMonth-$deadlineYear';

    await FirebaseFirestore.instance
        .collection('Booking Profile')
        .doc(jobId)
        .update({
      'Deadline': deadline,
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
      'Job Details': {
        'People Applied': 0,
        'Applier IDs': [],
      },
      'Work Experience & Certification': {
        'Certification': certification,
        'Experience': experience,
        'Rating': rating,
        "Job's Completed": jobsDone,
        'Reference': reference,
        'Portfolio': portfolio,
      },
      'Address Information': {
        'House Number': houseNum,
        'Street': street,
        'Town': town,
        'Region': region,
      },
      'Upload Date':
          '${dateTime.day > 9 ? dateTime.day : '0${dateTime.day}'}-${dateTime.month > 9 ? dateTime.month : '0${dateTime.month}'}-${dateTime.year - 2000}',
      'Upload Time':
          '${dateTime.hour > 9 ? dateTime.hour : '0${dateTime.hour}'}:${dateTime.minute > 9 ? dateTime.minute : '0${dateTime.minute}'}',
    });
  }

  bool FieldsCheck() {
    if (chargeController.text.trim().isNotEmpty &&
        chargePHint != 'N/A' &&
        expertHint != 'N/A' ) {
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
        await storage.jobUploadFiles(fileNames as String, 'Portfolio',
            filePath as String, jobId, 'Booking Profile');
        print(uploadPortfolioList);
      });
    } else {
      throw ('No file picked');
    }
  }

  Future addCertification(String jobId) async {
    if (resultCertList != null) {
      resultCertList?.files.forEach((file) {
        final fileNames = file!.name;
        final filePath = file!.path;
        storage.jobUploadFiles(fileNames, 'Certification', filePath as String,
            jobId, 'Booking Profile');
      });
    } else {
      throw ('No file picked');
    }
  }

  Future addExperience(String jobId) async {
    if (resultExperienceList != null) {
      resultExperienceList?.files.forEach((file) {
        final fileNames = file!.name;
        final filePath = file!.path;
        storage.jobUploadFiles(fileNames, 'Experience', filePath as String,
            jobId, 'Booking Profile');
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
        uploadPortfolioList.isNotEmpty ||
        uploadExperienceList.isNotEmpty ||
        uploadCertList.isNotEmpty) {
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
      uploadCertList.clear();
      uploadExperienceList.clear();
      uploadPortfolioList.clear();
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
                    SizedBox(height: 30 * screenHeight),
                    JobUploadServiceInfo(
                        isReadOnly: jobUploadReadOnly,
                        chargeController: chargeController),
                    SizedBox(height: 30 * screenHeight),
                    JobUploadWorkCertInfo(
                        isReadOnly: jobUploadReadOnly, isHandyManUpload: true),
                    SizedBox(height: 30 * screenHeight),

                  ],
                ),
              );
            },
            itemCount: 1,
            shrinkWrap: true,
          ),
        ),
        UploadButton(
          screen: uploadJob,
          isIconPresent: true,
          icon: Icons.save,
          buttonText: 'Upload',
        ),
      ],
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:handyman_app/Screens/Job%20Upload/Sub%20Screen/Handyman/Components/body.dart';

import '../../../../../Components/job_upload_location_info.dart';
import '../../../../../Components/job_upload_service_info.dart';
import '../../../../../Components/job_upload_work_cert_info.dart';
import '../../../../../Components/profile_item_dropdown.dart';
import '../../../../../Components/upload_button.dart';
import '../../../../../Services/read_data.dart';
import '../../../../../Services/storage_service.dart';
import '../../../../../constants.dart';
import '../../../../Dashboard/Jobs/jobs_dashboard_screen.dart';

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
        if (resultList != null) {
          addPortfolio(
              allHandymanJobsUpload[selectedJobUploadIndex].jobUploadId);
        }
        if (resultCertList != null) {
          addCertification(
              allHandymanJobsUpload[selectedJobUploadIndex].jobUploadId);
        }
        if (resultExperienceList != null) {
          addExperience(
              allHandymanJobsUpload[selectedJobUploadIndex].jobUploadId);
        }

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
            .doc(allHandymanJobsUpload[selectedJobUploadIndex].jobUploadId)
            .update({
          'Deadline': deadline,
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
          'Work Experience & Certification': {
            'Certification': uploadCertList,
            'Experience': uploadExperienceList,
            'Rating': ratingHintText,
            'Reference': uploadReferenceList,
            'Portfolio': uploadPortfolioList,
          },
          'Address Information': {
            'House Number': uploadHouseNum,
            'Street': uploadStreet,
            'Town': uploadTown,
            'Region': uploadRegion,
          },
          'Upload Date':
              '${dateTime.day > 9 ? dateTime.day : '0${dateTime.day}'}-${dateTime.month > 9 ? dateTime.month : '0${dateTime.month}'}-${dateTime.year - 2000}',
          'Upload Time':
              '${dateTime.hour > 9 ? dateTime.hour : '0${dateTime.hour}'}:${dateTime.minute > 9 ? dateTime.minute : '0${dateTime.minute}'}',
        });

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

  bool FieldsCheck() {
    if (chargeController.text.trim().isNotEmpty &&
        chargePHint != 'N/A' &&
        expertHint != 'N/A' &&
        uploadRegion != '' &&
        uploadTown != '' &&
        uploadStreet != '' &&
        uploadHouseNum != '') {
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.black45,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: const Center(
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
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: readData.getHandymanJobUploadItemData(
          allHandymanJobsUpload[selectedJobUploadIndex].jobUploadId,
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
                                        borderRadius: BorderRadius.circular(7),
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
                          SizedBox(height: 30 * screenHeight),
                          JobUploadServiceInfo(
                              serviceProvided:
                                  handymanJobUploadData.serviceProvided,
                              isReadOnly: isJobUploadEditReadOnly,
                              chargeController: chargeController),
                          SizedBox(height: 30 * screenHeight),
                          JobUploadWorkCertInfo(
                            isHandyManUpload: true,
                            isReadOnly: isJobUploadEditReadOnly,
                          ),
                          SizedBox(height: 30 * screenHeight),
                          JobUploadLocationInfo(
                            isReadOnly: isJobUploadEditReadOnly,
                          ),
                          SizedBox(height: 30 * screenHeight),
                        ],
                      ),
                    );
                  },
                  itemCount: 1,
                  shrinkWrap: true,
                ),
              ),
              isJobUploadEditReadOnly
                  ? SizedBox()
                  : UploadButton(
                      screen: uploadJob,
                      isIconPresent: true,
                      icon: Icons.save_rounded,
                      buttonText: 'Save',
                    ),
            ],
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

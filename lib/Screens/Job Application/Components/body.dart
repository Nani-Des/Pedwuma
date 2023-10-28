// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:handyman_app/Screens/Job%20Application/Components/application_references_tab.dart';
import 'package:handyman_app/Screens/Job%20Application/Components/application_summary_details.dart';
import 'package:handyman_app/Screens/Successful/Job%20Application%20Successful/job_application_successful_screen.dart';
import 'package:handyman_app/Services/read_data.dart';
import 'package:handyman_app/constants.dart';

import '../../../Components/appointment_button.dart';
import '../../../Components/appointment_date.dart';
import '../../../Components/appointment_static_time.dart';
import 'application_portfolio_tab.dart';
import 'appointment_charge_details.dart';
import '../../../Components/appointment_tab_row.dart';
import '../../../Components/schedule_address.dart';
import '../../../Components/schedule_day_tab.dart';
import '../../../Components/schedule_note.dart';
import '../../../Components/schedule_time_tab.dart';
import '../../../Components/summary_details.dart';
import '../../Successful/Booking Successful/booking_successful_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

List jobApplicationPortfolioUploadList = [];

class _BodyState extends State<Body> {
  final notesController = TextEditingController();
  final chargeController = TextEditingController();

  @override
  void dispose() {
    notesController.dispose();
    chargeController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    notesController.text = '';
    super.initState();
  }

  void popDialog() {
    Navigator.pop(
      context,
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.black45,
            behavior: SnackBarBehavior.floating,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Center(
              child: Text(
                'One or more required fields has an error. Check them again.',
                style: TextStyle(height: 1.3),
                textAlign: TextAlign.center,
              ),
            )),
      ),
    );
  }

  void _showSummaryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(10),
          backgroundColor: Colors.transparent,
          scrollable: true,
          content: isSummaryClicked
              ? ApplicationSummaryDetails()
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ApplicationSummaryDetails(),
              SizedBox(height: 24 * screenHeight),
              GestureDetector(
                onTap: ((jobApplicationPortfolioList.isEmpty &&
                    allJobItemList[0].isPortfolioPresent) ||
                    (jobApplicationLinks.isEmpty &&
                        allJobItemList[0].isReferencesPresent) ||
                    apppointmentRegion == '' ||
                    apppointmentTown == '' ||
                    apppointmentHouseNum == '' ||
                    apppointmentStreet == '')
                    ? popDialog
                    : applyJob,
                child: Container(
                  height: 49 * screenHeight,
                  width: 312 * screenWidth,
                  decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: sectionColor, width: 3)),
                  child: Center(
                    child: Text(
                      'Apply',
                      style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future uploadPortfolio() async {
    jobApplicationPortfolioUploadList.clear();

    if (resultList != null) {
      for (final resultFile in resultList!.files) {
        final uploadFile = File(resultFile.path!);
        final uploadFileName = resultFile.name;
        final file = await FirebaseStorage.instance
            .ref(
            'Job Application/${allJobItemList[0].jobID}/$loggedInUserId/Portfolio/')
            .child(uploadFileName)
            .putFile(uploadFile);
        final downloadURL = await file.ref.getDownloadURL();
        jobApplicationPortfolioUploadList.add(downloadURL);
        print(downloadURL);
      }
    }
  }

  Future applyJob() async {
    jobHandymanAppliedIDs.clear();
    jobCustomerAppliedIDs.clear();
    jobCustomerOffersIDs.clear();
    jobHandymanOffersIDs.clear();

    try {
      // join customer id to job id to create primary key
      List<String> ids = [loggedInUserId, allJobItemList[0].jobID];
      ids.sort();
      final applierID = ids.join('_');

      // create handyman jobs applied collection
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Handyman Jobs Applied')
          .where('Applier ID', isEqualTo: loggedInUserId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        throw 'You have already applied for this job. You cannot apply for a particular job twice';
      } else {
        await uploadPortfolio();

        await FirebaseFirestore.instance
            .collection('Handyman Jobs Applied')
            .doc(applierID)
            .set({
          'Accepted Date': null,
          'In Progress Date': null,
          'Completed Date': null,
          'Jobs Applied ID': applierID,
          'Job ID': allJobItemList[0].jobID,
          'Applier ID': loggedInUserId,
          'Receiver ID': '',
          'Name': '${allUsers[0].firstName} ${allUsers[0].lastName}',
          'Job Status': 'Applied',
          'Charge': chargeController.text.trim(),
          'Charge Rate': jobApplicationChargeRate,
          'Street': apppointmentStreet,
          'Town': apppointmentTown,
          'House Number': apppointmentHouseNum,
          'Region': apppointmentRegion,
          'Address Type': addressValue,
          'Note': jobApplicationNote,
          'Reference Links': jobApplicationLinks,
          'Portfolio': jobApplicationPortfolioUploadList,
          'User Pic': allUsers[0].pic,
          'Schedule Time': timeList[appointmentTimeIndex],
          'Schedule Date':
          '${dates[appointmentDateIndex].day.toString().padLeft(2, '0')}-${dates[appointmentDateIndex].month.toString().padLeft(2, '0')}-${dates[appointmentDateIndex].year}',
        });
      }

      // add applier id to applied -> handyman

      final document = await FirebaseFirestore.instance
          .collection('Job Application')
          .where('Customer ID', isEqualTo: loggedInUserId)
          .get();
      if (document.docs.isNotEmpty) {
        final docID = document.docs.single.id;
        jobCustomerAppliedIDs =
            document.docs.single.get('Jobs Applied.Customer');
        jobHandymanAppliedIDs =
            document.docs.single.get('Jobs Applied.Handyman');

        // if (!jobHandymanAppliedIDs.contains(allJobItemList[0].jobID)) {

        jobHandymanAppliedIDs.add(applierID);
        await FirebaseFirestore.instance
            .collection('Job Application')
            .doc(docID)
            .update({
          'Jobs Applied': {
            'Customer': jobCustomerAppliedIDs,
            'Handyman': jobHandymanAppliedIDs,
          }
        });
        // } else {
        //   throw Exception();
        // }
      } else {
        jobHandymanAppliedIDs.add(applierID);
        final document =
        await FirebaseFirestore.instance.collection('Job Application').add({
          'Jobs Applied': {
            'Customer': [],
            'Handyman': jobHandymanAppliedIDs,
          },
          'Jobs Upcoming': {
            'Customer': [],
            'Handyman': [],
          },
          'Jobs Completed': {
            'Customer': [],
            'Handyman': [],
          },
          'Job Offers': {
            'Customer': [],
            'Handyman': [],
          },
          'Customer ID': loggedInUserId,
        });

        final docID = document.id;

        await FirebaseFirestore.instance
            .collection('Job Application')
            .doc(docID)
            .update({'Job Application ID': docID});
      }

      // add applier id to offers -> customer

      final customerQuerySnapshot = await FirebaseFirestore.instance
          .collection('Customer Job Upload')
          .where('Job ID', isEqualTo: allJobItemList[0].jobID)
          .get();

      final customerID = customerQuerySnapshot.docs.single.get('Customer ID');

      final docOffers = await FirebaseFirestore.instance
          .collection('Job Application')
          .where('Customer ID', isEqualTo: customerID)
          .get();

      if (docOffers.docs.isNotEmpty) {
        final docID = docOffers.docs.single.id;
        jobCustomerOffersIDs = docOffers.docs.single.get('Job Offers.Customer');
        jobHandymanOffersIDs = docOffers.docs.single.get('Job Offers.Handyman');

        jobCustomerOffersIDs.add(applierID);

        await FirebaseFirestore.instance
            .collection('Job Application')
            .doc(docID)
            .update({
          'Job Offers': {
            'Customer': jobCustomerOffersIDs,
            'Handyman': jobHandymanOffersIDs,
          },
        });
      } else {
        print(jobCustomerOffersIDs);

        jobCustomerOffersIDs.add(applierID);
        print(jobCustomerOffersIDs);
        final document =
        await FirebaseFirestore.instance.collection('Job Application').add({
          'Jobs Applied': {
            'Customer': [],
            'Handyman': [],
          },
          'Jobs Upcoming': {
            'Customer': [],
            'Handyman': [],
          },
          'Jobs Completed': {
            'Customer': [],
            'Handyman': [],
          },
          'Job Offers': {
            'Customer': jobCustomerOffersIDs,
            'Handyman': [],
          },
          'Customer ID': customerID,
        });

        final docID = document.id;

        await FirebaseFirestore.instance
            .collection('Job Application')
            .doc(docID)
            .update({'Job Application ID': docID});
      }

      // add applier id to job upload applier IDs section

      final jobUploadDoc = await FirebaseFirestore.instance
          .collection('Customer Job Upload')
          .where('Job ID', isEqualTo: allJobItemList[0].jobID)
          .get();

      if (jobUploadDoc.docs.isNotEmpty) {
        final docID = jobUploadDoc.docs.single.id;
        List applierIDs =
        jobUploadDoc.docs.single.get('Job Details.Applier IDs');
        var deadlineP = jobUploadDoc.docs.single.get('Job Details.Deadline');
        var jobStatus = jobUploadDoc.docs.single.get('Job Details.Job Status');

        final receiverID = jobUploadDoc.docs.single.get('Customer ID');

        applierIDs.add(applierID);

        await FirebaseFirestore.instance
            .collection('Customer Job Upload')
            .doc(docID)
            .update({
          'Job Details': {
            'Applier IDs': applierIDs,
            'People Applied': applierIDs.length,
            'Deadline': deadlineP,
            'Job Status': jobStatus,
          }
        });

        await FirebaseFirestore.instance
            .collection('Handyman Jobs Applied')
            .doc(applierID)
            .update({'Receiver ID': receiverID});
      } else {
        print('Job upload update failed.');
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => JobApplicationSuccessfulScreen(),
        ),
      );
    } on FirebaseException catch (err) {
      print(err.toString());
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.black45,
            behavior: SnackBarBehavior.floating,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Center(
              child: Text(
                e.toString(),
                style: TextStyle(height: 1.4),
                textAlign: TextAlign.center,
              ),
            )),
      );
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20 * screenHeight),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 92 * screenHeight,
                width: 87.65 * screenWidth,
                decoration: BoxDecoration(
                  color: sectionColor,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(allJobItemList[0].pic),
                  ),
                ),
                child: allJobItemList[0].pic == ''
                    ? Center(
                    child: Icon(
                      Icons.person,
                      color: white,
                      size: 42,
                    ))
                    : SizedBox(),
              ),
              SizedBox(height: 10 * screenHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(
                        minWidth: 1 * screenWidth, maxWidth: 300 * screenWidth),
                    child: Text(
                      allJobItemList[0].fullName,
                      style: TextStyle(
                          color: black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          height: 1.4),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  SizedBox(width: 13 * screenWidth),
                  Icon(
                    Icons.verified_rounded,
                    color: green,
                  ),
                ],
              ),
              SizedBox(height: 14.78 * screenHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Applying for: ',
                    style: TextStyle(
                      color: black,
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 5 * screenWidth),
                  Container(
                    constraints: BoxConstraints(
                        minWidth: 1 * screenWidth, maxWidth: 170 * screenWidth),
                    child: Text(
                      allJobItemList[0].jobService,
                      style: TextStyle(
                        color: primary,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.visible,
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 30 * screenHeight),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppointmentButton(
                text: 'Apply',
                containerColor: primary,
                textColor: white,
                press: () {
                  setState(() {
                    isSummaryClicked = false;
                  });
                  _showSummaryDialog();
                },
              ),
              SizedBox(width: 3 * screenWidth),
              AppointmentButton(
                text: 'Summary',
                containerColor: sectionColor,
                textColor: textGreyColor,
                press: () {
                  setState(() {
                    isSummaryClicked = true;
                  });
                  _showSummaryDialog();
                },
              ),
            ],
          ),
          SizedBox(height: 23 * screenHeight),

          SizedBox(height: 10 * screenHeight),
          ScheduleDayTab(),
          SizedBox(height: 10 * screenHeight),
          ScheduleTimeTab(),
          SizedBox(height: 10 * screenHeight),
          ScheduleAddress(),
          SizedBox(height: 10 * screenHeight),
          ScheduleNote(),
          allJobItemList[0].isPortfolioPresent
              ? SizedBox(height: 10 * screenHeight)
              : SizedBox(),
          allJobItemList[0].isPortfolioPresent
              ? ApplicationPortfolioTab()
              : SizedBox(),
          allJobItemList[0].isReferencesPresent
              ? SizedBox(height: 10 * screenHeight)
              : SizedBox(),
          allJobItemList[0].isReferencesPresent
              ? ApplicationReferencesTab()
              : SizedBox(),
          SizedBox(height: 25 * screenHeight),
        ],
      ),
    );
  }
}

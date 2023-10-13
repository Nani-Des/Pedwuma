// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:handyman_app/Components/pinned_button.dart';
import 'package:handyman_app/Screens/My%20Jobs/SubScreens/JobCompletedHandyman/job_completed_screen.dart';
import 'package:handyman_app/Screens/My%20Jobs/my_jobs_screen.dart';
import 'package:handyman_app/Services/read_data.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../Components/job_details_and_status.dart';
import '../../../../../constants.dart';
import '../../../../Location/location_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late final DateTime accDate;
  late final DateTime progDate;

  Future<void> getUserLocationAndUpload() async {
    // Check location permission
    final permissionStatus = await Permission.location.request();
    if (permissionStatus.isGranted) {
      try {
        // Get current position
        final Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        final document = await FirebaseFirestore.instance
            .collection('Location')
            .where('User ID', isEqualTo: loggedInUserId)
            .get()
            .timeout(Duration(seconds: 30), onTimeout: () {
          throw TimeoutException('Unable to communicate with server');
        });
        if (document.docs.isNotEmpty) {
          final docID = document.docs.single.id;
          await FirebaseFirestore.instance
              .collection('Location')
              .doc(docID)
              .update({
            'Latitude': position.latitude,
            'Longitude': position.longitude,
          });
        } else {
          final locationDoc =
              await FirebaseFirestore.instance.collection('Location').add({
            'Latitude': position.latitude,
            'Longitude': position.longitude,
            'User ID': loggedInUserId,
          });

          final docID = locationDoc.id;
          await FirebaseFirestore.instance
              .collection('Location')
              .doc(docID)
              .update({'Location ID': docID});
        }

        // Display success message or perform any other actions
        print('Location uploaded successfully');
      } catch (e) {
        print('Error getting or uploading location: $e');
      }
    } else {
      print('Location permission not granted');
    }
  }

  @override
  void initState() {
    Timestamp acceptedDate = moreOffers[selectedJob].acceptedDate;
    accDate = acceptedDate.toDate();
    Timestamp inProgressDate = moreOffers[selectedJob].inProgressDate;
    progDate = inProgressDate.toDate();
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
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index) {
              Timestamp acceptedDate = moreOffers[selectedJob].acceptedDate;
              final accDate = acceptedDate.toDate();
              Timestamp inProgressDate = moreOffers[selectedJob].inProgressDate;
              final progDate = inProgressDate.toDate();

              return JobDetailsAndStatus(
                function: () async {
                  await getUserLocationAndUpload();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocationScreen(role: 'Handyman'),
                    ),
                  );
                },
                note: moreOffers[selectedJob].note == ''
                    ? 'N/A'
                    : moreOffers[selectedJob].note,
                isNoteShowing: true,
                statusText: 'Job Accepted',
                buttonText: 'See Location',
                isJobInProgessScreen: true,
                screen: JobCompletedScreen(),
                isJobInProgressActive: true,
                imageLocation: allJobUpcoming[selectedJob].pic,
                name: allJobUpcoming[selectedJob].name,
                region: allJobUpcoming[selectedJob].region,
                chargeRate: allJobUpcoming[selectedJob].chargeRate,
                charge: allJobUpcoming[selectedJob].charge,
                street: allJobUpcoming[selectedJob].street,
                town: allJobUpcoming[selectedJob].town,
                houseNum: allJobUpcoming[selectedJob].houseNum,
                jobType: allJobUpcoming[selectedJob].serviceProvided,
                date: moreOffers[selectedJob].date,
                acceptedDate:
                    '${accDate.day.toString().padLeft(2, '0')}-${accDate.month.toString().padLeft(2, '0')}-${accDate.year}',
                inProgressDate:
                    '${progDate.day.toString().padLeft(2, '0')}-${progDate.month.toString().padLeft(2, '0')}-${progDate.year}',
                completedDate: 'N/A',
              );
            },
          ),
        ),
        PinnedButton(
          function: () async {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  insetPadding:
                      EdgeInsets.symmetric(horizontal: 150 * screenWidth),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      (Platform.isIOS)
                          ? const CupertinoActivityIndicator(
                              radius: 20,
                              color: Color(0xff32B5BD),
                            )
                          : const CircularProgressIndicator(
                              color: Color(0xff32B5BD),
                            ),
                    ],
                  ),
                );
              },
            );
            await ReadData().completeJob();
            isJobUpcomingClicked = false;
            isJobCompletedClicked = true;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyJobsScreen(),
              ),
            );
          },
          buttonText: 'Job Complete',
          isIconPresent: true,
        )
      ],
    );
  }
}

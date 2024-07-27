import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handyman_app/Components/job_details_and_status.dart';
import 'package:handyman_app/Components/pinned_button.dart';
import 'package:handyman_app/Screens/My%20Jobs/SubScreens/JobCompletedHandyman/job_completed_screen.dart';
import 'package:handyman_app/Screens/My%20Jobs/my_jobs_screen.dart';
import 'package:handyman_app/Services/read_data.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
                note: moreOffers[selectedJob].note == ''
                    ? 'N/A'
                    : moreOffers[selectedJob].note,
                isNoteShowing: true,
                statusText: 'Job Accepted',
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

// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:handyman_app/Screens/My%20Jobs/SubScreens/JobUpcoming/job_upcoming.dart';
import 'package:handyman_app/Screens/My%20Jobs/my_jobs_screen.dart';
import 'package:handyman_app/Services/read_data.dart';
import 'package:handyman_app/constants.dart';
import '../../../../../Components/job_details_and_status.dart';

class Body extends StatelessWidget {
  Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void deleteDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
                child: Text(
              'Delete Job Application',
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
                    'Are you sure you want to delete this Job Application?',
                    style: TextStyle(
                      height: 1.4,
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
                      onTap: () async {
                        await ReadData()
                            .deleteJobApplication('Customer Uploaded');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyJobsScreen(),
                          ),
                        );
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

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: JobDetailsAndStatus(
        function: deleteDialog,
        isJobAppliedScreen: true,
        isJobPendingActive: true,
        screen: JobUpcomingScreen(),
        imageLocation: allJobApplied[selectedJob].pic,
        name: allJobApplied[selectedJob].name,
        region: allJobApplied[selectedJob].region,
        chargeRate: allJobApplied[selectedJob].chargeRate,
        charge: allJobApplied[selectedJob].charge,
        street: allJobApplied[selectedJob].street,
        town: allJobApplied[selectedJob].town,
        houseNum: allJobApplied[selectedJob].houseNum,
        jobType: allJobApplied[selectedJob].serviceProvided,
        date: allJobApplied[selectedJob].uploadDate,
        acceptedDate: allJobApplied[selectedJob].uploadDate,
        inProgressDate: 'N/A',
        completedDate: 'N/A',
      ),
    );
  }
}

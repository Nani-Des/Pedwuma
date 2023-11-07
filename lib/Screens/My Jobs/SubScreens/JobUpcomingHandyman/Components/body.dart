// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:handyman_app/Components/pinned_button.dart';
import 'package:handyman_app/Screens/My%20Jobs/SubScreens/JobInProgressHandyman/job_in_progress_screen.dart';
import 'package:handyman_app/Services/read_data.dart';

import '../../../../../Components/job_details_and_status.dart';
import '../../../../../constants.dart';
import '../../../my_jobs_screen.dart';
import '../../JobUpcoming/Components/body.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late final DateTime accDate;
  Future startJob() async {
    final jobsAppliedID = moreOffers[selectedJob].documentID;
    if (moreOffers[selectedJob].whoApplied == 'Customer') {
      await FirebaseFirestore.instance
          .collection('Bookings')
          .doc(jobsAppliedID)
          .update(
        {
          'Job Status': 'Ongoing',
          'In Progress Date': Timestamp.now(),
        },
      );
    } else {
      await FirebaseFirestore.instance
          .collection('Applications')
          .doc(jobsAppliedID)
          .update(
        {
          'Job Status': 'Ongoing',
          'In Progress Date': Timestamp.now(),
        },
      );
    }
  }

  @override
  void initState() {
    rescheduleDate = '';
    rescheduleTime = '';
    Timestamp acceptedDate = moreOffers[selectedJob].acceptedDate;
    accDate = acceptedDate.toDate();
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
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (context, index) {
              return moreOffers[selectedJob].whoApplied == 'Customer'
                  ? JobDetailsAndStatus(
                      note: moreOffers[selectedJob].note == ''
                          ? 'N/A'
                          : moreOffers[selectedJob].note,
                      isNoteShowing: true,
                      declineFunction: () async {
                        await ReadData().deleteJobUpcoming('Handyman Uploaded');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyJobsScreen(),
                          ),
                        );
                      },
                      isJobPendingActive: true,
                      screen: JobInProgressScreen(),
                      isJobOfferScreen: true,
                      buttonText: 'Reschedule',
                      statusText: 'Job Accepted',
                      imageLocation: moreOffers[selectedJob].pic,
                      name: moreOffers[selectedJob].name,
                      region: moreOffers[selectedJob].region,
                      chargeRate: allJobUpcoming[selectedJob].chargeRate,
                      charge: allJobUpcoming[selectedJob].charge,
                      street: moreOffers[selectedJob].street,
                      town: moreOffers[selectedJob].town,
                      houseNum: moreOffers[selectedJob].houseNum,
                      jobType: allJobUpcoming[selectedJob].serviceProvided,
                      date: moreOffers[selectedJob].date,
                      acceptedDate:
                          '${accDate.day.toString().padLeft(2, '0')}-${accDate.month.toString().padLeft(2, '0')}-${accDate.year}',
                      inProgressDate: 'N/A',
                      completedDate: 'N/A',
                    )
                  : JobDetailsAndStatus(
                      note: 'N/A',
                      isNoteShowing: true,
                      declineFunction: () async {
                        await ReadData().deleteJobUpcoming('Customer Uploaded');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyJobsScreen(),
                          ),
                        );
                      },
                      isJobPendingActive: true,
                      screen: JobInProgressScreen(),
                      isJobOfferScreen: true,
                      buttonText: 'Reschedule',
                      statusText: 'Job Accepted',
                      imageLocation: moreOffers[selectedJob].pic,
                      name: moreOffers[selectedJob].name,
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
                      inProgressDate: 'N/A',
                      completedDate: 'N/A',
                    );
            },
          ),
        ),
        PinnedButton(
          function: () async {
            await startJob();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyJobsScreen(),
              ),
            );
          },
          buttonText: 'Start',
          isIconPresent: true,
        ),
      ],
    );
  }
}

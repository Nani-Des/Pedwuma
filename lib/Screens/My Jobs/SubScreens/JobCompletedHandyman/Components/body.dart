// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:handyman_app/Screens/My%20Jobs/my_jobs_screen.dart';
//import 'package:handyman_app/Screens/Payment/PaymentOptions/payment_options_screen.dart';

import '../../../../../Components/job_details_and_status.dart';
import '../../../../../Components/pinned_button.dart';
import '../../../../../Services/read_data.dart';
import '../../../../../constants.dart';
import '../../JobInProgress/job_in_progress_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late final DateTime accDate;
  late final DateTime progDate;
  late final DateTime compleDate;

  @override
  void initState() {
    Timestamp acceptedDate = moreOffers[selectedJob].acceptedDate;
    accDate = acceptedDate.toDate();
    Timestamp inProgressDate = moreOffers[selectedJob].inProgressDate;
    progDate = inProgressDate.toDate();
    Timestamp completedDate = moreOffers[selectedJob].completedDate;
    compleDate = completedDate.toDate();
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
                      isJobCompletedAcitve: true,
                      isJobPendingActive: false,
                      screen: JobInProgressScreen(),
                      isJobOfferScreen: false,
                      statusText: 'Job Accepted',
                      imageLocation: moreOffers[selectedJob].pic,
                      name: moreOffers[selectedJob].name,
                      region: moreOffers[selectedJob].region,
                      chargeRate: allJobCompleted[selectedJob].chargeRate,
                      charge: allJobCompleted[selectedJob].charge,
                      street: moreOffers[selectedJob].street,
                      town: moreOffers[selectedJob].town,
                      houseNum: moreOffers[selectedJob].houseNum,
                      jobType: allJobCompleted[selectedJob].serviceProvided,
                      date: moreOffers[selectedJob].date,
                      acceptedDate:
                          '${accDate.day.toString().padLeft(2, '0')}-${accDate.month.toString().padLeft(2, '0')}-${accDate.year}',
                      inProgressDate:
                          '${progDate.day.toString().padLeft(2, '0')}-${progDate.month.toString().padLeft(2, '0')}-${progDate.year}',
                      completedDate:
                          '${compleDate.day.toString().padLeft(2, '0')}-${compleDate.month.toString().padLeft(2, '0')}-${compleDate.year}',
                    )
                  : JobDetailsAndStatus(
                      isJobCompletedAcitve: true,
                      isJobPendingActive: false,
                      screen: JobInProgressScreen(),
                      isJobOfferScreen: false,
                      statusText: 'Job Accepted',
                      imageLocation: allJobCompleted[selectedJob].pic,
                      name: allJobCompleted[selectedJob].name,
                      region: allJobCompleted[selectedJob].region,
                      chargeRate: allJobCompleted[selectedJob].chargeRate,
                      charge: allJobCompleted[selectedJob].charge,
                      street: allJobCompleted[selectedJob].street,
                      town: allJobCompleted[selectedJob].town,
                      houseNum: allJobCompleted[selectedJob].houseNum,
                      jobType: allJobCompleted[selectedJob].serviceProvided,
                      date: moreOffers[selectedJob].date,
                      acceptedDate:
                          '${accDate.day.toString().padLeft(2, '0')}-${accDate.month.toString().padLeft(2, '0')}-${accDate.year}',
                      inProgressDate:
                          '${progDate.day.toString().padLeft(2, '0')}-${progDate.month.toString().padLeft(2, '0')}-${progDate.year}',
                      completedDate:
                          '${compleDate.day.toString().padLeft(2, '0')}-${compleDate.month.toString().padLeft(2, '0')}-${compleDate.year}',
                    );
            },
          ),
        ),
        moreOffers[selectedJob].jobStatus == 'Paid'
            ? SizedBox()
            : PinnedButton(
                function: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        insetPadding:
                            EdgeInsets.symmetric(horizontal: 10 * screenWidth),
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image(
                                image: AssetImage(
                                    'assets/images/notification_sent.gif')),
                            SizedBox(height: 15 * screenHeight),
                            Text(
                              'Notification Sent!',
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
                        builder: (context) => MyJobsScreen(),
                      ),
                    );
                  });
                },
                buttonText: 'Request Payment',
                isIconPresent: true,
              ),
      ],
    );
  }
}

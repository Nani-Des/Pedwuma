// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handyman_app/Components/pinned_button.dart';
import 'package:handyman_app/Screens/Bookings/customer_bookings_screen.dart';
import 'package:handyman_app/Screens/My%20Jobs/SubScreens/JobInProgress/job_in_progress_screen.dart';
import 'package:handyman_app/Screens/My%20Jobs/SubScreens/JobUpcoming/job_upcoming.dart';
import 'package:handyman_app/Services/read_data.dart';

import '../../../../../Components/job_details_and_status.dart';
import '../../../../../Components/profile_item.dart';
import '../../../../../constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

String rescheduleDate = '';
String rescheduleTime = '';

class _BodyState extends State<Body> {
  late final DateTime accDate;
  @override
  void initState() {
    rescheduleDate = '';
    rescheduleTime = '';
    Timestamp acceptedDate = moreOffers[selectedJob].acceptedDate;
    accDate = acceptedDate.toDate();
    super.initState();
  }

  Future startJob() async {
    final jobsAppliedID = moreOffers[selectedJob].documentID;
    if (moreOffers[selectedJob].whoApplied == 'Customer') {
      await FirebaseFirestore.instance
          .collection('Customer Jobs Applied')
          .doc(jobsAppliedID)
          .update(
        {
          'Job Status': 'Ongoing',
          'In Progress Date': Timestamp.now(),
        },
      );
    } else {
      await FirebaseFirestore.instance
          .collection('Handyman Jobs Applied')
          .doc(jobsAppliedID)
          .update(
        {
          'Job Status': 'Ongoing',
          'In Progress Date': Timestamp.now(),
        },
      );
    }
  }

  void rescheduleDialogBox(String type) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AlertDialog(
                insetPadding: EdgeInsets.all(10),
                backgroundColor: Colors.transparent,
                content: Container(
                  constraints: BoxConstraints(minWidth: 50 * screenHeight),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: white, borderRadius: BorderRadius.circular(24)),
                  padding: EdgeInsets.symmetric(
                    vertical: 22 * screenWidth,
                    horizontal: 20.5 * screenWidth,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Center(
                        child: Text(
                          'Reschedule Information',
                          style: TextStyle(
                            color: black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 10 * screenHeight),
                      Text(
                        'Date',
                        style: TextStyle(
                          color: primary,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 7 * screenHeight),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 49 * screenHeight,
                            width: 150 * screenWidth,
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                  color: appointmentTimeColor, width: 1),
                            ),
                            child: Center(
                              child: Text(
                                rescheduleDate == ''
                                    ? 'DD/MM/YYYY'
                                    : rescheduleDate,
                                style: TextStyle(
                                    color: black,
                                    fontSize: 16,
                                    fontWeight: rescheduleDate == ''
                                        ? FontWeight.w200
                                        : FontWeight.w400),
                              ),
                            ),
                          ),
                          SizedBox(width: 14 * screenWidth),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showDatePicker(
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2024),
                                  context: context,
                                ).then((date) {
                                  setState(() {
                                    rescheduleDate =
                                        "${date!.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
                                  });
                                });
                              });
                            },
                            child: Container(
                              height: 49 * screenHeight,
                              width: 70 * screenWidth,
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                    color: appointmentTimeColor, width: 1),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.calendar_month_rounded,
                                  color: primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20 * screenHeight),
                      Text(
                        'Time',
                        style: TextStyle(
                          color: primary,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 7 * screenHeight),
                      GestureDetector(
                        onTap: () {
                          showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now())
                              .then((time) {
                            setState(() {
                              rescheduleTime =
                                  '${time!.hour > 12 ? (time.hour - 12).toString().padLeft(2, '0') : time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} ${time.hour > 12 ? 'PM' : 'AM'}';
                            });
                          });
                        },
                        child: Container(
                          height: 49 * screenHeight,
                          width: double.infinity * screenWidth,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                                color: appointmentTimeColor, width: 1),
                          ),
                          child: Center(
                            child: Text(
                              rescheduleTime == ''
                                  ? 'Choose Time'
                                  : rescheduleTime,
                              style: TextStyle(
                                  color: primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10 * screenHeight),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await ReadData().rescheduleJob(type);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomerBookingsScreen(),
                      ));
                },
                child: Container(
                  height: 49 * screenHeight,
                  width: 273 * screenWidth,
                  decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: sectionColor, width: 3)),
                  child: Center(
                    child: Text(
                      'Reschedule',
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
              Timestamp acceptedDate = moreOffers[selectedJob].acceptedDate;
              final accDate = acceptedDate.toDate();

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
                            builder: (context) => CustomerBookingsScreen(),
                          ),
                        );
                      },
                      function: () {
                        rescheduleDialogBox('Handyman Uploaded');
                      },
                      isJobPendingActive: true,
                      screen: JobInProgressScreen(),
                      isJobOfferScreen: true,
                      buttonText: 'Reschedule',
                      statusText: 'Job Accepted',
                      imageLocation: allJobUpcoming[selectedJob].pic,
                      name: allJobUpcoming[selectedJob].name,
                      region: moreOffers[selectedJob].region,
                      chargeRate: allJobUpcoming[selectedJob].chargeRate,
                      charge: allJobUpcoming[selectedJob].charge,
                      street: moreOffers[selectedJob].street,
                      town: moreOffers[selectedJob].town,
                      houseNum: moreOffers[selectedJob].houseNum,
                      jobType: allJobUpcoming[selectedJob].serviceProvided,
                      date: moreOffers[selectedJob].date,
                      acceptedDate:
                          '${accDate.day}-${accDate.month}-${accDate.year}',
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
                            builder: (context) => CustomerBookingsScreen(),
                          ),
                        );
                      },
                      function: () {
                        rescheduleDialogBox('Customer Uploaded');
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
                builder: (context) => CustomerBookingsScreen(),
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

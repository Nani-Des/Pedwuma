import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handyman_app/Screens/Bookings/Components/job_bookings_tabs.dart';
import 'package:handyman_app/Screens/My%20Jobs/SubScreens/JobInProgress/job_in_progress_screen.dart';
import 'package:handyman_app/Services/read_data.dart';
import '../../../Components/offers_and_widgets.dart';
import '../../../constants.dart';
import '../../My Jobs/Components/my_job_items.dart';
import '../../My Jobs/SubScreens/JobCompleted/job_completed_screen.dart';
import '../../My Jobs/SubScreens/JobUpcoming/job_upcoming.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ReadData readData = ReadData();

  Future allData() async {
    if (isJobOffersClicked == true) {
      await readData.getHandymanJobApplicationData(
          'Job Offers', 'Customer', context);
      await readData.getCustomerJobApplicationData(
          'Jobs Applied', 'Customer', context);
      print('Job Offers: $allJobOffers');
      print('Jobs Applied: $allJobApplied');
    }
    if (isJobUpcomingClicked == true) {
      await readData.getUpcomingJobData('Jobs Upcoming', 'Customer', context);
    }
    if (isJobCompletedClicked == true) {
      await readData.getUpcomingJobData('Jobs Completed', 'Customer', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: allData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 15 * screenHeight),
                  JobBookingsTab(
                    upcomingCallback: () {
                      setState(() {
                        isJobUpcomingClicked = !isJobUpcomingClicked;
                      });
                      if (isJobUpcomingClicked == true) {
                        isJobCompletedClicked = false;
                        isJobOffersClicked = false;
                      }
                      if (isJobCompletedClicked == false &&
                          isJobOffersClicked == false)
                        isJobUpcomingClicked = true;
                    },
                    offersCallback: () {
                      setState(() {
                        isJobOffersClicked = !isJobOffersClicked;
                      });
                      if (isJobOffersClicked == true) {
                        isJobCompletedClicked = false;
                        isJobUpcomingClicked = false;
                      }
                      if (isJobCompletedClicked == false &&
                          isJobUpcomingClicked == false)
                        isJobOffersClicked = true;
                    },
                    completedCallback: () {
                      setState(() {
                        isJobCompletedClicked = !isJobCompletedClicked;
                      });
                      if (isJobCompletedClicked == true) {
                        isJobUpcomingClicked = false;
                        isJobOffersClicked = false;
                      }
                      if (isJobUpcomingClicked == false &&
                          isJobOffersClicked == false)
                        isJobCompletedClicked = true;
                    },
                  ),
                  SizedBox(height: 25 * screenHeight),
                  if (isJobUpcomingClicked == true)
                    allJobUpcoming.isNotEmpty
                        ? ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return moreOffers[index].whoApplied == 'Customer'
                                  ? MyJobItems(
                                      index: index,
                                      screen: (moreOffers[index].jobStatus ==
                                                  'Accepted' ||
                                              moreOffers[index].jobStatus ==
                                                  'Rescheduled')
                                          ? JobUpcomingScreen()
                                          : JobInProgressScreen(),
                                      name: allJobUpcoming[index].name,
                                      imageLocation: allJobUpcoming[index].pic,
                                      serviceCat:
                                          allJobUpcoming[index].serviceProvided,
                                      date: allJobUpcoming[index].uploadDate,
                                      time: allJobUpcoming[index].uploadTime,
                                      orderStatus:
                                          moreOffers[index].jobStatus ==
                                                  'Accepted'
                                              ? 'View Order'
                                              : moreOffers[index].jobStatus ==
                                                      'Rescheduled'
                                                  ? 'Rescheduled'
                                                  : 'Ongoing',
                                    )
                                  : MyJobItems(
                                      index: index,
                                      screen: (moreOffers[index].jobStatus ==
                                                  'Accepted' ||
                                              moreOffers[index].jobStatus ==
                                                  'Rescheduled')
                                          ? JobUpcomingScreen()
                                          : JobInProgressScreen(),
                                      name: moreOffers[index].name,
                                      imageLocation: moreOffers[index].pic,
                                      serviceCat:
                                          allJobUpcoming[index].serviceProvided,
                                      date: allJobUpcoming[index].uploadDate,
                                      time: allJobUpcoming[index].uploadTime,
                                      orderStatus:
                                          moreOffers[index].jobStatus ==
                                                  'Accepted'
                                              ? 'View Order'
                                              : moreOffers[index].jobStatus ==
                                                      'Rescheduled'
                                                  ? 'Rescheduled'
                                                  : 'Ongoing',
                                    );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 20 * screenHeight,
                              );
                            },
                            itemCount: allJobUpcoming.length)
                        : Center(
                            child: Text(
                              AppLocalizations.of(context)!.bv,
                              style: TextStyle(
                                color: primary,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                  if (isJobOffersClicked == true)
                    (allJobOffers.isEmpty && allJobApplied.isEmpty)
                        ? Center(
                            child: Text(
                              AppLocalizations.of(context)!.bw,
                              style: TextStyle(
                                color: primary,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : OffersAndAppliedWidget(),
                  if (isJobCompletedClicked == true)
                    allJobCompleted.isEmpty
                        ? Center(
                            child: Text(
                              AppLocalizations.of(context)!.bx,
                              style: TextStyle(
                                color: primary,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return moreOffers[index].whoApplied == 'Customer'
                                  ? MyJobItems(
                                      index: index,
                                      screen: JobCompletedScreen(),
                                      name: allJobCompleted[index].name,
                                      imageLocation: allJobCompleted[index].pic,
                                      serviceCat: allJobCompleted[index]
                                          .serviceProvided,
                                      date: allJobCompleted[index].uploadDate,
                                      time: allJobCompleted[index].uploadTime,
                                      orderStatus: moreOffers[index].jobStatus,
                                    )
                                  : MyJobItems(
                                      index: index,
                                      screen: JobCompletedScreen(),
                                      name: moreOffers[index].name,
                                      imageLocation: moreOffers[index].pic,
                                      serviceCat: allJobCompleted[index]
                                          .serviceProvided,
                                      date: allJobCompleted[index].uploadDate,
                                      time: allJobCompleted[index].uploadTime,
                                      orderStatus: moreOffers[index].jobStatus,
                                    );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 20 * screenHeight,
                              );
                            },
                            itemCount: allJobCompleted.length),
                ],
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Platform.isIOS
                  ? CupertinoActivityIndicator(color: primary)
                  : CircularProgressIndicator(color: primary),
            );
          }
          return Center(
            child: Platform.isIOS
                ? CupertinoActivityIndicator(color: primary)
                : CircularProgressIndicator(color: primary),
          );
        });
  }
}

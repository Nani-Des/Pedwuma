import 'package:flutter/material.dart';

import '../Screens/My Jobs/Components/my_job_items.dart';
import '../Screens/My Jobs/SubScreens/JobAppliedHandyman/job_applied_screen.dart';
import '../Screens/My Jobs/SubScreens/JobOfferHandyman/job_offer_screen.dart';
import '../Services/read_data.dart';
import '../constants.dart';

class OffersAndAppliedWidgetAlt extends StatefulWidget {
  const OffersAndAppliedWidgetAlt({Key? key}) : super(key: key);

  @override
  State<OffersAndAppliedWidgetAlt> createState() =>
      _OffersAndAppliedWidgetState();
}

class _OffersAndAppliedWidgetState extends State<OffersAndAppliedWidgetAlt> {
  bool isOffersShowing = true;
  bool isAppliedShowing = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        allJobOffers.isEmpty
            ? SizedBox()
            : Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 15.0, right: 15 * screenWidth),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Job Offers',
                      style: TextStyle(
                        color: black,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isOffersShowing = !isOffersShowing;
                        });
                      },
                      child: Container(
                        height: 37 * screenHeight,
                        width: 37 * screenWidth,
                        decoration: BoxDecoration(
                          color: white,
                          border:
                              Border.all(color: appointmentTimeColor, width: 1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            isOffersShowing
                                ? Icons.keyboard_arrow_down_sharp
                                : Icons.keyboard_arrow_right_sharp,
                            color: primary,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        allJobOffers.isEmpty ? SizedBox() : SizedBox(height: 15 * screenHeight),
        allJobOffers.isEmpty
            ? SizedBox()
            : Center(
                child: Container(
                  margin: EdgeInsets.only(left: 9 * screenWidth),
                  height: 1 * screenHeight,
                  width: 350 * screenWidth,
                  color: grey,
                ),
              ),
        allJobOffers.isEmpty ? SizedBox() : SizedBox(height: 25 * screenHeight),
        isOffersShowing
            ? ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return MyJobItems(
                    index: index,
                    screen: JobOfferScreen(),
                    name: moreOffers[index].name,
                    imageLocation: moreOffers[index].pic,
                    serviceCat: allJobOffers[index].serviceProvided,
                    date: allJobOffers[index].uploadDate,
                    time: allJobOffers[index].uploadTime,
                    orderStatus: 'View Offer',
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 20 * screenHeight,
                  );
                },
                itemCount: allJobOffers.length)
            : SizedBox(),
        allJobOffers.isEmpty
            ? SizedBox()
            : isOffersShowing
                ? SizedBox(height: 35 * screenHeight)
                : SizedBox(),
        allJobApplied.isEmpty
            ? SizedBox()
            : Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 15.0, right: 15 * screenWidth),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Jobs Applied',
                      style: TextStyle(
                        color: black,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isAppliedShowing = !isAppliedShowing;
                        });
                      },
                      child: Container(
                        height: 37 * screenHeight,
                        width: 37 * screenWidth,
                        decoration: BoxDecoration(
                          color: white,
                          border:
                              Border.all(color: appointmentTimeColor, width: 1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            isAppliedShowing
                                ? Icons.keyboard_arrow_down_sharp
                                : Icons.keyboard_arrow_right_sharp,
                            color: primary,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        SizedBox(height: 15 * screenHeight),
        allJobApplied.isEmpty
            ? SizedBox()
            : Center(
                child: Container(
                  margin: EdgeInsets.only(left: 9 * screenWidth),
                  height: 1 * screenHeight,
                  width: 350 * screenWidth,
                  color: grey,
                ),
              ),
        SizedBox(height: 25 * screenHeight),
        isAppliedShowing
            ? ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return MyJobItems(
                    index: index,
                    screen: JobAppliedScreen(),
                    name: allJobApplied[index].name,
                    imageLocation: allJobApplied[index].pic,
                    serviceCat: allJobApplied[index].serviceProvided,
                    date: allJobApplied[index].uploadDate,
                    time: allJobApplied[index].uploadTime,
                    orderStatus: 'View Status',
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 20 * screenHeight,
                  );
                },
                itemCount: allJobApplied.length)
            : SizedBox(),
      ],
    );
  }
}

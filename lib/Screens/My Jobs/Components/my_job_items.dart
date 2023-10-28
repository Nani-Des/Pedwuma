import 'package:flutter/material.dart';
import 'package:handyman_app/Screens/My%20Jobs/SubScreens/JobOffer/job_offer_screen.dart';

import '../../../constants.dart';

class MyJobItems extends StatelessWidget {
  final int index;
  final Widget screen;
  final String name;
  final String imageLocation;
  final String serviceCat;
  final String date;
  final String time;
  final String orderStatus;
  const MyJobItems({
    Key? key,
    required this.name,
    required this.imageLocation,
    required this.serviceCat,
    required this.date,
    required this.time,
    required this.orderStatus,
    required this.screen,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          selectedJob = index;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => screen,
              ));
        },
        child: Container(
          height: 91 * screenHeight,
          width: 375 * screenWidth,
          decoration: BoxDecoration(
            color: sectionColor,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.only(
            left: 20 * screenWidth,
            top: 16 * screenHeight,
            bottom: 17 * screenHeight,
            right: 20 * screenWidth,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 58 * screenHeight,
                width: 55.26 * screenWidth,
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(6.3),
                    border: Border.all(color: appointmentTimeColor, width: 1),
                    image: DecorationImage(
                      image: NetworkImage(imageLocation),
                      fit: BoxFit.cover,
                    )),
                child: imageLocation == ''
                    ? Center(
                        child: Icon(
                          Icons.person,
                          color: grey,
                        ),
                      )
                    : null,
              ),
              SizedBox(width: 17.74 * screenWidth),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 3.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 140 * screenWidth,
                      child: Text(
                        name,
                        style: TextStyle(
                          color: black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.fade,
                        softWrap: false,
                      ),
                    ),
                    SizedBox(height: 0 * screenHeight),
                    SizedBox(
                      width: 140 * screenWidth,
                      child: Text(
                        serviceCat,
                        style: TextStyle(
                          color: black,
                          fontSize: 16,
                          fontWeight: FontWeight.w200,
                        ),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
              //in case of error: remove space and comment 17 sizedbox
              Spacer(),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 110 * screenWidth,
                      child: Text(
                        '$date || $time',
                        style: TextStyle(
                          color: black,
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                        ),
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                      ),
                    ),
                    SizedBox(height: 8 * screenHeight),
                    SizedBox(
                      width: 110 * screenWidth,
                      child: Text(
                        orderStatus,
                        style: TextStyle(
                          color: primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

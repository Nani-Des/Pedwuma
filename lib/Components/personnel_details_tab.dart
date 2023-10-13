// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:handyman_app/Components/personnel_rating_summary.dart';
import 'package:handyman_app/Screens/Appointment/appointment_screen.dart';
import 'package:handyman_app/Services/read_data.dart';

import '../constants.dart';

class PersonnelDetailsTab extends StatelessWidget {
  const PersonnelDetailsTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: BoxConstraints(minHeight: 194 * screenHeight),
      height: 194 * screenHeight,
      width: 390 * screenWidth,
      decoration: BoxDecoration(
        color: sectionColor,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
      ),
      padding: EdgeInsets.only(
          left: 20.0 * screenHeight,
          top: 0 * screenHeight,
          bottom: 13 * screenHeight,
          right: 13 * screenWidth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 97 * screenHeight,
            width: 86 * screenWidth,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(10),
              border: allJobItemList[0].pic == ''
                  ? Border.all(color: appointmentTimeColor, width: 1)
                  : null,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(allJobItemList[0].pic),
              ),
            ),
            child: allJobItemList[0].pic == ''
                ? Center(
                    child: Icon(
                    Icons.person,
                    color: grey,
                    size: 40,
                  ))
                : null,
          ),
          SizedBox(width: 10.35 * screenWidth),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 21.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 147 * screenWidth,
                  child: Text(
                    allJobItemList[0].fullName,
                    style: TextStyle(
                      color: black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 11 * screenHeight),
                PersonnelRatingSummary(rating: allJobItemList[0].rating),
                SizedBox(height: screenHeight * 1),
                Text(
                  '149.5 km',
                  style: TextStyle(
                      color: black, fontSize: 15, fontWeight: FontWeight.w700),
                ),
                Text(
                  'away from you',
                  style: TextStyle(
                      fontSize: 8, fontWeight: FontWeight.w300, color: black),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 40.0),
                  child: Container(
                    height: 4 * screenHeight,
                    width: 59 * screenWidth,
                    decoration: BoxDecoration(
                        color: grey, borderRadius: BorderRadius.circular(6)),
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                '\$${allJobItemList[0].charge}/' + allJobItemList[0].chargeRate,
                style: TextStyle(
                  color: primary,
                  fontSize: 21.64,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 15 * screenHeight),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppointmentScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 47 * screenHeight,
                  width: 109 * screenWidth,
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: [
                      BoxShadow(
                        color: black.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Book Now!',
                      style: TextStyle(
                          color: white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

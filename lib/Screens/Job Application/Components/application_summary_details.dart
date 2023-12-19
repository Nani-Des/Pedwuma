// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:handyman_app/Components/schedule_day_tab.dart';
import 'package:handyman_app/Components/schedule_time_tab.dart';
import 'package:handyman_app/Screens/Job%20Application/Components/application_portfolio_tab.dart';
import 'package:handyman_app/Screens/Job%20Application/Components/appointment_charge_details.dart';

import '../../../Components/summary_element.dart';
import '../../../Services/read_data.dart';
import '../../../constants.dart';

class ApplicationSummaryDetails extends StatelessWidget {
  const ApplicationSummaryDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.only(
        left: 24 * screenWidth,
        right: 23 * screenWidth,
        top: 21 * screenHeight,
        bottom: 25 * screenHeight,
      ),
      // height: 357 * screenHeight,
      width: 316 * screenWidth,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Flexible(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SummaryElement(
                title: 'Name',
                subtitle: allUsers[0].firstName + ' ' + allUsers[0].lastName),
            SizedBox(height: 15 * screenHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SummaryElement(
                    title: 'Charge',
                    subtitle: '\₵ ${allJobItemList[0].charge}'),
                SummaryElement(
                    title: 'Charge per', subtitle: jobApplicationChargeRate),
              ],
            ),
            SizedBox(height: 15 * screenHeight),
            SummaryElement(
                title: 'Job', subtitle: allJobItemList[0].jobService),
            SizedBox(height: 15 * screenHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SummaryElement(
                  title: 'Date',
                  subtitle:
                      '${dates[selectedDay].day > 9 ? dates[selectedDay].day : '0${dates[selectedDay].day}'}-${dates[selectedDay].month > 9 ? dates[selectedDay].month : '0${dates[selectedDay].month}'}-${dates[selectedDay].year}',
                ),
                Padding(
                  padding: EdgeInsets.only(right: screenWidth * 8.0),
                  child: SummaryElement(
                      title: 'Time', subtitle: timeList[selectedTime]),
                ),
              ],
            ),
            SizedBox(height: 15 * screenHeight),
            Text(
              'Address',
              style: TextStyle(
                color: primary,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 4 * screenHeight),
            (apppointmentRegion == '' ||
                    apppointmentTown == '' ||
                    apppointmentHouseNum == '' ||
                    apppointmentStreet == '')
                ? Text(
                    'Address is incomplete or empty',
                    style: TextStyle(
                      color: red,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  )
                : Text(
                    '$apppointmentHouseNum, $apppointmentStreet,\n'
                            '$apppointmentTown,\n'
                            '$apppointmentRegion,GHANA \n($addressValue)'
                        .toUpperCase(),
                    style: TextStyle(
                      color: black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
            SizedBox(height: 15 * screenHeight),
            SummaryElement(
              title: 'Note',
              subtitle: (jobApplicationNote == '')
                  ? 'No notes present.'
                  : '$jobApplicationNote\n\nThank you.',
            ),
            (allJobItemList[0].isPortfolioPresent == false)
                ? SizedBox()
                : SizedBox(height: 15 * screenHeight),
            (allJobItemList[0].isPortfolioPresent == false)
                ? SizedBox()
                : (jobApplicationPortfolioList.isNotEmpty)
                    ? Text(
                        'Portfolio present',
                        style: TextStyle(
                          color: primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      )
                    : Text(
                        'No portfolio present. Add portfolio.',
                        style: TextStyle(
                          color: red,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
            (allJobItemList[0].isReferencesPresent == false)
                ? SizedBox()
                : SizedBox(height: 15 * screenHeight),
            (allJobItemList[0].isReferencesPresent == false)
                ? SizedBox()
                : (jobApplicationLinks.isNotEmpty)
                    ? Text(
                        'References present',
                        style: TextStyle(
                          height: 1.3,
                          color: primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      )
                    : Text(
                        'No references present. Add references.',
                        style: TextStyle(
                          height: 1.3,
                          color: red,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}

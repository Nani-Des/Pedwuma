import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../constants.dart';

class AppointmentJobDetails extends StatelessWidget {
  final String jobType;
  final String date;
  final String houseNum;
  final String street;
  final String town;
  final String region;
  String? note;
  bool isNoteShowing;
  AppointmentJobDetails({
    Key? key,
    required this.jobType,
    required this.date,
    required this.houseNum,
    required this.street,
    required this.town,
    required this.region,
    this.note,
    this.isNoteShowing = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          minHeight: 274 * screenHeight,
        ),
        width: 383 * screenWidth,
        decoration: BoxDecoration(
          color: sectionColor,
          borderRadius: BorderRadius.circular(6),
        ),
        padding: EdgeInsets.only(
          left: 30 * screenWidth,
          right: 26 * screenWidth,
          top: 23 * screenHeight,
          bottom: 20 * screenHeight,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)!.ec,
                  style: TextStyle(
                    color: black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  height: 31 * screenHeight,
                  width: 30 * screenWidth,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(color: primary, width: 2),
                  ),
                  child: Center(
                    child: Image.asset('assets/icons/i_logo.png'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12 * screenHeight),
            Text(
              AppLocalizations.of(context)!.jobs,
              style: TextStyle(
                color: primary,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4 * screenHeight),
            Text(
              jobType,
              style: TextStyle(
                color: black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12 * screenHeight),
            Text(
              AppLocalizations.of(context)!.date,
              style: TextStyle(
                color: primary,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4 * screenHeight),
            Text(
              date,
              style: TextStyle(
                color: black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12 * screenHeight),
            Text(
              AppLocalizations.of(context)!.address,
              style: TextStyle(
                color: primary,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4 * screenHeight),
            Text(
              '${houseNum.toUpperCase()}, ${street.toUpperCase()}${',\n'
                  '$town'.toUpperCase()},\n${region.toUpperCase()}, ${'Ghana'.toUpperCase()}',
              style: TextStyle(
                color: black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            isNoteShowing ? SizedBox(height: 12 * screenHeight) : SizedBox(),
            isNoteShowing
                ? Text(
                    'Note',
                    style: TextStyle(
                      color: primary,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : SizedBox(),
            isNoteShowing ? SizedBox(height: 4 * screenHeight) : SizedBox(),
            isNoteShowing
                ? Text(
                    note!,
                    style: TextStyle(
                      color: black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}

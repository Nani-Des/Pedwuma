import 'package:flutter/material.dart';

import '../constants.dart';

class AppointmentJobStatus extends StatefulWidget {
  bool isJobPendingActive;
  bool isJobInProgressActive;
  bool isJobCompletedAcitve;
  String jobAccepted;
  final String acceptedDate;
  final String inProgressDate;
  final String completedDate;
  AppointmentJobStatus({
    Key? key,
    this.jobAccepted = 'Job Pending',
    this.isJobPendingActive = false,
    this.isJobInProgressActive = false,
    this.isJobCompletedAcitve = false,
    required this.acceptedDate,
    required this.inProgressDate,
    required this.completedDate,
  }) : super(key: key);

  @override
  State<AppointmentJobStatus> createState() => _AppointmentJobStatusState();
}

class _AppointmentJobStatusState extends State<AppointmentJobStatus> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          minHeight: 329 * screenHeight,
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
                  'Job Status',
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
            SizedBox(height: 23 * screenHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/bullseye.png',
                      color: widget.isJobPendingActive ? primary : grey,
                    ),
                    SizedBox(height: 4 * screenHeight),
                    Container(
                      height: 60 * screenHeight,
                      width: 2 * screenWidth,
                      color: grey,
                    ),
                    SizedBox(height: 4 * screenHeight),
                    Image.asset(
                      'assets/icons/bullseye.png',
                      color: widget.isJobInProgressActive ? primary : grey,
                    ),
                    SizedBox(height: 4 * screenHeight),
                    Container(
                      height: 60 * screenHeight,
                      width: 2 * screenWidth,
                      color: grey,
                    ),
                    SizedBox(height: 4 * screenHeight),
                    Image.asset(
                      'assets/icons/bullseye.png',
                      color: widget.isJobCompletedAcitve ? primary : grey,
                    ),
                    SizedBox(height: 4 * screenHeight),
                  ],
                ),
                SizedBox(width: 35.62 * screenWidth),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.jobAccepted,
                      style: TextStyle(
                        fontSize: 17,
                        color: widget.isJobPendingActive ? black : grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5 * screenHeight),
                    Text(
                      widget.acceptedDate,
                      style: TextStyle(
                        fontSize: 14,
                        color: widget.isJobPendingActive ? black : grey,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    SizedBox(height: 45 * screenHeight),
                    Text(
                      'Job-In-Progress',
                      style: TextStyle(
                        fontSize: 17,
                        color: widget.isJobInProgressActive ? black : grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5 * screenHeight),
                    Text(
                      widget.inProgressDate,
                      style: TextStyle(
                        fontSize: 14,
                        color: widget.isJobInProgressActive ? black : grey,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    SizedBox(height: 45 * screenHeight),
                    Text(
                      'Job Completed',
                      style: TextStyle(
                        fontSize: 17,
                        color: widget.isJobCompletedAcitve ? black : grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5 * screenHeight),
                    Text(
                      widget.completedDate,
                      style: TextStyle(
                        fontSize: 14,
                        color: widget.isJobCompletedAcitve ? black : grey,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../constants.dart';

class MyJobsTabs extends StatefulWidget {
  final VoidCallback upcomingCallback;
  final VoidCallback offersCallback;
  final VoidCallback completedCallback;
  const MyJobsTabs({
    Key? key,
    required this.upcomingCallback,
    required this.offersCallback,
    required this.completedCallback,
  }) : super(key: key);

  @override
  State<MyJobsTabs> createState() => _MyJobsTabsState();
}

class _MyJobsTabsState extends State<MyJobsTabs> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 54 * screenHeight,
        width: 385 * screenWidth,
        decoration: BoxDecoration(
          color: sectionColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: appointmentTimeColor, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: widget.upcomingCallback,
              child: Container(
                alignment: Alignment.center,
                width: 108 * screenWidth,
                child: Text(
                  'Upcoming',
                  style: isJobUpcomingClicked
                      ? TextStyle(
                          color: primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        )
                      : TextStyle(
                          color: black,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                ),
              ),
            ),
            Container(
              height: 54 * screenHeight,
              width: 5 * screenWidth,
              color: white,
            ),
            GestureDetector(
              onTap: widget.offersCallback,
              child: Container(
                alignment: Alignment.center,
                width: 108 * screenWidth,
                child: Text(
                  'O & A',
                  style: isJobOffersClicked
                      ? TextStyle(
                          color: primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        )
                      : TextStyle(
                          color: black,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                ),
              ),
            ),
            Container(
              height: 54 * screenHeight,
              width: 5 * screenWidth,
              color: white,
            ),
            GestureDetector(
              onTap: widget.completedCallback,
              child: Container(
                alignment: Alignment.center,
                width: 108 * screenWidth,
                child: Text(
                  'Completed',
                  style: isJobCompletedClicked
                      ? TextStyle(
                          color: primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        )
                      : TextStyle(
                          color: black,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../constants.dart';

class JobDetailsTab extends StatefulWidget {
  final VoidCallback aboutCallBack;
  final VoidCallback portfolioCallBack;
  const JobDetailsTab({
    Key? key,
    required this.aboutCallBack,
    required this.portfolioCallBack,
  }) : super(key: key);

  @override
  State<JobDetailsTab> createState() => _JobDetailsTabState();
}

class _JobDetailsTabState extends State<JobDetailsTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 54 * screenHeight,
        width: 360 * screenWidth,
        decoration: BoxDecoration(
          color: sectionColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: appointmentTimeColor, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 35 * screenWidth),
            GestureDetector(
              onTap: widget.aboutCallBack,
              child: Container(
                width: 76 * screenWidth,
                alignment: Alignment.center,
                child: Text(
                  'About',
                  style: isJobAboutClicked
                      ? TextStyle(
                          color: primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)
                      : TextStyle(
                          color: grey,
                          fontSize: 17,
                        ),
                ),
              ),
            ),
            SizedBox(width: 52 * screenWidth),
            Container(
              height: 54 * screenHeight,
              width: 5 * screenWidth,
              color: white,
            ),
            SizedBox(width: 52 * screenWidth),
            GestureDetector(
              onTap: widget.portfolioCallBack,
              child: Container(
                width: 76 * screenWidth,
                alignment: Alignment.center,
                child: Text(
                  'Portfolio',
                  style: isJobPortfolioClicked
                      ? TextStyle(
                          color: primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)
                      : TextStyle(
                          color: grey,
                          fontSize: 17,
                        ),
                ),
              ),
            ),
            SizedBox(width: 52 * screenWidth),
          ],
        ),
      ),
    );
  }
}

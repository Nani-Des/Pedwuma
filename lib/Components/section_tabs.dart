import 'package:flutter/material.dart';

import '../constants.dart';

class SectionTabs extends StatefulWidget {
  final VoidCallback aboutCallback;
  final VoidCallback reviewCallback;
  final VoidCallback portfolioCallback;
  const SectionTabs({
    Key? key,
    required this.aboutCallback,
    required this.reviewCallback,
    required this.portfolioCallback,
  }) : super(key: key);

  @override
  State<SectionTabs> createState() => _SectionTabsState();
}

class _SectionTabsState extends State<SectionTabs> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 54 * screenHeight,
        width: 367 * screenWidth,
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
              onTap: widget.aboutCallback,
              child: Container(
                width: 76 * screenWidth,
                alignment: Alignment.center,
                child: Text(
                  'About',
                  style: aboutSelected
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
            Container(
              height: 54 * screenHeight,
              width: 5 * screenWidth,
              color: white,
            ),
            GestureDetector(
              onTap: widget.reviewCallback,
              child: Container(
                width: 76 * screenWidth,
                alignment: Alignment.center,
                child: Text(
                  'Review',
                  style: reviewsSelected
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
            Container(
              height: 54 * screenHeight,
              width: 5 * screenWidth,
              color: white,
            ),
            GestureDetector(
              onTap: widget.portfolioCallback,
              child: Container(
                width: 76 * screenWidth,
                alignment: Alignment.center,
                child: Text(
                  'Portfolio',
                  style: portfolioSelected
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
          ],
        ),
      ),
    );
  }
}

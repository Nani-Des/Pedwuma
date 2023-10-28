import 'package:flutter/material.dart';

import '../constants.dart';

class JobUploadOptionalsInfo extends StatefulWidget {
  bool isReadOnly;
  JobUploadOptionalsInfo({
    super.key,
    this.isReadOnly = false,
  });

  @override
  State<JobUploadOptionalsInfo> createState() => _JobUploadOptionalsInfoState();
}

bool isPortfolioTicked = false;
bool isReferencesTicked = false;

class _JobUploadOptionalsInfoState extends State<JobUploadOptionalsInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 5.0),
          child: Text(
            'Optional',
            style: TextStyle(
              color: black,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 4 * screenHeight),
        Container(
          height: 130 * screenHeight,
          width: 359 * screenWidth,
          decoration: BoxDecoration(
            color: sectionColor,
            borderRadius: BorderRadius.circular(13),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: 22 * screenWidth, vertical: 25.5 * screenHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: widget.isReadOnly
                        ? () {}
                        : () {
                            setState(() {
                              isPortfolioTicked = !isPortfolioTicked;
                            });
                          },
                    child: Container(
                      height: 20 * screenHeight,
                      width: 20 * screenWidth,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(2),
                        border:
                            Border.all(color: appointmentTimeColor, width: 1),
                      ),
                      alignment: Alignment.center,
                      child: isPortfolioTicked
                          ? Container(
                              height: 16 * screenHeight,
                              width: 16 * screenWidth,
                              decoration: BoxDecoration(
                                color: primary,
                                // borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                  child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              )),
                            )
                          : SizedBox(),
                    ),
                  ),
                  SizedBox(width: 19 * screenWidth),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 2.0),
                    child: Text(
                      'Add portfolio',
                      style: TextStyle(
                        height: 1.2,
                        fontWeight: FontWeight.w500,
                        color: black,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12 * screenHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: widget.isReadOnly
                        ? () {}
                        : () {
                            setState(() {
                              isReferencesTicked = !isReferencesTicked;
                            });
                          },
                    child: Container(
                      height: 20 * screenHeight,
                      width: 20 * screenWidth,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(2),
                        border:
                            Border.all(color: appointmentTimeColor, width: 1),
                      ),
                      alignment: Alignment.center,
                      child: isReferencesTicked
                          ? Container(
                              height: 16 * screenHeight,
                              width: 16 * screenWidth,
                              decoration: BoxDecoration(
                                color: primary,
                              ),
                              child: Center(
                                  child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              )),
                            )
                          : SizedBox(),
                    ),
                  ),
                  SizedBox(width: 19 * screenWidth),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 2.0),
                    child: Text(
                      'Add references',
                      style: TextStyle(
                        height: 1.2,
                        fontWeight: FontWeight.w500,
                        color: black,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

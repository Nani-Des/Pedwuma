import 'package:flutter/material.dart';

import '../constants.dart';

class UploadListItem extends StatelessWidget {
  final int index;
  final Widget screen;
  final String name;
  final String imageLocation;
  final String serviceCat;
  final String date;
  final String time;
  final String jobStatus;
  const UploadListItem({
    Key? key,
    required this.screen,
    required this.name,
    required this.imageLocation,
    required this.serviceCat,
    required this.date,
    required this.time,
    required this.jobStatus,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          selectedJobUploadIndex = index;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => screen));
        },
        child: Container(
          height: 100 * screenHeight,
          width: 375 * screenWidth,
          decoration: BoxDecoration(
            color: sectionColor,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.only(
            left: 20 * screenWidth,
            top: 16 * screenHeight,
            bottom: 17 * screenHeight,
            right: 5 * screenWidth,
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
                    image: DecorationImage(
                      image: NetworkImage(imageLocation),
                      fit: BoxFit.fill,
                    ),
                    border: Border.all(color: appointmentTimeColor, width: 1)),
                child: imageLocation != ''
                    ? SizedBox()
                    : Center(
                        child: Icon(
                          Icons.person,
                          color: grey,
                        ),
                      ),
              ),
              SizedBox(width: 17.74 * screenWidth),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 3.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 130 * screenWidth,
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
                    SizedBox(height: 4 * screenHeight),
                    SizedBox(
                      width: 130 * screenWidth,
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
              Spacer(),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 120 * screenWidth,
                      child: Text(
                        date + ' || ' + time,
                        style: TextStyle(
                          color: black,
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                        ),
                        overflow: TextOverflow.fade,
                        softWrap: false,
                      ),
                    ),
                    SizedBox(height: 10 * screenHeight),
                    Text(
                      jobStatus,
                      style: TextStyle(
                        color: primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
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

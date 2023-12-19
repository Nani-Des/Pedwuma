import 'package:flutter/material.dart';
import 'package:handyman_app/Screens/Job%20Details/job_details_screen.dart';

import '../constants.dart';

class JobCategoryItem extends StatelessWidget {
  final bool status;
  bool isFavouriteSelected;
  bool isFavourite;
  final String jobType;
  final String name;
  final String price;
  final String imageLocation;
  final String chargeRate;
  final int index;
  final String jobItemId;

  JobCategoryItem({
    Key? key,
    required this.status,
    this.isFavouriteSelected = false,
    this.isFavourite = false,
    required this.jobType,
    required this.name,
    required this.price,
    required this.imageLocation,
    required this.index,
    required this.chargeRate,
    required this.jobItemId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          if (isFavourite == true) {
            int jobIndex =
                jobDashboardID.indexOf(handymanFavouritesIDList[index]);

            jobSelectedIndex = jobIndex;
          } else {
            jobSelectedIndex = index;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JobDetailsScreen(),
            ),
          );
          typeClicked = 'Handyman';
        },
        child: Container(
          height: 123 * screenHeight,
          width: 362 * screenWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: tabLight,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 123 * screenHeight,
                width: 115 * screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imageLocation),
                  ),
                ),
                child: imageLocation == ''
                    ? Center(
                        child: Icon(
                        Icons.person,
                        color: grey,
                        size: 40,
                      ))
                    : null,
              ),
              VerticalDivider(thickness: 3.5, color: Colors.white),
              Padding(
                padding: isFavouriteSelected
                    ? EdgeInsets.only(
                        left: 6 * screenWidth,
                        right: 6 * screenWidth,
                        bottom: 10 * screenHeight,
                      )
                    : EdgeInsets.symmetric(
                        horizontal: screenWidth * 6.0,
                        vertical: screenHeight * 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    isFavouriteSelected
                        ? SizedBox(
                            width: 212 * screenWidth,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '',
                                  textDirection: TextDirection.rtl,
                                ),
                                Spacer(),
                                Icon(
                                  Icons.bookmark,
                                  color: chatBlue,
                                  textDirection: TextDirection.rtl,
                                ),
                              ],
                            ),
                          )
                        : SizedBox(),
                    Padding(
                      padding: isFavouriteSelected
                          ? EdgeInsets.only(top: 0 * screenHeight)
                          : EdgeInsets.symmetric(vertical: screenHeight * 5.0),
                      child: SizedBox(
                        width: 190 * screenWidth,
                        child: Text(
                          jobType,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: black,
                          ),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 180 * screenWidth,
                      child: Text(
                        'By: ' + name,
                        style: TextStyle(
                          fontSize: 14,
                          color: textGreyColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: screenHeight * 5),
                    SizedBox(
                      width: 210 * screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: screenHeight * 2.0,
                                right: 5 * screenWidth),
                            child: status == true
                                ? Image.asset('assets/icons/green_valid.png')
                                : Image.asset('assets/icons/red_invalid.png'),
                          ),
                          status == true
                              ? Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 3.0),
                                  child: Text(
                                    'Valid',
                                    style: TextStyle(
                                        color: green,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                )
                              : Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 2.0),
                                  child: Text(
                                    'Invalid',
                                    style: TextStyle(
                                        color: red,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                ),
                          Spacer(),
                          Text(
                            '\₵' + price + '/' + chargeRate,
                            style: TextStyle(
                                fontSize: 19,
                                color: primary,
                                fontWeight: FontWeight.w800),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

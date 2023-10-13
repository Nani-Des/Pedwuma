import 'package:flutter/material.dart';

import '../constants.dart';

class RatingItem extends StatelessWidget {
  final int starsGiven;
  final String name;
  final String comment;
  String timePosted;
  bool isCommentLiked;
  RatingItem({
    Key? key,
    required this.name,
    required this.comment,
    this.isCommentLiked = false,
    this.timePosted = 'N/A',
    required this.starsGiven,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: 20 * screenWidth,
          top: 10 * screenHeight,
          bottom: 6 * screenHeight),
      width: 353 * screenWidth,
      decoration: BoxDecoration(
        color: sectionColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 45 * screenHeight,
                width: 42.87 * screenWidth,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/profile_pic.jpeg'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 4.0, left: 16 * screenWidth),
                child: Text(
                  name,
                  style: TextStyle(
                      color: black, fontWeight: FontWeight.w600, fontSize: 17),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 6.0, left: 12 * screenWidth),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    starsGiven >= 1
                        ? Image.asset('assets/icons/gold_star.png')
                        : Image.asset('assets/icons/gold_star.png',
                            color: grey),
                    starsGiven >= 2
                        ? Image.asset('assets/icons/gold_star.png')
                        : Image.asset('assets/icons/gold_star.png',
                            color: grey),
                    starsGiven >= 3
                        ? Image.asset('assets/icons/gold_star.png')
                        : Image.asset('assets/icons/gold_star.png',
                            color: grey),
                    starsGiven >= 4
                        ? Image.asset('assets/icons/gold_star.png')
                        : Image.asset('assets/icons/gold_star.png',
                            color: grey),
                    starsGiven == 5
                        ? Image.asset('assets/icons/gold_star.png')
                        : Image.asset('assets/icons/gold_star.png',
                            color: grey),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(
                    right: screenWidth * 20.0, top: 4 * screenHeight),
                child: Text(
                  timePosted,
                  style: TextStyle(
                      color: black, fontWeight: FontWeight.w200, fontSize: 14),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 57.0, right: screenWidth * 30),
            child: Text(
              comment,
              style: TextStyle(color: ratingTextColor, fontSize: 15),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    right: screenWidth * 6.0,
                    bottom: 3 * screenHeight,
                    top: 10 * screenHeight),
                child: Container(
                  height: 31 * screenHeight,
                  width: 155 * screenWidth,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: [
                      BoxShadow(
                        color: black.withOpacity(0.25),
                        blurRadius: 2,
                        spreadRadius: 0,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 20 * screenWidth),
                      Text(
                        'Reply',
                        style: TextStyle(
                            color: black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 20 * screenWidth),
                      Container(
                        height: 31 * screenHeight,
                        width: 3 * screenWidth,
                        color: black.withOpacity(0.1),
                      ),
                      SizedBox(width: 26 * screenWidth),
                      isCommentLiked == true
                          ? Image.asset('assets/icons/heart.png')
                          : Image.asset('assets/icons/heart.png', color: grey),
                      SizedBox(width: 7 * screenWidth),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

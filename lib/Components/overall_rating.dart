// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:handyman_app/Components/rating_bar.dart';
import 'package:handyman_app/Services/read_data.dart';

import '../constants.dart';

class OverallRating extends StatelessWidget {
  const OverallRating({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          bottom: 20 * screenHeight,
          top: 25 * screenHeight,
          left: 5 * screenWidth,
          right: 10 * screenWidth),
      height: 122 * screenHeight,
      width: 353 * screenWidth,
      decoration: BoxDecoration(
        color: sectionColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    ratingTotal.toString(),
                    style: TextStyle(
                        color: primary,
                        fontSize: 32,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(width: 11 * screenWidth),
                  SizedBox(
                    width: 90 * screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ratingTotal > 0
                            ? Image.asset('assets/icons/gold_star.png')
                            : Image.asset('assets/icons/gold_star.png',
                                color: grey),
                        ratingTotal > 1.0
                            ? Image.asset('assets/icons/gold_star.png')
                            : Image.asset('assets/icons/gold_star.png',
                                color: grey),
                        ratingTotal > 2.0
                            ? Image.asset('assets/icons/gold_star.png')
                            : Image.asset('assets/icons/gold_star.png',
                                color: grey),
                        ratingTotal > 3.0
                            ? Image.asset('assets/icons/gold_star.png')
                            : Image.asset('assets/icons/gold_star.png',
                                color: grey),
                        ratingTotal > 4.0
                            ? Image.asset('assets/icons/gold_star.png')
                            : Image.asset('assets/icons/gold_star.png',
                                color: grey),
                      ],
                    ),
                  ),
                ],
              ),

              Text(
                '(${allReviews.length} ${allReviews.length < 2 ? 'review' : 'reviews'})',
                style: TextStyle(
                    color: chatTimeColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 5.0),
            child: Center(
              child: SizedBox(
                width: 159 * screenWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListView.builder(
                      itemCount: ratingsWidth.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return RatingBar(width: ratingsWidth[index]);
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

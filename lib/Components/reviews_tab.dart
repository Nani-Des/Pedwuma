import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:handyman_app/Components/rating_item.dart';
import 'package:handyman_app/Models/review.dart';
import 'package:handyman_app/Services/read_data.dart';

import '../constants.dart';
import 'overall_rating.dart';

class ReviewsTab extends StatelessWidget {
  const ReviewsTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 5.0, bottom: 10 * screenHeight),
            child: Text(
              'Ratings',
              style: TextStyle(
                  color: black, fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          OverallRating(),
          SizedBox(height: 10 * screenHeight),
          ListView.separated(
            itemCount: allReviews.length > 10 ? 10 : allReviews.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              Timestamp dateTime = allReviews[index].reviewDate;
              DateTime date = dateTime.toDate();
              final reviewDate =
                  '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
              return RatingItem(
                starsGiven: allReviews[index].stars,
                name: allReviews[index].name,
                comment: allReviews[index].comment,
                isCommentLiked: true,
                timePosted: reviewDate,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 11 * screenHeight);
            },
          ),
        ],
      ),
    );
  }
}

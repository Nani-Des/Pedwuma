import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewData {
  final Timestamp reviewDate;
  final String userID;
  final String reviewID;
  final String name;
  final String jobID;
  final int stars;
  final String comment;
  final List replies;
  final int likes;
  const ReviewData({
    required this.reviewDate,
    required this.name,
    required this.userID,
    required this.replies,
    required this.reviewID,
    required this.jobID,
    required this.stars,
    required this.comment,
    required this.likes,
  });
}

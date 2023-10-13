import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:handyman_app/Components/default_back_button.dart';
import 'package:handyman_app/Screens/Handyman%20Details/handyman_details_screen.dart';
import 'package:handyman_app/Screens/Job Details/Components/body.dart';
import 'package:handyman_app/constants.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({Key? key}) : super(key: key);

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  Future isBookmarked() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Bookmark')
          .where('User ID', isEqualTo: loggedInUserId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final bookmarkId = querySnapshot.docs.single.id;
        await FirebaseFirestore.instance
            .collection('Bookmark')
            .doc(bookmarkId)
            .update({'Customer Job IDs': customerJobsBookmarked});
      } else {
        final document =
            await FirebaseFirestore.instance.collection('Bookmark').add({
          'User ID': loggedInUserId,
          'Customer Job IDs': customerJobsBookmarked,
          'Handyman Job IDs': handymenJobsBookmarked,
        });

        await FirebaseFirestore.instance
            .collection('Bookmark')
            .doc(document.id)
            .update({'Bookmark ID': document.id});
      }
    } catch (e) {
      print(e.toString());
    }
  }

  bool isJobBookmarked = false;

  @override
  void initState() {
    if (customerJobsBookmarked.contains(jobDashboardID[jobSelectedIndex])) {
      isJobBookmarked = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          highlightColor: tabLight,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Padding(
            padding: EdgeInsets.only(left: screenWidth * 12.0),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: primary,
              weight: 15,
            ),
          ),
        ),
        elevation: 0.0,
        backgroundColor: white,
        title: Text(
          'Job Details',
          style: TextStyle(
            color: black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: <Widget>[
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              setState(() {
                isJobBookmarked = !isJobBookmarked;
              });

              if (isJobBookmarked) {
                if (!customerJobsBookmarked
                    .contains(jobDashboardID[jobSelectedIndex])) {
                  customerJobsBookmarked.add(jobDashboardID[jobSelectedIndex]);
                }
              } else {
                if (customerJobsBookmarked
                    .contains(jobDashboardID[jobSelectedIndex])) {
                  customerJobsBookmarked
                      .remove(jobDashboardID[jobSelectedIndex]);
                }
              }
              isBookmarked();
            },
            icon: (customerJobsBookmarked
                        .contains(jobDashboardID[jobSelectedIndex]) &&
                    isJobBookmarked == true)
                ? Icon(
                    Icons.bookmark,
                    color: primary,
                  )
                : Icon(
                    Icons.bookmark,
                    color: semiGrey,
                  ),
          ),
          SizedBox(width: 18 * screenWidth),
        ],
      ),
      body: Body(),
      backgroundColor: white,
    );
  }
}

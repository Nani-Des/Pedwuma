import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:handyman_app/Components/default_back_button.dart';
import 'package:handyman_app/Screens/Handyman Details/Components/body.dart';
import 'package:handyman_app/Services/read_data.dart';
import 'package:handyman_app/constants.dart';

class HandymanDetailsScreen extends StatefulWidget {
  const HandymanDetailsScreen({Key? key}) : super(key: key);

  @override
  State<HandymanDetailsScreen> createState() => _HandymanDetailsScreenState();
}

List<String> handymenJobsBookmarked = [];
List<String> customerJobsBookmarked = [];

class _HandymanDetailsScreenState extends State<HandymanDetailsScreen> {
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
            .update({'Handyman Job IDs': handymenJobsBookmarked});
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

  bool isHandymanBookmarked = false;

  @override
  void initState() {
    if (handymenJobsBookmarked
        .contains(handymanDashboardID[handymanSelectedIndex])) {
      isHandymanBookmarked = true;
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
            Navigator.pop(context, true);
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
          'Personnel Details',
          style: TextStyle(
              color: black, fontSize: 18, fontWeight: FontWeight.w700),
        ),
        actions: <Widget>[
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              setState(() {
                isHandymanBookmarked = !isHandymanBookmarked;
              });
              if (isHandymanBookmarked) {
                handymenJobsBookmarked
                    .add(handymanDashboardID[handymanSelectedIndex]);
              } else {
                if (handymenJobsBookmarked
                    .contains(handymanDashboardID[handymanSelectedIndex])) {
                  handymenJobsBookmarked
                      .remove(handymanDashboardID[handymanSelectedIndex]);
                }
              }
              isBookmarked();
            },
            icon: (handymenJobsBookmarked
                        .contains(handymanDashboardID[handymanSelectedIndex]) &&
                    isHandymanBookmarked == true)
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
      backgroundColor: Colors.white,
      body: Body(),
    );
  }
}

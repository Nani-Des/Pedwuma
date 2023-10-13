// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handyman_app/Screens/Bookings/customer_bookings_screen.dart';
import 'package:handyman_app/Screens/Dashboard/Handymen/handymen_dashboard_screen.dart';
import 'package:handyman_app/Screens/Profile/Profile%20-%20Handyman/profile_handyman.dart';
import 'package:handyman_app/constants.dart';

import '../../../../Components/note_text_area.dart';
import '../../../../Services/read_data.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int starsGiven = 0;
  final notesController = TextEditingController();
  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  Future addRating() async {
    try {
      final document =
          await FirebaseFirestore.instance.collection('Reviews').add({
        'Job ID': moreOffers[selectedJob].jobID,
        'User ID': loggedInUserId,
        'Review Date': Timestamp.now(),
        'Replies': [],
        'Likes': 0,
        'Stars': starsGiven,
        'Comment': notesController.text.trim(),
      });

      final docID = document.id;
      await FirebaseFirestore.instance.collection('Reviews').doc(docID).update({
        'Review ID': docID,
      });

      if (moreOffers[selectedJob].whoApplied == 'Customer') {
        await FirebaseFirestore.instance
            .collection('Customer Jobs Applied')
            .doc(moreOffers[selectedJob].documentID)
            .update({
          'Job Status': 'Paid',
        });
      } else {
        await FirebaseFirestore.instance
            .collection('Handyman Jobs Applied')
            .doc(moreOffers[selectedJob].documentID)
            .update({
          'Job Status': 'Paid',
        });
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CustomerBookingsScreen(),
        ),
      );
    } on FirebaseException catch (error) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'Payment Error'.toUpperCase(),
                style: TextStyle(color: primary, fontSize: 17),
              ),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            content: Text(
              '$error\nTry again later.',
              style: TextStyle(
                height: 1.4,
                fontSize: 16,
                color: black,
              ),
            ),
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'Error'.toUpperCase(),
                style: TextStyle(color: primary, fontSize: 17),
              ),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            content: Text(
              '$e\nTry again later.',
              style: TextStyle(
                height: 1.4,
                fontSize: 16,
                color: black,
              ),
            ),
          );
        },
      );
    }
  }

  void reviewDialogBox() {
    starsGiven = 0;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AlertDialog(
                icon: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        height: 40 * screenHeight,
                        width: 40 * screenWidth,
                        decoration: BoxDecoration(
                          color: white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          color: red,
                        )),
                  ),
                ),
                // insetPadding: EdgeInsets.all(10),
                backgroundColor: Colors.transparent,
                content: Container(
                  constraints: BoxConstraints(minWidth: 50 * screenHeight),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: white, borderRadius: BorderRadius.circular(24)),
                  padding: EdgeInsets.symmetric(
                    vertical: 22 * screenWidth,
                    horizontal: 20.5 * screenWidth,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Center(
                        child: Text(
                          'Review',
                          style: TextStyle(
                            color: black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 10 * screenHeight),
                      Text(
                        'Rating',
                        style: TextStyle(
                          color: primary,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 7 * screenHeight),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                starsGiven = 1;
                              });
                            },
                            child: starsGiven > 0
                                ? Icon(
                                    Icons.star_rate_rounded,
                                    color: Colors.amber,
                                    size: 40,
                                  )
                                : Icon(
                                    Icons.star_border_rounded,
                                    color: appointmentTimeColor,
                                    size: 40,
                                  ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                starsGiven = 2;
                              });
                            },
                            child: starsGiven > 1
                                ? Icon(
                                    Icons.star_rate_rounded,
                                    color: Colors.amber,
                                    size: 40,
                                  )
                                : Icon(
                                    Icons.star_border_rounded,
                                    color: appointmentTimeColor,
                                    size: 40,
                                  ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                starsGiven = 3;
                              });
                            },
                            child: starsGiven > 2
                                ? Icon(
                                    Icons.star_rate_rounded,
                                    color: Colors.amber,
                                    size: 40,
                                  )
                                : Icon(
                                    Icons.star_border_rounded,
                                    color: appointmentTimeColor,
                                    size: 40,
                                  ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                starsGiven = 4;
                              });
                            },
                            child: starsGiven > 3
                                ? Icon(
                                    Icons.star_rate_rounded,
                                    color: Colors.amber,
                                    size: 40,
                                  )
                                : Icon(
                                    Icons.star_border_rounded,
                                    color: appointmentTimeColor,
                                    size: 40,
                                  ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                starsGiven = 5;
                              });
                            },
                            child: starsGiven > 4
                                ? Icon(
                                    Icons.star_rate_rounded,
                                    color: Colors.amber,
                                    size: 40,
                                  )
                                : Icon(
                                    Icons.star_border_rounded,
                                    color: appointmentTimeColor,
                                    size: 40,
                                  ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20 * screenHeight),
                      Text(
                        'Comment',
                        style: TextStyle(
                          color: primary,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 7 * screenHeight),
                      NoteTextArea(
                        width: 0,
                        isNoteEditable: true,
                        controller: notesController,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  await addRating();
                },
                child: Container(
                  height: 49 * screenHeight,
                  width: 273 * screenWidth,
                  decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: sectionColor, width: 3)),
                  child: Center(
                    child: Text(
                      'Rate',
                      style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 80 * screenHeight,
          ),
          Center(
            child: SvgPicture.asset(
              'assets/icons/repair_illustration.svg',
              height: 203 * screenHeight,
              width: 215.56 * screenWidth,
            ),
          ),
          SizedBox(height: 23 * screenHeight),
          Text(
            'Successful Booking!',
            style: TextStyle(
                color: white, fontSize: 30, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 10 * screenHeight),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 37.0 * screenWidth),
            child: Text(
              'Payment has been issued to handyman. You will receive a notification'
              'aas we have debited your account. \nThank You.',
              style: TextStyle(color: white, fontSize: 17),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 86 * screenHeight),
          GestureDetector(
            onTap: reviewDialogBox,
            child: Container(
              height: 64 * screenHeight,
              width: 335 * screenWidth,
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 2, color: white),
              ),
              alignment: Alignment.center,
              child: Container(
                height: 44 * screenHeight,
                width: 315 * screenWidth,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'Rate',
                    style: TextStyle(
                        color: primary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

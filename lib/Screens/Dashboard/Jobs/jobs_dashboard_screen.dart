import 'package:flutter/material.dart';
import 'package:handyman_app/Components/drawer_header.dart';
import 'package:handyman_app/constants.dart';
import 'package:handyman_app/Screens/Home/home_screen.dart';
import 'package:handyman_app/Screens/Notifications/notification_screen.dart';
import 'package:handyman_app/Screens/Dashboard/Handymen/handymen_dashboard_screen.dart';
import 'package:handyman_app/Screens/Dashboard/Jobs/Components/body.dart';
import 'package:handyman_app/Screens/Dashboard/Jobs/Components/handyman_drawer.dart';

import '../../Job Upload/Handyman/handyman_job_upload_screen.dart';

class JobsDashboardScreen extends StatefulWidget {
  const JobsDashboardScreen({Key? key}) : super(key: key);

  @override
  State<JobsDashboardScreen> createState() => _JobsDashboardScreenState();
}

class _JobsDashboardScreenState extends State<JobsDashboardScreen> {
  bool showSpeechBubble = true; // Set to false to hide the speech bubble

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => InkWell(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            borderRadius: BorderRadius.circular(15),
            splashColor: sectionColor,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Image assets
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 14.0),
                  child: Image.asset(
                    'assets/icons/menu.png',
                    color: primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        elevation: 0.0,
        backgroundColor: white,
        actions: [
          // Speech bubble external to the container holding Image.asset
          if (showSpeechBubble)
            GestureDetector(
              onTap: () {
                // Handle onTap action
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HandymanJobUploadScreen()),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 2),
                  height: 10,
                   decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        'Upload Profile For Booking',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          Container(
            margin: EdgeInsets.only(right: screenWidth * 20),
            height: screenHeight * 40,
            width: screenWidth * 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imageUrl),
              ),
            ),
            child: imageUrl == ''
                ? Center(child: Icon(Icons.person, color: grey))
                : null,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Body(),
      drawer: HandymanDrawer(),
    );
  }
}
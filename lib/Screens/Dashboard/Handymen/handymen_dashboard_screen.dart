import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handyman_app/Components/default_back_button.dart';
import 'package:handyman_app/Components/drawer_header.dart';
import 'package:handyman_app/Screens/Dashboard/Handymen/Components/body.dart';
import 'package:handyman_app/Screens/Notifications/notification_screen.dart'; // Import the screen
import 'package:handyman_app/constants.dart';

import '../../Home/home_screen.dart';
import '../../Job Upload/Customer/customer_job_upload_screen.dart';
import 'Components/customer_drawer.dart';



class HandymanDashboardScreen extends StatefulWidget {
  const HandymanDashboardScreen({Key? key}) : super(key: key);

  @override
  State<HandymanDashboardScreen> createState() =>
      _HandymanDashboardScreenState();
}

class _HandymanDashboardScreenState extends State<HandymanDashboardScreen> {
  bool isDrawerClicked = false;
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
            borderRadius: BorderRadius.circular(4),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomerJobUploadScreen()),
                );
              },
              child: Container(
                margin: EdgeInsets.only(left: screenWidth * 10, top: screenHeight * 20, bottom: screenHeight * 20), // Adjust the margin as needed
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue, // You can change the color
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
                child: Text(
                  'Post a Job',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          Container(
            margin: EdgeInsets.only(right: screenWidth * 20),
            height: screenHeight * 40,
            width: screenWidth * 40,
            decoration: BoxDecoration(
              border: Border.all(color: sectionColor, width: 1),
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
      drawerEnableOpenDragGesture: true,
      drawer: CustomerDrawer(),
    );
  }
}

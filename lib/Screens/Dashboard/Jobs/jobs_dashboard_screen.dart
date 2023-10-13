import 'package:flutter/material.dart';

import '../../../Components/drawer_header.dart';
import '../../../constants.dart';
import '../../Home/home_screen.dart';
import '../../Notifications/notification_screen.dart';
import '../Handymen/handymen_dashboard_screen.dart';
import '../Jobs/Components/body.dart';
import 'Components/handyman_drawer.dart';

class JobsDashboardScreen extends StatefulWidget {
  const JobsDashboardScreen({Key? key}) : super(key: key);

  @override
  State<JobsDashboardScreen> createState() => _JobsDashboardScreenState();
}

class _JobsDashboardScreenState extends State<JobsDashboardScreen> {
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
            child: Center(
              child: Padding(
                  padding: EdgeInsets.only(left: screenWidth * 14.0),
                  child: Image.asset(
                    'assets/icons/menu.png',
                    color: primary,
                  )),
            ),
          ),
        ),
        elevation: 0.0,
        backgroundColor: white,
        actions: [
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
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Body(),
      drawer: HandymanDrawer(),
    );
  }
}

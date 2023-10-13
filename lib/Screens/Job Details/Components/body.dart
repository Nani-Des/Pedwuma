// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handyman_app/Components/about_tab.dart';
import 'package:handyman_app/Services/read_data.dart';
import 'package:handyman_app/constants.dart';

import '../../../Components/job_details_essentials_container.dart';
import '../../../Components/portfolio_tab.dart';
import '../../Appointment/appointment_screen.dart';
import 'job_details_tab.dart';
import 'job_summary.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ReadData readData = ReadData();
  bool isDataLoaded = false;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    await readData.getHandymanJobItemData(jobDashboardID[jobSelectedIndex]);
    setState(() {
      isDataLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isDataLoaded ? buildContent() : buildLoadingIndicator();
  }

  Widget buildContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          JobSummary(),
          SizedBox(height: 22),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              JobDetailsEssentialsContainer(
                title: 'People Applied',
                subtitle: allJobItemList[0].peopleApplied.toString(),
              ),
              JobDetailsEssentialsContainer(
                title: 'Deadline',
                subtitle: allJobItemList[0].deadline,
              ),
            ],
          ),
          SizedBox(height: 24 * screenHeight),
          JobDetailsTab(
            aboutCallBack: () {
              setState(() {
                isJobAboutClicked = !isJobAboutClicked;
              });
              if (isJobAboutClicked == true) isJobPortfolioClicked = false;
              if (isJobPortfolioClicked == false) isJobAboutClicked = true;
            },
            portfolioCallBack: () {
              setState(() {
                isJobPortfolioClicked = !isJobPortfolioClicked;
              });
              if (isJobPortfolioClicked == true) isJobAboutClicked = false;
              if (isJobAboutClicked == false) isJobPortfolioClicked = true;
            },
          ),
          SizedBox(height: 16 * screenHeight),
          if (isJobAboutClicked == true) AboutTab(isCustomerSection: false),
          if (isJobPortfolioClicked == true) PortfolioTab(),
        ],
      ),
    );
  }

  Widget buildLoadingIndicator() {
    return Center(
      child: (Platform.isAndroid)
          ? CircularProgressIndicator()
          : CupertinoActivityIndicator(),
    );
  }
}

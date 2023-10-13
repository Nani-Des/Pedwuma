// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handyman_app/Screens/Chat/Components/chat_alternate_screen.dart';
import 'package:handyman_app/Screens/Chat/Components/chat_screen.dart';
import 'package:handyman_app/Services/read_data.dart';
import 'package:handyman_app/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../Components/contact_personnel_button.dart';

import '../../../Components/personnel_details_tab.dart';
import '../../../Components/portfolio_tab.dart';
import '../../../Components/reviews_tab.dart';
import '../../../Components/about_tab.dart';
import '../../../Components/section_tabs.dart';

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
    await readData
        .getCustomerJobItemData(handymanDashboardID[handymanSelectedIndex]);
    await readData.getReviews(context);
    setState(() {
      isDataLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isDataLoaded ? buildContent() : buildLoadingIndicator();
  }

  Widget buildContent() {
    if (allJobItemList.isEmpty) {
      return buildEmptyContent(); // Handle the case when the list is empty
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          PersonnelDetailsTab(),
          SizedBox(height: 23 * screenHeight),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ContactPersonnelButton(
                call: true,
                press: () {
                  readData.getPhoneNumber('Customer', context, true);
                },
              ),
              ContactPersonnelButton(
                call: false,
                press: () {
                  readData.getPhoneNumber('Customer', context, false);
                },
              ),
            ],
          ),
          SizedBox(height: 22 * screenHeight),
          SectionTabs(
            aboutCallback: () {
              setState(() {
                aboutSelected = !aboutSelected;
                if (aboutSelected == true) {
                  reviewsSelected = false;
                  portfolioSelected = false;
                }
                if (reviewsSelected == false && portfolioSelected == false) {
                  aboutSelected = true;
                }
              });
            },
            reviewCallback: () {
              setState(() {
                reviewsSelected = !reviewsSelected;
                if (reviewsSelected == true) {
                  aboutSelected = false;
                  portfolioSelected = false;
                }
                if (aboutSelected == false && portfolioSelected == false) {
                  reviewsSelected = true;
                }
              });
            },
            portfolioCallback: () {
              setState(() {
                portfolioSelected = !portfolioSelected;
                if (portfolioSelected == true) {
                  reviewsSelected = false;
                  aboutSelected = false;
                }
                if (reviewsSelected == false && aboutSelected == false) {
                  portfolioSelected = true;
                }
              });
            },
          ),
          SizedBox(height: screenHeight * 23),
          if (aboutSelected == true) AboutTab(isCustomerSection: true),
          if (reviewsSelected == true) ReviewsTab(),
          if (portfolioSelected == true) PortfolioTab(),
        ],
      ),
    );
  }

  Widget buildLoadingIndicator() {
    return Center(
      child: (Platform.isAndroid)
          ? CircularProgressIndicator(color: primary)
          : CupertinoActivityIndicator(color: primary),
    );
  }

  Widget buildEmptyContent() {
    return Center(
      child: Text('No data available'),
    );
  }
}

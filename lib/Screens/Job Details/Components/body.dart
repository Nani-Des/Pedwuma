// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handyman_app/Components/about_tab.dart';
import 'package:handyman_app/Services/read_data.dart';
import 'package:handyman_app/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../Components/contact_personnel_button.dart';
import '../../../Components/job_details_essentials_container.dart';
import '../../../Components/portfolio_tab.dart';
import '../../Appointment/appointment_screen.dart';
import '../../Login/login_screen.dart';
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
          SizedBox(height: 20 * screenHeight),
          Center(
            child: Row(

              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: ContactPersonnelButton(
                    call: true,
                    press: () async {
                      User? user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        readData.getPhoneNumber('', context, true);
                      } else {
                        // User is not logged in, show a login prompt or navigate to the login screen.
                        // For example, you can navigate to the login screen.
                        Alert(
                          context: context,
                          type: AlertType.info,
                          title: AppLocalizations.of(context)!.gd,
                          style: AlertStyle(
                              titleStyle: TextStyle(fontWeight: FontWeight.w800),
                              descStyle:
                              TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
                          desc: AppLocalizations.of(context)!.gg,
                          buttons: [

                            DialogButton(
                              onPressed: () => Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => LoginScreen())),
                              color: Color(0xFF0D47A1),
                              border: Border.all(color: Color(0xffe5f3ff)),
                              child: Text(
                                AppLocalizations.of(context)!.ge,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'DM-Sans',
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ).show(); // Replace '/login' with your actual login route
                      }


                    },
                  ),
                ),
                SizedBox(width: 4), // Add some spacing between the buttons
                Flexible(
                  child: ContactPersonnelButton(
                    call: false,
                    press: () async {
                      User? user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        readData.getPhoneNumber('', context, false);
                      } else {
                        // User is not logged in, show a login prompt or navigate to the login screen.
                        // For example, you can navigate to the login screen.
                        Alert(
                          context: context,
                          type: AlertType.info,
                          title: AppLocalizations.of(context)!.gd,
                          style: AlertStyle(
                              titleStyle: TextStyle(fontWeight: FontWeight.w800),
                              descStyle:
                              TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
                          desc: AppLocalizations.of(context)!.gg,
                          buttons: [

                            DialogButton(
                              onPressed: () => Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => LoginScreen())),
                              color: Color(0xFF0D47A1),
                              border: Border.all(color: Color(0xffe5f3ff)),
                              child: Text(
                                AppLocalizations.of(context)!.ge,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'DM-Sans',
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ).show(); // Replace '/login' with your actual login route
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20 * screenHeight),
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

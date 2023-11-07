// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:handyman_app/Components/job_category_item.dart';
import 'package:handyman_app/Components/search_bar_item.dart';
import 'package:handyman_app/Models/handyman_category_data.dart';
import 'package:handyman_app/Screens/Home/Components/body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../Components/dashboard_tab.dart';
import '../../../../constants.dart';
import '../../../Custom Search Delegate/handyman_search_delegate.dart';
import '../../../Custom Search Delegate/job_search_delegate.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

Future selectedHandymanCategoryData(String categoryName) async {
  jobStatusOptions.clear();
  jobDashboardJobType.clear();
  jobDashboardName.clear();
  jobDashboardPrice.clear();
  jobDashboardChargeRate.clear();
  jobDashboardID.clear();
  jobDashboardImage.clear();

  final documents = await FirebaseFirestore.instance
      .collection('Jobs')
      .where('Service Information.Service Category', isEqualTo: categoryName)
      .where('Customer ID', isNotEqualTo: loggedInUserId)
      .get();

  if (documents.docs.isNotEmpty) {
    documents.docs.forEach((document) {
      final documentData = document.data();
      final categoryData = HandymanCategoryData(
          pic: documentData['User Pic'],
          jobID: documentData['Job ID'],
          seenBy: documentData['Seen By'],
          fullName: documentData['Name'],
          jobService: documentData['Service Information']['Service Provided'],
          charge: documentData['Service Information']['Charge'],
          chargeRate: documentData['Service Information']['Charge Rate'],
          jobCategory: documentData['Service Information']['Service Category'],
          jobStatus: documentData['Job Details']['Job Status']);

      jobDashboardImage.add(categoryData.pic);
      jobDashboardID.add(categoryData.jobID);
      jobDashboardJobType.add(categoryData.jobService);
      jobDashboardName.add(categoryData.fullName);
      jobDashboardPrice.add(categoryData.charge.toString());
      jobStatusOptions.add(categoryData.jobStatus);
      if (categoryData.chargeRate == 'Hour') {
        jobDashboardChargeRate.add('Hr');
      } else if (categoryData.chargeRate == '6 hours') {
        jobDashboardChargeRate.add('6 Hrs');
      } else if (categoryData.chargeRate == '12 hours') {
        jobDashboardChargeRate.add('12 Hrs');
      } else {
        jobDashboardChargeRate.add('Day');
      }
    });
  } else {
    print('No Jobs Found.');
  }
}

class _BodyState extends State<Body> {
  int selectedTabIndex = 0;

  void onTabSelected(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 12.0, vertical: screenHeight * 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SearchBarItem(
              hintText: AppLocalizations.of(context)!.xx,
              onSearchTap: () {
                showSearch(
                  context: context,
                  delegate:
                      JobSearchDelegate(itemsToSearch: jobDashboardJobType),
                );
              },
            ),
            SizedBox(height: screenHeight * 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: screenHeight * 12.0, left: screenWidth * 8),
                  child: Text(
                    AppLocalizations.of(context)!.cat,
                    style: TextStyle(
                        color: black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter'),
                  ),
                ),
                Spacer(),
                Image.asset('assets/icons/sort.png'),
              ],
            ),
            SizedBox(
              height: 48 * screenHeight,
              child: ListView.separated(
                padding: EdgeInsets.only(left: 10 * screenWidth),
                itemCount: dashBoardTabList.toSet().toList().length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => DashboardTab(
                  onTabSelected: onTabSelected,
                  selectedTabIndex: selectedTabIndex,
                  index: index,
                  text: dashBoardTabList[index],
                ),
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: screenWidth * 15);
                },
              ),
            ),
            SizedBox(height: screenHeight * 25),
            FutureBuilder(
                future: dashBoardTabList[selectedTabIndex] == 'All'
                    ? getHandymanCategoryData()
                    : selectedHandymanCategoryData(
                        dashBoardTabList[selectedTabIndex]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return jobDashboardPrice.isEmpty
                        ? Padding(
                            padding: EdgeInsets.only(top: screenHeight * 20.0),
                            child: Center(
                              child: Text(
                                  AppLocalizations.of(context)!.br,
                                  style: TextStyle(
                                    color: primary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                          )
                        : ListView.separated(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                jobDashboardPrice.toSet().toList().length,
                            itemBuilder: (context, index) {
                              return JobCategoryItem(
                                jobItemId: jobDashboardID[index],
                                index: index,
                                status: jobStatusOptions[index],
                                name: jobDashboardName[index],
                                imageLocation: jobDashboardImage[index],
                                jobType: jobDashboardJobType[index],
                                price: jobDashboardPrice[index],
                                chargeRate: jobDashboardChargeRate[index],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: screenHeight * 20);
                            },
                          );
                  }
                  return SizedBox();
                  // return Center(child:CircularProgressIndicator(),);
                }),
          ],
        ),
      ),
    );
  }
}

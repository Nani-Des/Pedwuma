// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:handyman_app/Components/carousel_slider_item.dart';
import 'package:handyman_app/Components/search_bar_item.dart';
import 'package:handyman_app/constants.dart';
import '../../../../Components/category_item.dart';
import '../../../../Components/dashboard_tab.dart';
import '../../../../Models/customer_category_data.dart';
import '../../../Custom Search Delegate/handyman_search_delegate.dart';
import '../../../Home/Components/body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

List<dynamic> selectedCategoryDataList = [];

Future selectedCategoryData(String categoryName) async {
  handymanDashboardJobType.clear();
  handymanDashboardName.clear();
  handymanDashboardPrice.clear();
  handymanDashboardRating.clear();
  handymanDashboardChargeRate.clear();
  handymanDashboardID.clear();
  handymanDashboardImage.clear();

  try {
    final documents = await FirebaseFirestore.instance
        .collection('Handyman Job Upload')
        .where('Service Information.Service Category', isEqualTo: categoryName)
        .where('Customer ID', isNotEqualTo: loggedInUserId)
        .get();
    
    if (documents.docs.isNotEmpty) {
      documents.docs.forEach((document) {
        final documentData = document.data();
        final categoryData = CustomerCategoryData(
          pic: documentData['User Pic'],
          jobID: documentData['Job ID'],
          seenBy: documentData['Seen By'],
          fullName: documentData['Name'],
          jobService: documentData['Service Information']['Service Provided'],
          rating: documentData['Work Experience & Certification']['Rating'],
          charge: documentData['Service Information']['Charge'],
          chargeRate: documentData['Service Information']['Charge Rate'],
          jobCategory: documentData['Service Information']['Service Category'],
        );
    
        handymanDashboardImage.add(categoryData.pic);
        handymanDashboardID.add(categoryData.jobID);
        handymanDashboardJobType.add(categoryData.jobService);
        handymanDashboardName.add(categoryData.fullName);
        handymanDashboardPrice.add(categoryData.charge.toString());
        handymanDashboardRating.add(categoryData.rating);
        if (categoryData.chargeRate == 'Hour') {
          handymanDashboardChargeRate.add('Hr');
        } else if (categoryData.chargeRate == '6 Hours') {
          handymanDashboardChargeRate.add('6 Hrs');
        } else if (categoryData.chargeRate == '12 Hours') {
          handymanDashboardChargeRate.add('12 Hrs');
        } else {
          handymanDashboardChargeRate.add('Day');
        }
      });
    } else {
      print('No Jobs Found.');
    }
  } on Exception catch (error) {
    // TODO
    print('Error fetching data: $error');
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
              hintText: AppLocalizations.of(context)!.bq,
              onSearchTap: () {
                showSearch(
                  context: context,
                  delegate: HandymanSearchDelegate(
                      itemsToSearch: handymanDashboardJobType),
                );
              },
            ),
            SizedBox(height: screenHeight * 15),
            CarouselSliderItem(),
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
                padding: EdgeInsets.only(
                    left: 10 * screenWidth, right: 0 * screenWidth),
                itemCount: dashBoardTabList.toSet().toList().length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => DashboardTab(
                  onTabSelected: onTabSelected,
                  text: dashBoardTabList[index],
                  index: index,
                  selectedTabIndex: selectedTabIndex,
                ),
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: screenWidth * 15);
                },
              ),
            ),
            SizedBox(height: screenHeight * 25),
            FutureBuilder(
                future: dashBoardTabList[selectedTabIndex] == 'All'
                    ? getCustomerCategoryData()
                    : selectedCategoryData(dashBoardTabList[selectedTabIndex]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    print('handymanDashboardPrice: $handymanDashboardPrice');
                    return handymanDashboardPrice.isEmpty
                        ? Padding(
                            padding: EdgeInsets.only(top: screenHeight * 20.0),
                            child: Center(
                              child: Text(
                                  AppLocalizations.of(context)!.br,
                                  style: TextStyle(
                                    color: green,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                          )
                        : ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                handymanDashboardPrice.toSet().toList().length,
                            itemBuilder: (context, index) {
                              return CategoryItem(
                                imageLocation: handymanDashboardImage[index],
                                jobType: handymanDashboardJobType[index],
                                name: handymanDashboardName[index],
                                price: handymanDashboardPrice[index],
                                rating: handymanDashboardRating[index],
                                chargeRate: handymanDashboardChargeRate[index],
                                index: index,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: screenHeight * 20);
                            },
                          );
                  }
                  return SizedBox();
                }),
          ],
        ),
      ),
    );
  }
}

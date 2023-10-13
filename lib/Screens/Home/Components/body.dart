// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handyman_app/Models/category.dart';
import 'package:handyman_app/Models/customer_category_data.dart';
import 'package:handyman_app/Models/handyman_category_data.dart';
import 'package:handyman_app/Screens/Bookings/customer_bookings_screen.dart';
import 'package:handyman_app/Screens/Dashboard/Handymen/handymen_dashboard_screen.dart';
import 'package:handyman_app/Screens/Dashboard/Jobs/jobs_dashboard_screen.dart';
import 'package:handyman_app/Screens/My%20Jobs/my_jobs_screen.dart';
import 'package:handyman_app/Screens/Notifications/notification_screen.dart';
import 'package:handyman_app/Screens/Profile/Profile%20-%20Customer/profile_customer.dart';
import 'package:handyman_app/Screens/Profile/Profile%20-%20Handyman/profile_handyman.dart';
import 'package:handyman_app/Services/read_data.dart';
import 'package:handyman_app/Services/storage_service.dart';
import 'package:handyman_app/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../Components/home_buttons.dart';
import '../../../Components/home_screen_tabs.dart';
import '../../../Components/horizontal_divider.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

List<String> servicesProvided = [];

List<String> allCategoriesName = [];
List<dynamic> allCustomerCategoryData = [];
List<dynamic> allHandymanCategoryData = [];

Future getAllCategories() async {
  final documents =
      await FirebaseFirestore.instance.collection('Category').get().timeout(
    Duration(seconds: 30), // Set your desired timeout duration
    onTimeout: () {
      throw TimeoutException("Unable to communicate with server.");
    },
  );

  documents.docs.forEach((document) {
    final data = document.get('Category Name');
    if (!allCategoriesName.contains(data)) {
      allCategoriesName.add(data);
    }
  });
  allCategoriesName.sort();
  dashBoardTabList = dashBoardTabList + allCategoriesName;
}

Future getCategoryData(String categoryName) async {
  final document = await FirebaseFirestore.instance
      .collection('Category')
      .where('Category Name', isEqualTo: categoryName)
      .get()
      .timeout(
    Duration(seconds: 30), // Set your desired timeout duration
    onTimeout: () {
      throw TimeoutException("Unable to communicate with server.");
    },
  );

  if (document.docs.isNotEmpty) {
    final category = document.docs.single.data();
    final $categoryName = CategoryData(
        categoryName: category['Category Name'],
        servicesProvided: List<String>.from(category['Services Provided']));

    servicesProvided = $categoryName.servicesProvided;
    serviceProvHintText = servicesProvided[0];
    servicesProvided.sort();
  } else {
    print('Item not found.');
  }
}

Future getCustomerCategoryData() async {
  allCustomerCategoryData.clear();
  handymanDashboardJobType.clear();
  handymanDashboardName.clear();
  handymanDashboardPrice.clear();
  handymanDashboardRating.clear();
  handymanDashboardChargeRate.clear();
  handymanDashboardID.clear();
  handymanDashboardImage.clear();

  final documents = await FirebaseFirestore.instance
      .collection('Handyman Job Upload')
      .where('Seen By', isEqualTo: 'All')
      .where('Customer ID', isNotEqualTo: loggedInUserId)
      .orderBy('Customer ID')
      .get()
      .timeout(
    Duration(seconds: 30), // Set your desired timeout duration
    onTimeout: () {
      throw TimeoutException("Unable to communicate with server.");
    },
  );

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
      if (!allCustomerCategoryData
          .any((item) => item.jobID == categoryData.jobID)) {
        allCustomerCategoryData.add(categoryData);

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
      }
    });
  } else {
    print('No Jobs Found.');
  }
}

Future getHandymanCategoryData() async {
  allHandymanCategoryData.clear();
  jobStatusOptions.clear();
  jobDashboardJobType.clear();
  jobDashboardName.clear();
  jobDashboardPrice.clear();
  jobDashboardChargeRate.clear();
  jobDashboardID.clear();
  jobDashboardImage.clear();

  final documents = await FirebaseFirestore.instance
      .collection('Customer Job Upload')
      .where('Seen By', isEqualTo: 'All')
      .where('Customer ID', isNotEqualTo: loggedInUserId)
      .orderBy('Customer ID')
      .get()
      .timeout(
    Duration(seconds: 30), // Set your desired timeout duration
    onTimeout: () {
      throw TimeoutException("Unable to communicate with server.");
    },
  );

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
      if (!allHandymanCategoryData
          .any((item) => item.jobID == categoryData.jobID)) {
        allHandymanCategoryData.add(categoryData);

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
      }
    });
  } else {
    print('No Jobs Found.');
  }
}

Future getRatings() async {
  final result = await FirebaseFirestore.instance
      .collection('profile')
      .where('User ID', isEqualTo: loggedInUserId)
      .get()
      .timeout(
    Duration(seconds: 30), // Set your desired timeout duration
    onTimeout: () {
      throw TimeoutException("Unable to communicate with server.");
    },
  );
  if (result.docs.isNotEmpty) {
    final querySnapshot =
        result.docs.first.get('Work Experience & Certification.Rating');
    if (querySnapshot == 0) {
      ratingHintText = '0.0';
    } else {
      ratingHintText = querySnapshot.toString();
    }
  } else {
    print('No user found.');
  }
}

class _BodyState extends State<Body> {
  late String downloadUrl;
  ReadData readData = ReadData();

  Future getProfilePic() async {
    final listReference =
        await FirebaseStorage.instance.ref('$loggedInUserId/profile').list();
    if (listReference.items.isNotEmpty) {
      downloadUrl = await Storage().downloadUrl('profile_pic');
      setState(() {
        imageUrl = downloadUrl;
      });
    }
  }

  Future allData() async {
    readData.getFirstName();
    await getAllCategories();
    await getCategoryData(allCategoriesName[0]);
    await getCustomerCategoryData();
    await getHandymanCategoryData();
    await getRatings();
    await readData.getBookmarkedData();
  }

  @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: allData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${AppLocalizations.of(context)!.bm} ${allUsers[0].firstName}',
                      style: TextStyle(
                          fontFamily: 'Habibi',
                          fontSize: 30,
                          color: Colors.black),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 26),
                      child: Text(
                        AppLocalizations.of(context)!.bn,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: primary,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 40.0),
                      child: Center(
                        child: HomeScreenTabs(
                          title: AppLocalizations.of(context)!.handyworker,
                          screen: HandymanDashboardScreen(),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight * 30.0),
                      child: HorizontalDivider(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 50.0),
                      child: allUsers[0].role == 'Regular Customer'
                          ? Center(
                              child: HomeScreenTabs(
                                isButtonClickable: false,
                                title: AppLocalizations.of(context)!.jobs,
                                screen: JobsDashboardScreen(),
                              ),
                            )
                          : Center(
                              child: HomeScreenTabs(
                                title: AppLocalizations.of(context)!.jobs,
                                screen: JobsDashboardScreen(),
                              ),
                            ),
                    ),
                    allUsers[0].role == 'Regular Customer'
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              HomeButtons(
                                  press: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CustomerBookingsScreen(),
                                      ),
                                    );
                                  },
                                  title: AppLocalizations.of(context)!.bookings),
                              Container(
                                height: size.height * 40 / 820.5714,
                                width: size.width * 2 / 411.4285,
                                color: grey,
                              ),
                              HomeButtons(
                                  press: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProfileCustomer(),
                                      ),
                                    );
                                  },
                                  title: 'Profile'),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              HomeButtons(
                                  press: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyJobsScreen(),
                                      ),
                                    );
                                  },
                                  title: AppLocalizations.of(context)!.myjobs),
                              Container(
                                height: size.height * 40 / 820.5714,
                                width: size.width * 2 / 411.4285,
                                color: grey,
                              ),
                              HomeButtons(
                                  press: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            HandymanProfileScreen(),
                                      ),
                                    );
                                  },
                                  title: AppLocalizations.of(context)!.profile),
                            ],
                          ),
                  ],
                ),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Stack(children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context)!.bm,
                      style: TextStyle(
                          fontFamily: 'Habibi',
                          fontSize: 30,
                          color: Colors.black),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 26),
                      child: Text(
                        AppLocalizations.of(context)!.bn,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: primary,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 40.0),
                      child: Center(
                        child: HomeScreenTabs(
                          title: AppLocalizations.of(context)!.handymen,
                          screen: HandymanDashboardScreen(),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight * 30.0),
                      child: HorizontalDivider(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 50.0),
                      child: Center(
                        child: HomeScreenTabs(
                          title: AppLocalizations.of(context)!.jobs,
                          screen: JobsDashboardScreen(),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HomeButtons(
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CustomerBookingsScreen(),
                                ),
                              );
                            },
                            title: 'N/A'),
                        Container(
                          height: size.height * 40 / 820.5714,
                          width: size.width * 2 / 411.4285,
                          color: grey,
                        ),
                        HomeButtons(
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileCustomer(),
                                ),
                              );
                            },
                            title: AppLocalizations.of(context)!.profile),
                      ],
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  ModalBarrier(
                    color: black.withOpacity(0.3),
                    dismissible: false,
                  ),
                  AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    insetPadding:
                        EdgeInsets.symmetric(horizontal: 150 * screenWidth),
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        (Platform.isIOS)
                            ? const CupertinoActivityIndicator(
                                radius: 20,
                                color: Color(0xff32B5BD),
                              )
                            : const CircularProgressIndicator(
                                color: Color(0xff32B5BD),
                              ),
                      ],
                    ),
                  )
                ],
              ),
            ]);
          }
          if (snapshot.hasError) {
            return Center(child: Text('${AppLocalizations.of(context)!.err}:${snapshot.error}'));
          }
          return Center(
            child: Platform.isIOS
                ? CupertinoActivityIndicator(color: primary)
                : CircularProgressIndicator(color: primary),
          );
        });
  }
}

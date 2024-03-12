// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
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
import '../../../Components/home_screen_tabs1.dart';
import '../../../Components/horizontal_divider.dart';
import '../../Login/login_screen.dart';

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
      .collection('Booking Profile')
      .where('Seen By', isEqualTo: 'All')
      .where('User ID', isNotEqualTo: loggedInUserId)
      .orderBy('User ID')
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
      .collection('Jobs')
      .where('Seen By', isEqualTo: 'All')
      .where('User ID', isNotEqualTo: loggedInUserId)
      .orderBy('User ID')
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
    if (FirebaseAuth.instance.currentUser == null) {
      // If not logged in, navigate to the LoginScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
      return;
    }


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
            loggedInUserId = FirebaseAuth.instance.currentUser!.uid;
            return FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where('User ID', isEqualTo: loggedInUserId)
                  .get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  // Return a loading indicator if data is still loading
                  return CircularProgressIndicator();
                }

                if (userSnapshot.hasData) {
                  // Check the role and return the appropriate dashboard
                  String role = userSnapshot.data!.docs.first.get('Role');

                  if (role == 'Regular Customer') {
                    return HandymanDashboardScreen();
                  } else if (role == 'Professional Handyman') {
                    return JobsDashboardScreen();
                  } else {
                    // Handle other roles as needed
                    return Container();
                  }
                } else {
                  return Container();
                }
              },
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {}
          if (snapshot.hasError) {
            return Center(child: Text('${AppLocalizations.of(context)!.errr}'));
          }
          return Center(
            child: Platform.isIOS
                ? CupertinoActivityIndicator(color: primary)
                : CircularProgressIndicator(color: primary),
          );
        });
  }
}

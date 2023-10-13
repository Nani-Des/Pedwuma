// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_function_literals_in_foreach_calls, avoid_print

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:handyman_app/Models/bookmark.dart';
import 'package:handyman_app/Models/customer_applied.dart';
import 'package:handyman_app/Models/customer_job_upload_item_data.dart';
import 'package:handyman_app/Models/handyman_applied.dart';
import 'package:handyman_app/Models/job_item_data.dart';
import 'package:handyman_app/Screens/Chat/Sub%20Screen/chat_page.dart';
import 'package:handyman_app/Screens/Dashboard/Handymen/handymen_dashboard_screen.dart';
import 'package:handyman_app/Screens/Dashboard/Jobs/jobs_dashboard_screen.dart';
import 'package:handyman_app/Screens/Handyman%20Details/handyman_details_screen.dart';
import 'package:handyman_app/Screens/Job%20Upload/Sub%20Screen/Customer/customer_job_upload_list.dart';
import 'package:handyman_app/Screens/Job%20Upload/Sub%20Screen/Handyman/Components/body.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../Components/job_upload_optionals_info.dart';
import '../Models/customer_category_data.dart';
import '../Models/handyman_category_data.dart';
import '../Models/handyman_job_upload_item_data.dart';
import '../Models/review.dart';
import '../Models/users.dart';
import '../Screens/Job Upload/Sub Screen/Customer/Components/body.dart';
import '../Screens/My Jobs/SubScreens/JobUpcoming/Components/body.dart';
import '../constants.dart';

List<dynamic> allJobItemList = [];
List<dynamic> jobUploadItemData = [];
List<dynamic> allJobUpcoming = [];
List jobCustomerUpcomingIDs = [];
List jobHandymanUpcomingIDs = [];
List<dynamic> allJobApplied = [];
List jobCustomerAppliedIDs = [];
List jobHandymanAppliedIDs = [];
List<dynamic> allJobCompleted = [];
List jobHandymanCompletedIDs = [];
List jobCustomerCompletedIDs = [];
List<dynamic> allJobOffers = [];
List<dynamic> moreOffers = [];
List<dynamic> allReviews = [];
List jobCustomerOffersIDs = [];
List jobHandymanOffersIDs = [];
List allUsers = [];
List allProfile = [];
var fcmToken = '';
late CustomerJobUploadItemData jobUploadData;
late HandymanJobUploadItemData handymanJobUploadData;
String appointmentChargeRate = '';
double ratingTotal = 0;

class ReadData {
  Future getFCMToken(bool isLogin) async {
    final token = await FirebaseMessaging.instance.getToken().timeout(
      Duration(seconds: 30), // Set your desired timeout duration
      onTimeout: () {
        throw TimeoutException("Unable to communicate with server.");
      },
    );
    if (token != null) {
      fcmToken = token;
    }
    if (isLogin) {
      final document = await FirebaseFirestore.instance
          .collection('users')
          .where('User ID', isEqualTo: loggedInUserId)
          .get();

      final userToken = document.docs.single.get('FCM Token');
      if (userToken != token) {
        final docID = document.docs.single.id;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(docID)
            .update({'FCM Token': token});
      }
    }
  }

  Future getPhoneNumber(
      String type, BuildContext context, bool phoneNumber) async {
    if (phoneNumber) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            insetPadding: EdgeInsets.symmetric(horizontal: 150 * screenWidth),
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
          );
        },
      );
    }

    late final document;
    if (type == 'Customer') {
      document = await FirebaseFirestore.instance
          .collection('Handyman Job Upload')
          .doc(handymanDashboardID[handymanSelectedIndex])
          .get()
          .timeout(
        Duration(seconds: 30), // Set your desired timeout duration
        onTimeout: () {
          throw TimeoutException("Unable to communicate with server.");
        },
      );
    } else {
      document = await FirebaseFirestore.instance
          .collection('Customer Job Upload')
          .doc(jobDashboardID[jobSelectedIndex])
          .get()
          .timeout(
        Duration(seconds: 30), // Set your desired timeout duration
        onTimeout: () {
          throw TimeoutException("Unable to communicate with server.");
        },
      );
    }

    final userID = document.get('Customer ID');

    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('User ID', isEqualTo: userID)
        .get();
    if (phoneNumber) {
      final number = querySnapshot.docs.single.get('Mobile Number');

      final phoneNumber = 'tel: +233$number';

      if (await canLaunchUrlString(phoneNumber)) {
        launchUrlString(phoneNumber);
      }
      Navigator.pop(context);
    } else {
      final firstName = querySnapshot.docs.single.get('First Name');
      final lastName = querySnapshot.docs.single.get('Last Name');
      final name = '$firstName $lastName';
      final id = querySnapshot.docs.single.get('User ID');
      final pic = querySnapshot.docs.single.get('Pic');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(
            userName: name,
            receiverUserID: id,
            pic: pic,
          ),
        ),
      );
    }
  }

  Future getFirstName() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('User ID', isEqualTo: loggedInUserId)
        .get()
        .timeout(
      Duration(seconds: 30), // Set your desired timeout duration
      onTimeout: () {
        throw TimeoutException("Unable to communicate with server.");
      },
    );

    if (querySnapshot.docs.isNotEmpty) {
      final userData = querySnapshot.docs.first.data();
      final user = UserData(
        pic: userData['Pic'],
        userId: userData['User ID'],
        firstName: userData['First Name'],
        lastName: userData['Last Name'],
        number: userData['Mobile Number'],
        email: userData['Email Address'],
        role: userData['Role'],
      );
      allUsers.add(user);
      imageUrl = user.pic;
    } else {
      return 'User Not Found';
    }
  }

  Future getReviews(BuildContext context) async {
    allReviews.clear();
    ratingTotal = 0.0;
    List starsCount = [0, 0, 0, 0, 0];

    try {
      final documents = await FirebaseFirestore.instance
          .collection('Reviews')
          .where('User ID', isEqualTo: allJobItemList[0].customerID)
          .orderBy('Stars', descending: true)
          .get()
          .timeout(
        Duration(seconds: 2), // Set your desired timeout duration
        onTimeout: () {
          throw TimeoutException("Unable to communicate with server.");
        },
      );

      if (documents.docs.isNotEmpty) {
        for (var document in documents.docs) {
          final documentData = document.data();
          final userID = documentData['User ID'];
          final reviewerDoc = await FirebaseFirestore.instance
              .collection('users')
              .where('User ID', isEqualTo: userID)
              .get();
          final reviewerName = reviewerDoc.docs.single.get('First Name');
          final review = ReviewData(
            name: reviewerName,
            reviewDate: documentData['Review Date'],
            userID: documentData['User ID'],
            replies: documentData['Replies'],
            reviewID: documentData['Review ID'],
            jobID: documentData['Job ID'],
            stars: documentData['Stars'],
            comment: documentData['Comment'],
            likes: documentData['Likes'],
          );

          ratingTotal += review.stars;
          if (review.stars == 1) {
            starsCount[0] = starsCount[0] + 1;
          } else if (review.stars == 2) {
            starsCount[1] = starsCount[1] + 1;
          } else if (review.stars == 3) {
            starsCount[2] = starsCount[2] + 1;
          } else if (review.stars == 4) {
            starsCount[3] = starsCount[3] + 1;
          } else {
            starsCount[4] = starsCount[4] + 1;
          }

          allReviews.add(review);
        }
        ratingTotal = ratingTotal / allReviews.length;

        ratingsWidth = [
          starsCount[0] / allReviews.length * 159,
          starsCount[1] / allReviews.length * 159,
          starsCount[2] / allReviews.length * 159,
          starsCount[3] / allReviews.length * 159,
          starsCount[4] / allReviews.length * 159,
        ];
        print(ratingTotal);
      }
    } on FirebaseException catch (error) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'Error'.toUpperCase(),
                style: TextStyle(color: primary, fontSize: 17),
              ),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            content: Text(
              '$error\nTry again later.',
              style: TextStyle(
                height: 1.4,
                fontSize: 16,
                color: black,
              ),
            ),
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'Error'.toUpperCase(),
                style: TextStyle(color: primary, fontSize: 17),
              ),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            content: Text(
              '$e\nTry again later.',
              style: TextStyle(
                height: 1.4,
                fontSize: 16,
                color: black,
              ),
            ),
          );
        },
      );
    }
  }

  Future getHandymanJobItemData(String jobId) async {
    allJobItemList.clear();

    try {
      final document = await FirebaseFirestore.instance
          .collection('Customer Job Upload')
          .where('Job ID', isEqualTo: jobId)
          .get()
          .timeout(
        Duration(seconds: 30), // Set your desired timeout duration
        onTimeout: () {
          throw TimeoutException("Unable to communicate with server.");
        },
      );

      if (document.docs.isNotEmpty) {
        currentJobClickedUserId = document.docs.single.get('Customer ID');

        final documentData = document.docs.single.data();

        final jobItemData = JobItemData(
          customerID: documentData['Customer ID'],
          pic: documentData['User Pic'] == '' ? '' : documentData['User Pic'],
          deadline: documentData['Job Details']['Deadline'],
          peopleApplied: documentData['Job Details']['People Applied'],
          jobID: documentData['Job ID'],
          seenBy: documentData['Seen By'],
          chargeRate: documentData['Service Information']['Charge Rate'] ==
                  'Hour'
              ? 'Hr'
              : documentData['Service Information']['Charge Rate'] == '6 hours'
                  ? '6 Hrs'
                  : documentData['Service Information']['Charge Rate'] ==
                          '12 hours'
                      ? '12 Hrs'
                      : documentData['Service Information']['Charge Rate'],
          jobCategory: documentData['Service Information']['Service Category'],
          fullName: documentData['Name'],
          jobService: documentData['Service Information']['Service Provided'],
          charge: documentData['Service Information']['Charge'],
          jobStatus: documentData['Job Details']['Job Status'],
          isPortfolioPresent: documentData['Optional']['Portfolio Present'],
          isReferencesPresent: documentData['Optional']['References Present'],
        );
        allJobItemList.add(jobItemData);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getCustomerJobItemData(String jobId) async {
    allJobItemList.clear();

    try {
      final document = await FirebaseFirestore.instance
          .collection('Handyman Job Upload')
          .where('Job ID', isEqualTo: jobId)
          .get()
          .timeout(
        Duration(seconds: 30), // Set your desired timeout duration
        onTimeout: () {
          throw TimeoutException("Unable to communicate with server.");
        },
      );

      if (document.docs.isNotEmpty) {
        currentJobClickedUserId = document.docs.single.get('Customer ID');

        final documentData = document.docs.single.data();
        appointmentChargeRate =
            documentData['Service Information']['Charge Rate'];
        final jobItemData = JobItemData(
          customerID: documentData['Customer ID'],
          jobsDone: documentData['Work Experience & Certification']
              ["Job's Completed"],
          references: documentData['Work Experience & Certification']
                  ['References'] ??
              [],
          rating: documentData['Work Experience & Certification']['Rating'],
          certification: documentData['Work Experience & Certification']
                  ['Certification'] ??
              [],
          experience: documentData['Work Experience & Certification']
                  ['Experience'] ??
              [],
          pic: documentData['User Pic'],
          jobID: documentData['Job ID'],
          seenBy: documentData['Seen By'],
          chargeRate: documentData['Service Information']['Charge Rate'] ==
                  'Hour'
              ? 'Hr'
              : documentData['Service Information']['Charge Rate'] == '6 Hours'
                  ? '6 Hrs'
                  : documentData['Service Information']['Charge Rate'] ==
                          '12 Hours'
                      ? '12 Hrs'
                      : documentData['Service Information']['Charge Rate'],
          jobCategory: documentData['Service Information']['Service Category'],
          fullName: documentData['Name'],
          jobService: documentData['Service Information']['Service Provided'],
          charge: documentData['Service Information']['Charge'],
        );
        allJobItemList.add(jobItemData);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getCustomerJobUploadItemData(
      String jobID, TextEditingController charge) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Customer Job Upload')
          .doc(jobID)
          .get()
          .timeout(
        Duration(seconds: 30), // Set your desired timeout duration
        onTimeout: () {
          throw TimeoutException("Unable to communicate with server.");
        },
      );

      if (querySnapshot.exists) {
        final documentData = querySnapshot.data()!;

        final expiry = documentData['Job Details']['Deadline'];
        final day = expiry[0].toString() + expiry[1].toString();
        final month = expiry[3].toString() + expiry[4].toString();
        final year = expiry[6].toString() +
            expiry[7].toString() +
            expiry[8].toString() +
            expiry[9].toString();
        jobUploadData = CustomerJobUploadItemData(
            jobUploadId: documentData['Job ID'],
            serviceProvided: documentData['Service Information']
                ['Service Provided'],
            seenBy: documentData['Seen By'],
            deadlineDay: day,
            deadlineMonth: month,
            deadlineYear: year,
            serviceCat: documentData['Service Information']['Service Category'],
            charge: documentData['Service Information']['Charge'].toString(),
            chargeRate: documentData['Service Information']['Charge Rate'],
            rating: documentData['Work Detail & Rating']['Rating'],
            houseNum: documentData['Address Information']['House Number'],
            region: documentData['Address Information']['Region'],
            town: documentData['Address Information']['Town'],
            street: documentData['Address Information']['Street'],
            portfolioOption: documentData['Optional']['Portfolio Present'],
            referenceOption: documentData['Optional']['References Present'],
            expertise: documentData['Service Information']['Expertise'],
            portfolio: documentData['Work Detail & Rating']['Portfolio']);

        seenByHintText = jobUploadData.seenBy;
        deadlineDay = jobUploadData.deadlineDay;
        deadlineMonth = jobUploadData.deadlineMonth;
        deadlineYear = jobUploadData.deadlineYear;
        serviceCatHintText = jobUploadData.serviceCat;
        serviceProvHintText = jobUploadData.serviceProvided;
        charge.text = jobUploadData.charge.toString();
        chargePHint = jobUploadData.chargeRate;
        expertHint = jobUploadData.expertise ?? 'N/A';
        uploadPortfolioList = jobUploadData.portfolio ?? [];
        ratingHintText = jobUploadData.rating;
        uploadTown = jobUploadData.town;
        uploadStreet = jobUploadData.street;
        uploadRegion = jobUploadData.region;
        uploadHouseNum = jobUploadData.houseNum;
        isReferencesTicked = jobUploadData.referenceOption;
        isPortfolioTicked = jobUploadData.portfolioOption;

        return jobUploadData;
      } else {
        throw ('Document does not exist');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getHandymanJobUploadItemData(
      String jobID, TextEditingController charge) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Handyman Job Upload')
          .doc(jobID)
          .get()
          .timeout(
        Duration(seconds: 30), // Set your desired timeout duration
        onTimeout: () {
          throw TimeoutException("Unable to communicate with server.");
        },
      );

      if (querySnapshot.exists) {
        final documentData = querySnapshot.data()!;

        //TODO: MODIFY SUCH THAT IT DISPLAYS HOW MANY DAYS MORE TILL JOB BECOMES INVALID
        final expiry = documentData['Deadline'];
        final day = expiry[0].toString() + expiry[1].toString();
        final month = expiry[3].toString() + expiry[4].toString();
        final year = expiry[6].toString() +
            expiry[7].toString() +
            expiry[8].toString() +
            expiry[9].toString();
        handymanJobUploadData = HandymanJobUploadItemData(
          jobUploadId: documentData['Job ID'],
          serviceProvided: documentData['Service Information']
              ['Service Provided'],
          seenBy: documentData['Seen By'],
          deadlineDay: day,
          deadlineMonth: month,
          deadlineYear: year,
          serviceCat: documentData['Service Information']['Service Category'],
          charge: documentData['Service Information']['Charge'].toString(),
          chargeRate: documentData['Service Information']['Charge Rate'],
          rating: documentData['Work Experience & Certification']['Rating'],
          houseNum: documentData['Address Information']['House Number'],
          region: documentData['Address Information']['Region'],
          town: documentData['Address Information']['Town'],
          street: documentData['Address Information']['Street'],
          expertise: documentData['Service Information']['Expertise'],
          portfolio: documentData['Work Experience & Certification']
              ['Portfolio'],
          references: documentData['Work Experience & Certification']
              ['References'],
          experience: documentData['Work Experience & Certification']
              ['Experience'],
          certification: documentData['Work Experience & Certification']
              ['Certification'],
        );

        seenByHintText = handymanJobUploadData.seenBy;
        deadlineDay = handymanJobUploadData.deadlineDay;
        deadlineMonth = handymanJobUploadData.deadlineMonth;
        deadlineYear = handymanJobUploadData.deadlineYear;
        serviceCatHintText = handymanJobUploadData.serviceCat;
        serviceProvHintText = handymanJobUploadData.serviceProvided;
        charge.text = handymanJobUploadData.charge.toString();
        chargePHint = handymanJobUploadData.chargeRate;
        expertHint = handymanJobUploadData.expertise ?? 'N/A';
        uploadPortfolioList = handymanJobUploadData.portfolio ?? [];
        uploadReferenceList = handymanJobUploadData.references ?? [];
        uploadCertList = handymanJobUploadData.certification ?? [];
        uploadExperienceList = handymanJobUploadData.experience ?? [];
        ratingHintText = handymanJobUploadData.rating;
        uploadTown = handymanJobUploadData.town;
        uploadStreet = handymanJobUploadData.street;
        uploadRegion = handymanJobUploadData.region;
        uploadHouseNum = handymanJobUploadData.houseNum;

        return handymanJobUploadData;
      } else {
        throw ('Document does not exist');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteJobUpload(BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('Customer Job Upload')
          .doc(allCustomerJobsUpload[selectedJobUploadIndex].jobUploadId)
          .delete()
          .catchError((err) {
        print(err.toString());
      });

      //directory in firebase storage whose files and sub directories are to be deleted
      final directoryRef = FirebaseStorage.instance.ref().child(
          '$loggedInUserId/Customer Job Upload/${allCustomerJobsUpload[selectedJobUploadIndex].jobUploadId}');

      //deleting all files present in directoryReference specified
      try {
        final querySnapshot = await directoryRef.listAll();
        querySnapshot.items.forEach((file) async {
          await file.delete();
        });

        //deleting all files present in each sub directory
        querySnapshot.prefixes.forEach((folder) async {
          final result = await folder.listAll();
          result.items.forEach((file) async {
            await file.delete();
          });
        });
      } catch (e) {
        print(e.toString());
      }
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            insetPadding: EdgeInsets.symmetric(horizontal: 10 * screenWidth),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image(image: AssetImage('assets/images/success.gif')),
                SizedBox(height: 15 * screenHeight),
                Text(
                  'Job Upload Deleted Successfully!',
                  style: TextStyle(
                    color: black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          );
        },
      );

      await Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HandymanDashboardScreen(),
          ),
        );
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future handymanDeleteJobUpload(BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('Handyman Job Upload')
          .doc(allHandymanJobsUpload[selectedJobUploadIndex].jobUploadId)
          .delete()
          .catchError((err) {
        print(err.toString());
      });

      //directory in firebase storage whose files and sub directories are to be deleted
      final directoryReference = await FirebaseStorage.instance.ref(
          '$loggedInUserId/Handyman Job Upload/${allHandymanJobsUpload[selectedJobUploadIndex].jobUploadId}');

      //deleting all files present in directoryReference specified
      try {
        final querySnapshot = await directoryReference.listAll();
        querySnapshot.items.forEach((file) async {
          await file.delete();
        });

        //deleting all files present in each sub directory
        querySnapshot.prefixes.forEach((folder) async {
          final querySnapshot = await folder.listAll();
          querySnapshot.items.forEach((file) async {
            await file.delete();
          });
        });
      } catch (e) {
        print(e.toString());
      }

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            insetPadding: EdgeInsets.symmetric(horizontal: 10 * screenWidth),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image(image: AssetImage('assets/images/success.gif')),
                SizedBox(height: 15 * screenHeight),
                Text(
                  'Job Upload Deleted Successfully!',
                  style: TextStyle(
                    color: black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          );
        },
      );

      await Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => JobsDashboardScreen(),
          ),
        );
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future getBookmarkedData() async {
    handymenJobsBookmarked.clear();
    customerJobsBookmarked.clear();
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Bookmark')
          .where('User ID', isEqualTo: loggedInUserId)
          .get()
          .timeout(
        Duration(seconds: 30), // Set your desired timeout duration
        onTimeout: () {
          throw TimeoutException("Unable to communicate with server.");
        },
      );

      if (querySnapshot.docs.isNotEmpty) {
        final documentData = querySnapshot.docs.single.data();
        final bookmarkData = Bookmark(
          bookmarkId: documentData['Bookmark ID'],
          customerId: documentData['User ID'],
          handymanIdList: documentData['Handyman Job IDs'] == []
              ? []
              : documentData['Handyman Job IDs'],
          customerIdList: documentData['Customer Job IDs'] == []
              ? []
              : documentData['Customer Job IDs'],
        );
        handymenJobsBookmarked = List<String>.from(bookmarkData.handymanIdList);
        customerJobsBookmarked = List<String>.from(bookmarkData.customerIdList);
      } else {
        print('No documents present.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getCustomerFavouritesData() async {
    customerFavouritesImageList.clear();
    customerFavouritesChargeList.clear();
    customerFavouritesNameList.clear();
    customerFavouritesJobTypeList.clear();
    customerFavouritesRatingList.clear();
    customerFavouritesChargeRateList.clear();
    customerFavouritesIDList.clear();

    try {
      if (handymenJobsBookmarked.isNotEmpty) {
        for (var document in handymenJobsBookmarked) {
          print(document);

          final querySnapshot = await FirebaseFirestore.instance
              .collection('Handyman Job Upload')
              .doc(document)
              .get()
              .timeout(
            Duration(seconds: 30), // Set your desired timeout duration
            onTimeout: () {
              throw TimeoutException("Unable to communicate with server.");
            },
          );
          final documentData = querySnapshot.data()!;
          final categoryData = CustomerCategoryData(
            pic: documentData['User Pic'],
            jobID: documentData['Job ID'],
            seenBy: documentData['Seen By'],
            fullName: documentData['Name'],
            jobService: documentData['Service Information']['Service Provided'],
            rating: documentData['Work Experience & Certification']['Rating'],
            charge: documentData['Service Information']['Charge'],
            chargeRate: documentData['Service Information']['Charge Rate'],
            jobCategory: documentData['Service Information']
                ['Service Category'],
          );

          customerFavouritesImageList.add(categoryData.pic);
          customerFavouritesIDList.add(categoryData.jobID);
          customerFavouritesJobTypeList.add(categoryData.jobService);
          customerFavouritesNameList.add(categoryData.fullName);
          customerFavouritesChargeList.add(categoryData.charge.toString());
          customerFavouritesRatingList.add(categoryData.rating);
          if (categoryData.chargeRate == 'Hour') {
            customerFavouritesChargeRateList.add('Hr');
          } else if (categoryData.chargeRate == '6 Hours') {
            customerFavouritesChargeRateList.add('6 Hrs');
          } else if (categoryData.chargeRate == '12 Hours') {
            customerFavouritesChargeRateList.add('12 Hrs');
          } else {
            customerFavouritesChargeRateList.add('Day');
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getHandymanFavouritesData() async {
    handymanFavouritesImageList.clear();
    handymanFavouritesChargeList.clear();
    handymanFavouritesNameList.clear();
    handymanFavouritesJobTypeList.clear();
    handymanFavouritesChargeRateList.clear();
    handymanFavouritesIDList.clear();

    try {
      if (customerJobsBookmarked.isNotEmpty) {
        for (var document in customerJobsBookmarked) {
          print(document);
          final querySnapshot = await FirebaseFirestore.instance
              .collection('Customer Job Upload')
              .doc(document)
              .get()
              .timeout(
            Duration(seconds: 30), // Set your desired timeout duration
            onTimeout: () {
              throw TimeoutException("Unable to communicate with server.");
            },
          );
          final documentData = querySnapshot.data()!;
          final categoryData = HandymanCategoryData(
              pic: documentData['User Pic'],
              jobID: documentData['Job ID'],
              seenBy: documentData['Seen By'],
              fullName: documentData['Name'],
              jobService: documentData['Service Information']
                  ['Service Provided'],
              charge: documentData['Service Information']['Charge'],
              chargeRate: documentData['Service Information']['Charge Rate'],
              jobCategory: documentData['Service Information']
                  ['Service Category'],
              jobStatus: documentData['Job Details']['Job Status']);

          handymanFavouritesIDList.add(categoryData.jobID);
          handymanFavouritesImageList.add(categoryData.pic);
          handymanFavouritesJobTypeList.add(categoryData.jobService);
          handymanFavouritesNameList.add(categoryData.fullName);
          handymanFavouritesStatusList.add(categoryData.jobStatus);
          handymanFavouritesChargeList.add(categoryData.charge.toString());
          if (categoryData.chargeRate == 'Hour') {
            handymanFavouritesChargeRateList.add('Hr');
          } else if (categoryData.chargeRate == '6 Hours') {
            handymanFavouritesChargeRateList.add('6 Hrs');
          } else if (categoryData.chargeRate == '12 Hours') {
            handymanFavouritesChargeRateList.add('12 Hrs');
          } else {
            handymanFavouritesChargeRateList.add('Day');
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getHandymanJobApplicationData(
      String tabName, String role, BuildContext context) async {
    if (tabName == 'Job Offers') {
      moreOffers.clear();

      allJobOffers.clear();
      jobCustomerOffersIDs.clear();
    } else if (tabName == 'Jobs Upcoming') {
      allJobUpcoming.clear();
      jobCustomerUpcomingIDs.clear();
    } else if (tabName == 'Jobs Applied') {
      allJobApplied.clear();
      jobCustomerAppliedIDs.clear();
    } else {
      allJobCompleted.clear();
      jobCustomerCompletedIDs.clear();
    }

    final querySnapshot = await FirebaseFirestore.instance
        .collection('Job Application')
        .where('Customer ID', isEqualTo: loggedInUserId)
        .get()
        .timeout(
      Duration(seconds: 30), // Set your desired timeout duration
      onTimeout: () {
        throw TimeoutException("Unable to communicate with server.");
      },
    );

    if (querySnapshot.docs.isNotEmpty) {
      try {
        final docID = querySnapshot.docs.single.id;

        final document = await FirebaseFirestore.instance
            .collection('Job Application')
            .doc(docID)
            .get();
        final docData = document.data()!;
        List<dynamic> documentIDs = docData[tabName][role];

        if (documentIDs.isNotEmpty) {
          for (var id in documentIDs) {
            final jobDoc = await FirebaseFirestore.instance
                .collection('Handyman Jobs Applied')
                .doc(id)
                .get();

            //to get more info about handyman jobs applied
            final docData = jobDoc.data()!;
            final offerData = CustomerAppliedData(
              note: docData['Note'],
              referenceLinks: docData['Reference Links'],
              portfolio: docData['Portfolio'],
              acceptedDate: docData['Accepted Date'],
              inProgressDate: docData['In Progress Date'],
              completedDate: docData['Completed Date'],
              jobStatus: docData['Job Status'],
              receiverID: docData['Receiver ID'],
              documentID: docData['Jobs Applied ID'],
              jobID: docData['Job ID'],
              applierID: docData['Applier ID'],
              name: docData['Name'],
              addressType: docData['Address Type'],
              street: docData['Street'],
              town: docData['Town'],
              notes: docData['Note'],
              houseNum: docData['House Number'],
              region: docData['Region'],
              time: docData['Schedule Time'],
              pic: docData['User Pic'],
              date: docData['Schedule Date'],
            );

            moreOffers.add(offerData);

            final jobID = jobDoc.get('Job ID');

            final document = await FirebaseFirestore.instance
                .collection('Customer Job Upload')
                .doc(jobID)
                .get();

            final documentData = document.data()!;
            final expiry = documentData['Job Details']['Deadline'];
            String day = expiry[0].toString() + expiry[1].toString();
            String month = expiry[3].toString() + expiry[4].toString();
            String year = expiry[6].toString() +
                expiry[7].toString() +
                expiry[8].toString() +
                expiry[9].toString();
            final jobData = CustomerJobUploadItemData(
                uploadDate: documentData['Upload Date'],
                name: documentData['Name'],
                pic: documentData['User Pic'] == ''
                    ? ''
                    : documentData['User Pic'],
                uploadTime: documentData['Upload Time'],
                jobUploadId: documentData['Job ID'],
                serviceProvided: documentData['Service Information']
                    ['Service Provided'],
                seenBy: documentData['Seen By'],
                deadlineDay: day,
                deadlineMonth: month,
                deadlineYear: year,
                serviceCat: documentData['Service Information']
                    ['Service Category'],
                charge:
                    documentData['Service Information']['Charge'].toString(),
                chargeRate: documentData['Service Information']['Charge Rate'],
                rating: documentData['Work Detail & Rating']['Rating'],
                houseNum: documentData['Address Information']['House Number'],
                region: documentData['Address Information']['Region'],
                town: documentData['Address Information']['Town'],
                street: documentData['Address Information']['Street'],
                portfolioOption: documentData['Optional']['Portfolio Present'],
                referenceOption: documentData['Optional']['References Present'],
                expertise: documentData['Service Information']['Expertise'],
                portfolio: documentData['Work Detail & Rating']['Portfolio']);

            if (tabName == 'Jobs Applied') {
              allJobApplied.add(jobData);
              jobCustomerAppliedIDs.add(jobData.jobUploadId);
            } else if (tabName == 'Jobs Upcoming') {
              allJobUpcoming.add(jobData);
              jobCustomerUpcomingIDs.add(jobData.jobUploadId);
            } else if (tabName == 'Job Offers') {
              allJobOffers.add(jobData);
              jobCustomerOffersIDs.add(jobData.jobUploadId);
            } else {
              allJobCompleted.add(jobData);
              jobCustomerCompletedIDs.add(jobData.jobUploadId);
            }
          }
        } else {
          throw Exception('No Jobs Available');
        }
      } catch (e) {
        // showDialog(
        //   context: context,
        //   builder: (context) {
        //     return AlertDialog(
        //       title: Center(
        //         child: Text(
        //           'Error'.toUpperCase(),
        //           style: TextStyle(color: primary, fontSize: 17),
        //         ),
        //       ),
        //       shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(12)),
        //       content: Text(
        //         '${e.toString()}.',
        //         style: TextStyle(
        //           height: 1.4,
        //           fontSize: 16,
        //           color: black,
        //         ),
        //       ),
        //     );
        //   },
        // );
        print(e.toString());
      }
    }
  }

  Future getCustomerJobApplicationData(
      String tabName, String role, BuildContext context) async {
    if (tabName == 'Job Offers') {
      moreOffers.clear();
      allJobOffers.clear();
      jobCustomerOffersIDs.clear();
    } else if (tabName == 'Jobs Upcoming') {
      allJobUpcoming.clear();
      jobCustomerUpcomingIDs.clear();
    } else if (tabName == 'Jobs Applied') {
      allJobApplied.clear();
      jobCustomerAppliedIDs.clear();
    } else {
      allJobCompleted.clear();
      jobCustomerCompletedIDs.clear();
    }

    final querySnapshot = await FirebaseFirestore.instance
        .collection('Job Application')
        .where('Customer ID', isEqualTo: loggedInUserId)
        .get()
        .timeout(
      Duration(seconds: 30), // Set your desired timeout duration
      onTimeout: () {
        throw TimeoutException("Unable to communicate with server.");
      },
    );

    if (querySnapshot.docs.isNotEmpty) {
      try {
        final docID = querySnapshot.docs.single.id;

        final document = await FirebaseFirestore.instance
            .collection('Job Application')
            .doc(docID)
            .get();
        final docData = document.data()!;
        List<dynamic> documentIDs = docData[tabName][role];

        if (documentIDs.isNotEmpty) {
          for (var id in documentIDs) {
            final jobDoc = await FirebaseFirestore.instance
                .collection('Customer Jobs Applied')
                .doc(id)
                .get();

            //
            final docData = jobDoc.data()!;
            final offerData = HandymanAppliedData(
              note: docData['Note'],
              acceptedDate: docData['Accepted Date'],
              inProgressDate: docData['In Progress Date'],
              completedDate: docData['Completed Date'],
              jobStatus: docData['Job Status'],
              receiverID: docData['Receiver ID'],
              referenceLinks: docData['Reference Links'],
              documentID: docData['Jobs Applied ID'],
              jobID: docData['Job ID'],
              applierID: docData['Applier ID'],
              name: docData['Name'],
              addressType: docData['Address Type'],
              street: docData['Street'],
              town: docData['Town'],
              notes: docData['Note'],
              houseNum: docData['House Number'],
              region: docData['Region'],
              time: docData['Schedule Time'],
              pic: docData['User Pic'],
              date: docData['Schedule Date'],
            );

            moreOffers.add(offerData);

            final jobID = jobDoc.get('Job ID');

            final document = await FirebaseFirestore.instance
                .collection('Handyman Job Upload')
                .doc(jobID)
                .get();

            final documentData = document.data()!;
            String expiry = documentData['Deadline'];
            String day = expiry[0].toString() + expiry[1].toString();
            String month = expiry[3].toString() + expiry[4].toString();
            String year = expiry[6].toString() +
                expiry[7].toString() +
                expiry[8].toString() +
                expiry[9].toString();
            final jobData = HandymanJobUploadItemData(
              uploadDate: tabName == 'Jobs Applied'
                  ? offerData.date
                  : documentData['Upload Date'],
              name: documentData['Name'],
              pic: documentData['User Pic'] == ''
                  ? ''
                  : documentData['User Pic'],
              uploadTime: documentData['Upload Time'],
              jobUploadId: documentData['Job ID'],
              serviceProvided: documentData['Service Information']
                  ['Service Provided'],
              seenBy: documentData['Seen By'],
              deadlineDay: day,
              deadlineMonth: month,
              deadlineYear: year,
              serviceCat: documentData['Service Information']
                  ['Service Category'],
              charge: documentData['Service Information']['Charge'].toString(),
              chargeRate: documentData['Service Information']['Charge Rate'],
              rating: documentData['Work Experience & Certification']['Rating'],
              houseNum: documentData['Address Information']['House Number'],
              region: documentData['Address Information']['Region'],
              town: documentData['Address Information']['Town'],
              street: documentData['Address Information']['Street'],
              expertise: documentData['Service Information']['Expertise'],
              portfolio: documentData['Work Experience & Certification']
                  ['Portfolio'],
              references: documentData['Work Experience & Certification']
                  ['References'],
              experience: documentData['Work Experience & Certification']
                  ['Experience'],
              certification: documentData['Work Experience & Certification']
                  ['Certification'],
            );

            if (tabName == 'Jobs Applied') {
              allJobApplied.add(jobData);
              jobHandymanAppliedIDs.add(jobData.jobUploadId);
            } else if (tabName == 'Jobs Upcoming') {
              allJobUpcoming.add(jobData);
              jobHandymanUpcomingIDs.add(jobData.jobUploadId);
            } else if (tabName == 'Job Offers') {
              allJobOffers.add(jobData);
              jobHandymanOffersIDs.add(jobData.jobUploadId);
            } else {
              allJobCompleted.add(jobData);
              jobHandymanCompletedIDs.add(jobData.jobUploadId);
            }
          }
        } else {
          throw Exception('No Jobs Available');
        }
      } catch (e) {
        // showDialog(
        //   context: context,
        //   builder: (context) {
        //     return AlertDialog(
        //       title: Center(
        //         child: Text(
        //           'Error'.toUpperCase(),
        //           style: TextStyle(color: primary, fontSize: 17),
        //         ),
        //       ),
        //       shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(12)),
        //       content: Text(
        //         '${e.toString()}.',
        //         style: TextStyle(
        //           height: 1.4,
        //           fontSize: 16,
        //           color: black,
        //         ),
        //       ),
        //     );
        //   },
        // );
        print(e.toString());
      }
    }
  }

  Future completeJob() async {
    jobCustomerUpcomingIDs.clear();
    jobHandymanUpcomingIDs.clear();
    jobCustomerCompletedIDs.clear();
    jobHandymanCompletedIDs.clear();

    //get jobsAppliedID, receiverID, applierID, jobID
    final jobsAppliedID = moreOffers[selectedJob].documentID;
    final applierID = moreOffers[selectedJob].applierID;
    final receiverID = moreOffers[selectedJob].receiverID;

    // change job status of Customer/Handyman Jobs Applied

    if (moreOffers[selectedJob].whoApplied == 'Customer') {
      await FirebaseFirestore.instance
          .collection('Customer Jobs Applied')
          .doc(jobsAppliedID)
          .update({
        'Job Status': 'Completed',
        'Completed Date': Timestamp.now(),
      });
    } else {
      await FirebaseFirestore.instance
          .collection('Handyman Jobs Applied')
          .doc(jobsAppliedID)
          .update({
        'Job Status': 'Completed',
        'Completed Date': Timestamp.now(),
      });
    }

    // remove jobsAppliedID from Job Application (id) -> Jobs Upcoming -> Customer
    // add jobsAppliedID from Job Application (id) -> Jobs Completed -> Customer

    if (moreOffers[selectedJob].whoApplied == 'Customer') {
      final customerUpcomingDocs = await FirebaseFirestore.instance
          .collection('Job Application')
          .where('Customer ID', isEqualTo: applierID)
          .get();
      if (customerUpcomingDocs.docs.isNotEmpty) {
        final docID = customerUpcomingDocs.docs.single.id;
        jobCustomerUpcomingIDs =
            customerUpcomingDocs.docs.single.get('Jobs Upcoming.Customer');
        jobHandymanUpcomingIDs =
            customerUpcomingDocs.docs.single.get('Jobs Upcoming.Handyman');
        jobCustomerCompletedIDs =
            customerUpcomingDocs.docs.single.get('Jobs Completed.Customer');
        jobHandymanCompletedIDs =
            customerUpcomingDocs.docs.single.get('Jobs Completed.Handyman');

        jobCustomerUpcomingIDs.remove(jobsAppliedID);
        jobCustomerCompletedIDs.add(jobsAppliedID);

        await FirebaseFirestore.instance
            .collection('Job Application')
            .doc(docID)
            .update({
          'Jobs Upcoming': {
            'Customer': jobCustomerUpcomingIDs,
            'Handyman': jobHandymanUpcomingIDs,
          },
          'Jobs Completed': {
            'Customer': jobCustomerCompletedIDs,
            'Handyman': jobHandymanCompletedIDs,
          },
        });
      }
    } else {
      final customerUpcomingDocs = await FirebaseFirestore.instance
          .collection('Job Application')
          .where('Customer ID', isEqualTo: applierID)
          .get();
      if (customerUpcomingDocs.docs.isNotEmpty) {
        final docID = customerUpcomingDocs.docs.single.id;
        jobCustomerUpcomingIDs =
            customerUpcomingDocs.docs.single.get('Jobs Upcoming.Customer');
        jobHandymanUpcomingIDs =
            customerUpcomingDocs.docs.single.get('Jobs Upcoming.Handyman');
        jobCustomerCompletedIDs =
            customerUpcomingDocs.docs.single.get('Jobs Completed.Customer');
        jobHandymanCompletedIDs =
            customerUpcomingDocs.docs.single.get('Jobs Completed.Handyman');

        jobHandymanUpcomingIDs.remove(jobsAppliedID);
        jobHandymanCompletedIDs.add(jobsAppliedID);

        await FirebaseFirestore.instance
            .collection('Job Application')
            .doc(docID)
            .update({
          'Jobs Upcoming': {
            'Customer': jobCustomerUpcomingIDs,
            'Handyman': jobHandymanUpcomingIDs,
          },
          'Jobs Completed': {
            'Customer': jobCustomerCompletedIDs,
            'Handyman': jobHandymanCompletedIDs,
          },
        });
      }
    }

    jobCustomerUpcomingIDs.clear();
    jobHandymanUpcomingIDs.clear();
    jobCustomerCompletedIDs.clear();
    jobHandymanCompletedIDs.clear();

    // remove jobsAppliedID from Job Application (id) -> Jobs Upcoming -> handyman
    // remove jobsAppliedID from Job Application (id) -> Jobs Completed -> handyman

    if (moreOffers[selectedJob].whoApplied == 'Customer') {
      final handymanUpcomingDocs = await FirebaseFirestore.instance
          .collection('Job Application')
          .where('Customer ID', isEqualTo: receiverID)
          .get();
      if (handymanUpcomingDocs.docs.isNotEmpty) {
        final docID = handymanUpcomingDocs.docs.single.id;
        jobCustomerUpcomingIDs =
            handymanUpcomingDocs.docs.single.get('Jobs Upcoming.Customer');
        jobHandymanUpcomingIDs =
            handymanUpcomingDocs.docs.single.get('Jobs Upcoming.Handyman');
        jobCustomerCompletedIDs =
            handymanUpcomingDocs.docs.single.get('Jobs Completed.Customer');
        jobHandymanCompletedIDs =
            handymanUpcomingDocs.docs.single.get('Jobs Completed.Handyman');

        jobHandymanUpcomingIDs.remove(jobsAppliedID);
        jobHandymanCompletedIDs.add(jobsAppliedID);

        await FirebaseFirestore.instance
            .collection('Job Application')
            .doc(docID)
            .update({
          'Jobs Upcoming': {
            'Customer': jobCustomerUpcomingIDs,
            'Handyman': jobHandymanUpcomingIDs,
          },
          'Jobs Completed': {
            'Customer': jobCustomerCompletedIDs,
            'Handyman': jobHandymanCompletedIDs,
          },
        });
      }
    } else {
      final handymanUpcomingDocs = await FirebaseFirestore.instance
          .collection('Job Application')
          .where('Customer ID', isEqualTo: receiverID)
          .get();
      if (handymanUpcomingDocs.docs.isNotEmpty) {
        final docID = handymanUpcomingDocs.docs.single.id;
        jobCustomerUpcomingIDs =
            handymanUpcomingDocs.docs.single.get('Jobs Upcoming.Customer');
        jobHandymanUpcomingIDs =
            handymanUpcomingDocs.docs.single.get('Jobs Upcoming.Handyman');
        jobCustomerCompletedIDs =
            handymanUpcomingDocs.docs.single.get('Jobs Completed.Customer');
        jobHandymanCompletedIDs =
            handymanUpcomingDocs.docs.single.get('Jobs Completed.Handyman');

        jobCustomerUpcomingIDs.remove(jobsAppliedID);
        jobCustomerCompletedIDs.add(jobsAppliedID);

        await FirebaseFirestore.instance
            .collection('Job Application')
            .doc(docID)
            .update({
          'Jobs Upcoming': {
            'Customer': jobCustomerUpcomingIDs,
            'Handyman': jobHandymanUpcomingIDs,
          },
          'Jobs Completed': {
            'Customer': jobCustomerCompletedIDs,
            'Handyman': jobHandymanCompletedIDs,
          },
        });
      }
    }

    // add 1 to Jobs Completed
    late final handymanID;
    if (moreOffers[selectedJob].whoApplied == 'Customer') {
      handymanID = receiverID;
    } else {
      handymanID = applierID;
    }

    final profileDoc = await FirebaseFirestore.instance
        .collection('profile')
        .where('User ID', isEqualTo: handymanID)
        .get();
    if (profileDoc.docs.isNotEmpty) {
      final docID = profileDoc.docs.single.id;

      final cert = profileDoc.docs.single
          .get('Work Experience & Certification.Certification');
      final experience = profileDoc.docs.single
          .get('Work Experience & Certification.Experience');
      final jobNumber = profileDoc.docs.single
          .get('Work Experience & Certification.Number of Jobs');
      final rating =
          profileDoc.docs.single.get('Work Experience & Certification.Rating');

      await FirebaseFirestore.instance.collection('profile').doc(docID).update(
        {
          'Work Experience & Certification': {
            'Certification': cert,
            'Experience': experience,
            'Number of Jobs': jobNumber + 1,
            'Rating': rating,
          }
        },
      );
    }
  }

  Future getUpcomingJobData(
      String tabName, String role, BuildContext context) async {
    moreOffers.clear();
    allJobUpcoming.clear();
    allJobCompleted.clear();
    jobCustomerUpcomingIDs.clear();
    jobCustomerCompletedIDs.clear();
    jobHandymanUpcomingIDs.clear();
    jobHandymanCompletedIDs.clear();
    List<String> allCustomerAppliedIDs = [];
    List<String> allHandymanAppliedIDs = [];
    allCustomerAppliedIDs.clear();
    allHandymanAppliedIDs.clear();

    final querySnapshot = await FirebaseFirestore.instance
        .collection('Job Application')
        .where('Customer ID', isEqualTo: loggedInUserId)
        .get()
        .timeout(
      Duration(seconds: 30), // Set your desired timeout duration
      onTimeout: () {
        throw TimeoutException("Unable to communicate with server.");
      },
    );

    if (querySnapshot.docs.isNotEmpty) {
      try {
        final docID = querySnapshot.docs.single.id;

        final document = await FirebaseFirestore.instance
            .collection('Job Application')
            .doc(docID)
            .get();
        final docData = document.data()!;
        List<dynamic> documentIDs = docData[tabName][role];

        if (documentIDs.isNotEmpty) {
          for (var id in documentIDs) {
            allCustomerAppliedIDs.clear();
            allHandymanAppliedIDs.clear();
            late final jobData;
            late final offerData;

            // customer job applied contains id?
            final allCustomerAppliedDocs = await FirebaseFirestore.instance
                .collection('Customer Jobs Applied')
                .get();
            final allHandymanAppliedDocs = await FirebaseFirestore.instance
                .collection('Handyman Jobs Applied')
                .get();

            for (var doc in allCustomerAppliedDocs.docs) {
              allCustomerAppliedIDs.add(doc.id);
            }
            for (var doc in allHandymanAppliedDocs.docs) {
              allHandymanAppliedIDs.add(doc.id);
            }

            if (allCustomerAppliedIDs.contains(id)) {
              final jobDoc = await FirebaseFirestore.instance
                  .collection('Customer Jobs Applied')
                  .doc(id)
                  .get();

              //
              final docData = jobDoc.data()!;
              offerData = HandymanAppliedData(
                acceptedDate: docData['Accepted Date'],
                inProgressDate: docData['In Progress Date'],
                completedDate: docData['Completed Date'],
                jobStatus: docData['Job Status'],
                whoApplied: 'Customer',
                receiverID: docData['Receiver ID'],
                referenceLinks: docData['Reference Links'],
                documentID: docData['Jobs Applied ID'],
                jobID: docData['Job ID'],
                applierID: docData['Applier ID'],
                name: docData['Name'],
                note: docData['Note'],
                addressType: docData['Address Type'],
                street: docData['Street'],
                town: docData['Town'],
                notes: docData['Note'],
                houseNum: docData['House Number'],
                region: docData['Region'],
                time: docData['Schedule Time'],
                pic: docData['User Pic'],
                date: docData['Schedule Date'],
              );

              final jobID = jobDoc.get('Job ID');

              final document = await FirebaseFirestore.instance
                  .collection('Handyman Job Upload')
                  .doc(jobID)
                  .get();

              final documentData = document.data()!;
              String expiry = documentData['Deadline'];
              String day = expiry[0].toString() + expiry[1].toString();
              String month = expiry[3].toString() + expiry[4].toString();
              String year = expiry[6].toString() +
                  expiry[7].toString() +
                  expiry[8].toString() +
                  expiry[9].toString();
              jobData = HandymanJobUploadItemData(
                uploadDate: documentData['Upload Date'],
                name: documentData['Name'],
                pic: documentData['User Pic'] == ''
                    ? ''
                    : documentData['User Pic'],
                uploadTime: documentData['Upload Time'],
                jobUploadId: documentData['Job ID'],
                serviceProvided: documentData['Service Information']
                    ['Service Provided'],
                seenBy: documentData['Seen By'],
                deadlineDay: day,
                deadlineMonth: month,
                deadlineYear: year,
                serviceCat: documentData['Service Information']
                    ['Service Category'],
                charge:
                    documentData['Service Information']['Charge'].toString(),
                chargeRate: documentData['Service Information']['Charge Rate'],
                rating: documentData['Work Experience & Certification']
                    ['Rating'],
                houseNum: documentData['Address Information']['House Number'],
                region: documentData['Address Information']['Region'],
                town: documentData['Address Information']['Town'],
                street: documentData['Address Information']['Street'],
                expertise: documentData['Service Information']['Expertise'],
                portfolio: documentData['Work Experience & Certification']
                    ['Portfolio'],
                references: documentData['Work Experience & Certification']
                    ['References'],
                experience: documentData['Work Experience & Certification']
                    ['Experience'],
                certification: documentData['Work Experience & Certification']
                    ['Certification'],
              );
            } else {
              final jobDoc = await FirebaseFirestore.instance
                  .collection('Handyman Jobs Applied')
                  .doc(id)
                  .get();

              //to get more info about handyman jobs applied
              final docData = jobDoc.data()!;
              offerData = CustomerAppliedData(
                acceptedDate: docData['Accepted Date'],
                inProgressDate: docData['In Progress Date'],
                completedDate: docData['Completed Date'],
                jobStatus: docData['Job Status'],
                receiverID: docData['Receiver ID'],
                documentID: docData['Jobs Applied ID'],
                jobID: docData['Job ID'],
                applierID: docData['Applier ID'],
                name: docData['Name'],
                note: docData['Note'],
                addressType: docData['Address Type'],
                street: docData['Street'],
                town: docData['Town'],
                notes: docData['Note'],
                houseNum: docData['House Number'],
                region: docData['Region'],
                time: docData['Schedule Time'],
                pic: docData['User Pic'],
                date: docData['Schedule Date'],
                whoApplied: 'Handyman',
              );

              final jobID = jobDoc.get('Job ID');

              final document = await FirebaseFirestore.instance
                  .collection('Customer Job Upload')
                  .doc(jobID)
                  .get();

              final documentData = document.data()!;
              final expiry = documentData['Job Details']['Deadline'];
              String day = expiry[0].toString() + expiry[1].toString();
              String month = expiry[3].toString() + expiry[4].toString();
              String year = expiry[6].toString() +
                  expiry[7].toString() +
                  expiry[8].toString() +
                  expiry[9].toString();
              jobData = CustomerJobUploadItemData(
                  uploadDate: documentData['Upload Date'],
                  name: documentData['Name'],
                  pic: documentData['User Pic'] == ''
                      ? ''
                      : documentData['User Pic'],
                  uploadTime: documentData['Upload Time'],
                  jobUploadId: documentData['Job ID'],
                  serviceProvided: documentData['Service Information']
                      ['Service Provided'],
                  seenBy: documentData['Seen By'],
                  deadlineDay: day,
                  deadlineMonth: month,
                  deadlineYear: year,
                  serviceCat: documentData['Service Information']
                      ['Service Category'],
                  charge:
                      documentData['Service Information']['Charge'].toString(),
                  chargeRate: documentData['Service Information']
                      ['Charge Rate'],
                  rating: documentData['Work Detail & Rating']['Rating'],
                  houseNum: documentData['Address Information']['House Number'],
                  region: documentData['Address Information']['Region'],
                  town: documentData['Address Information']['Town'],
                  street: documentData['Address Information']['Street'],
                  portfolioOption: documentData['Optional']
                      ['Portfolio Present'],
                  referenceOption: documentData['Optional']
                      ['References Present'],
                  expertise: documentData['Service Information']['Expertise'],
                  portfolio: documentData['Work Detail & Rating']['Portfolio']);
            }
            moreOffers.add(offerData);
            if (tabName == 'Jobs Upcoming') {
              allJobUpcoming.add(jobData);
              jobHandymanUpcomingIDs.add(jobData.jobUploadId);
            }
            if (tabName == 'Jobs Completed') {
              allJobCompleted.add(jobData);
            }
          }
        } else {
          throw Exception('Job Upload Not Found');
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future deleteJobApplication(String type) async {
    final jobsAppliedID = moreOffers[selectedJob].documentID;
    final receiverID = moreOffers[selectedJob].receiverID;
    final jobUploadID = moreOffers[selectedJob].jobID;
    print(receiverID);
    print(jobUploadID);

    // get jobs applied id
    if (type == 'Handyman Uploaded') {
      // delete document at Customer Jobs Applied
      await FirebaseFirestore.instance
          .collection('Customer Jobs Applied')
          .doc(jobsAppliedID)
          .delete();

      // delete applier id at Job application -> Jobs Applied -> Customer

      final querySnapshot = await FirebaseFirestore.instance
          .collection('Job Application')
          .where('Customer ID', isEqualTo: loggedInUserId)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final docID = querySnapshot.docs.single.id;
        jobCustomerAppliedIDs =
            querySnapshot.docs.single.get('Jobs Applied.Customer');
        jobHandymanAppliedIDs =
            querySnapshot.docs.single.get('Jobs Applied.Handyman');

        jobCustomerAppliedIDs.remove(jobsAppliedID);

        await FirebaseFirestore.instance
            .collection('Job Application')
            .doc(docID)
            .update({
          'Jobs Applied': {
            'Customer': jobCustomerAppliedIDs,
            'Handyman': jobHandymanAppliedIDs,
          }
        });
      }

      // delete applier id at Job application -> Jobs Offers -> Handyman

      final offersDocs = await FirebaseFirestore.instance
          .collection('Job Application')
          .where('Customer ID', isEqualTo: receiverID)
          .get()
          .timeout(
        Duration(seconds: 30), // Set your desired timeout duration
        onTimeout: () {
          throw TimeoutException("Unable to communicate with server.");
        },
      );
      if (offersDocs.docs.isNotEmpty) {
        final docID = offersDocs.docs.single.id;
        jobCustomerOffersIDs =
            offersDocs.docs.single.get('Job Offers.Customer');
        jobHandymanOffersIDs =
            offersDocs.docs.single.get('Job Offers.Handyman');

        print(jobCustomerOffersIDs);
        print(jobHandymanOffersIDs);

        jobHandymanOffersIDs.remove(jobsAppliedID);
        print(jobHandymanOffersIDs);

        await FirebaseFirestore.instance
            .collection('Job Application')
            .doc(docID)
            .update({
          'Job Offers': {
            'Customer': jobCustomerOffersIDs,
            'Handyman': jobHandymanOffersIDs,
          }
        });
      }
    }
    // delete applier id at job upload -> Job Details -> applier ids

    final jobUploadDoc = await FirebaseFirestore.instance
        .collection('Handyman Job Upload')
        .where('Job ID', isEqualTo: jobUploadID)
        .get();
    if (jobUploadDoc.docs.isNotEmpty) {
      final docID = jobUploadDoc.docs.single.id;
      List applierIDs = jobUploadDoc.docs.single.get('Job Details.Applier IDs');

      print(applierIDs);
      applierIDs.remove(jobsAppliedID);

      await FirebaseFirestore.instance
          .collection('Handyman Job Upload')
          .doc(docID)
          .update({
        'Job Details': {
          'Applier IDs': applierIDs,
          'People Applied': applierIDs.length,
        }
      });
    }
    //------------------------------------------------------------------------
    else {
      // delete document at Customer Jobs Applied
      await FirebaseFirestore.instance
          .collection('Handyman Jobs Applied')
          .doc(jobsAppliedID)
          .delete();

      // delete applier id at Job application -> Jobs Applied -> Handyman

      final querySnapshot = await FirebaseFirestore.instance
          .collection('Job Application')
          .where('Customer ID', isEqualTo: loggedInUserId)
          .get()
          .timeout(
        Duration(seconds: 30), // Set your desired timeout duration
        onTimeout: () {
          throw TimeoutException("Unable to communicate with server.");
        },
      );
      if (querySnapshot.docs.isNotEmpty) {
        final docID = querySnapshot.docs.single.id;
        jobCustomerAppliedIDs =
            querySnapshot.docs.single.get('Jobs Applied.Customer');
        jobHandymanAppliedIDs =
            querySnapshot.docs.single.get('Jobs Applied.Handyman');

        jobHandymanAppliedIDs.remove(jobsAppliedID);

        await FirebaseFirestore.instance
            .collection('Job Application')
            .doc(docID)
            .update({
          'Jobs Applied': {
            'Customer': jobCustomerAppliedIDs,
            'Handyman': jobHandymanAppliedIDs,
          }
        });
      }

      // delete applier id at Job application -> Jobs Offers -> Customer

      final offersDocs = await FirebaseFirestore.instance
          .collection('Job Application')
          .where('Customer ID', isEqualTo: receiverID)
          .get();
      if (offersDocs.docs.isNotEmpty) {
        final docID = offersDocs.docs.single.id;
        jobCustomerOffersIDs =
            offersDocs.docs.single.get('Job Offers.Customer');
        jobHandymanOffersIDs =
            offersDocs.docs.single.get('Job Offers.Handyman');

        jobCustomerOffersIDs.remove(jobsAppliedID);

        await FirebaseFirestore.instance
            .collection('Job Application')
            .doc(docID)
            .update({
          'Job Offers': {
            'Customer': jobCustomerOffersIDs,
            'Handyman': jobHandymanOffersIDs,
          }
        });
      }

      // delete applier id at job upload -> Job Details -> applier ids

      final jobUploadDoc = await FirebaseFirestore.instance
          .collection('Customer Job Upload')
          .where('Job ID', isEqualTo: jobUploadID)
          .get();
      if (jobUploadDoc.docs.isNotEmpty) {
        final docID = jobUploadDoc.docs.single.id;
        List applierIDs =
            jobUploadDoc.docs.single.get('Job Details.Applier IDs');
        final jobStatusApplication =
            jobUploadDoc.docs.single.get('Job Details.Job Status');
        final deadlineApplication =
            jobUploadDoc.docs.single.get('Job Details.Deadline');

        applierIDs.remove(jobsAppliedID);

        await FirebaseFirestore.instance
            .collection('Customer Job Upload')
            .doc(docID)
            .update({
          'Job Details': {
            'Applier IDs': applierIDs,
            'People Applied': applierIDs.length,
            'Job Status': jobStatusApplication,
            'Deadline': deadlineApplication
          }
        });
      }
    }
  }

  Future deleteJobUpcoming(String type) async {
    final jobsAppliedID = moreOffers[selectedJob].documentID;
    final receiverID = moreOffers[selectedJob].receiverID;
    final jobUploadID = moreOffers[selectedJob].jobID;
    final applierID = moreOffers[selectedJob].applierID;
    print(receiverID);
    print(jobUploadID);

    // get jobs applied id
    if (type == 'Handyman Uploaded') {
      // delete document at Customer Jobs Applied
      await FirebaseFirestore.instance
          .collection('Customer Jobs Applied')
          .doc(jobsAppliedID)
          .delete();

      // delete applier id at Job application -> Jobs Applied -> Customer

      final querySnapshot = await FirebaseFirestore.instance
          .collection('Job Application')
          .where('Customer ID', isEqualTo: applierID)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final docID = querySnapshot.docs.single.id;
        jobCustomerUpcomingIDs =
            querySnapshot.docs.single.get('Jobs Upcoming.Customer');
        jobHandymanUpcomingIDs =
            querySnapshot.docs.single.get('Jobs Upcoming.Handyman');

        jobCustomerUpcomingIDs.remove(jobsAppliedID);

        await FirebaseFirestore.instance
            .collection('Job Application')
            .doc(docID)
            .update({
          'Jobs Upcoming': {
            'Customer': jobCustomerAppliedIDs,
            'Handyman': jobHandymanAppliedIDs,
          }
        });
      }

      jobCustomerUpcomingIDs.clear();
      jobHandymanUpcomingIDs.clear();

      // delete applier id at Job application -> Jobs Offers -> Handyman

      final offersDocs = await FirebaseFirestore.instance
          .collection('Job Application')
          .where('Customer ID', isEqualTo: receiverID)
          .get()
          .timeout(
        Duration(seconds: 30), // Set your desired timeout duration
        onTimeout: () {
          throw TimeoutException("Unable to communicate with server.");
        },
      );
      if (offersDocs.docs.isNotEmpty) {
        final docID = offersDocs.docs.single.id;
        jobCustomerUpcomingIDs =
            offersDocs.docs.single.get('Jobs Upcoming.Customer');
        jobHandymanUpcomingIDs =
            offersDocs.docs.single.get('Jobs Upcoming.Handyman');

        print(jobCustomerOffersIDs);
        print(jobHandymanOffersIDs);

        jobHandymanUpcomingIDs.remove(jobsAppliedID);
        print(jobHandymanOffersIDs);

        await FirebaseFirestore.instance
            .collection('Job Application')
            .doc(docID)
            .update({
          'Jobs Upcoming': {
            'Customer': jobCustomerUpcomingIDs,
            'Handyman': jobHandymanUpcomingIDs,
          }
        });
      }
    }
    // delete applier id at job upload -> Job Details -> applier ids

    final jobUploadDoc = await FirebaseFirestore.instance
        .collection('Handyman Job Upload')
        .where('Job ID', isEqualTo: jobUploadID)
        .get();
    if (jobUploadDoc.docs.isNotEmpty) {
      final docID = jobUploadDoc.docs.single.id;
      List applierIDs = jobUploadDoc.docs.single.get('Job Details.Applier IDs');

      print(applierIDs);
      applierIDs.remove(jobsAppliedID);

      await FirebaseFirestore.instance
          .collection('Handyman Job Upload')
          .doc(docID)
          .update({
        'Job Details': {
          'Applier IDs': applierIDs,
          'People Applied': applierIDs.length,
        }
      });
    }
    //------------------------------------------------------------------------
    else {
      // delete document at Customer Jobs Applied
      await FirebaseFirestore.instance
          .collection('Handyman Jobs Applied')
          .doc(jobsAppliedID)
          .delete();

      // delete applier id at Job application -> Jobs Applied -> Handyman

      final querySnapshot = await FirebaseFirestore.instance
          .collection('Job Application')
          .where('Customer ID', isEqualTo: applierID)
          .get()
          .timeout(
        Duration(seconds: 30), // Set your desired timeout duration
        onTimeout: () {
          throw TimeoutException("Unable to communicate with server.");
        },
      );
      if (querySnapshot.docs.isNotEmpty) {
        final docID = querySnapshot.docs.single.id;
        jobCustomerUpcomingIDs =
            querySnapshot.docs.single.get('Jobs Upcoming.Customer');
        jobHandymanUpcomingIDs =
            querySnapshot.docs.single.get('Jobs Upcoming.Handyman');

        jobHandymanUpcomingIDs.remove(jobsAppliedID);

        await FirebaseFirestore.instance
            .collection('Job Application')
            .doc(docID)
            .update({
          'Jobs Upcoming': {
            'Customer': jobCustomerUpcomingIDs,
            'Handyman': jobHandymanUpcomingIDs,
          }
        });
      }

      jobCustomerUpcomingIDs.clear();
      jobHandymanUpcomingIDs.clear();

      // delete applier id at Job application -> Jobs Offers -> Customer

      final offersDocs = await FirebaseFirestore.instance
          .collection('Job Application')
          .where('Customer ID', isEqualTo: receiverID)
          .get();
      if (offersDocs.docs.isNotEmpty) {
        final docID = offersDocs.docs.single.id;
        jobCustomerUpcomingIDs =
            offersDocs.docs.single.get('Jobs Upcoming.Customer');
        jobHandymanUpcomingIDs =
            offersDocs.docs.single.get('Jobs Upcoming.Handyman');

        jobCustomerUpcomingIDs.remove(jobsAppliedID);

        await FirebaseFirestore.instance
            .collection('Job Application')
            .doc(docID)
            .update({
          'Jobs Upcoming': {
            'Customer': jobCustomerUpcomingIDs,
            'Handyman': jobHandymanUpcomingIDs,
          }
        });
      }

      // delete applier id at job upload -> Job Details -> applier ids

      final jobUploadDoc = await FirebaseFirestore.instance
          .collection('Customer Job Upload')
          .where('Job ID', isEqualTo: jobUploadID)
          .get();
      if (jobUploadDoc.docs.isNotEmpty) {
        final docID = jobUploadDoc.docs.single.id;
        List applierIDs =
            jobUploadDoc.docs.single.get('Job Details.Applier IDs');
        final jobStatusApplication =
            jobUploadDoc.docs.single.get('Job Details.Job Status');
        final deadlineApplication =
            jobUploadDoc.docs.single.get('Job Details.Deadline');

        applierIDs.remove(jobsAppliedID);

        await FirebaseFirestore.instance
            .collection('Customer Job Upload')
            .doc(docID)
            .update({
          'Job Details': {
            'Applier IDs': applierIDs,
            'People Applied': applierIDs.length,
            'Job Status': jobStatusApplication,
            'Deadline': deadlineApplication
          }
        });
      }
    }
  }

  Future cancelJobApplication(String type) async {
    jobHandymanAppliedIDs.clear();
    jobHandymanOffersIDs.clear();
    jobCustomerAppliedIDs.clear();
    jobCustomerOffersIDs.clear();

    // get jobsAppliedID, receiverID, applierID, jobID
    final jobsAppliedID = moreOffers[selectedJob].documentID;
    final applierID = moreOffers[selectedJob].applierID;
    final receiverID = moreOffers[selectedJob].receiverID;
    final jobUploadID = moreOffers[selectedJob].jobID;

    //delete Customer Jobs Applied with jobs applied ID
    if (type == 'Handyman Uploaded') {
      await FirebaseFirestore.instance
          .collection('Customer Jobs Applied')
          .doc(jobsAppliedID)
          .delete();
      // delete jobsAppliedID from applierID's Job Application -> Jobs Applied -> customer
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Job Application')
          .where('Customer ID', isEqualTo: applierID)
          .get()
          .timeout(
        Duration(seconds: 30), // Set your desired timeout duration
        onTimeout: () {
          throw TimeoutException("Unable to communicate with server.");
        },
      );
      if (querySnapshot.docs.isNotEmpty) {
        final docID = querySnapshot.docs.single.id;
        jobCustomerAppliedIDs =
            querySnapshot.docs.single.get('Jobs Applied.Customer');
        jobHandymanAppliedIDs =
            querySnapshot.docs.single.get('Jobs Applied.Handyman');

        jobCustomerAppliedIDs.remove(jobsAppliedID);

        await FirebaseFirestore.instance
            .collection('Job Application')
            .doc(docID)
            .update({
          'Jobs Applied': {
            'Customer': jobCustomerAppliedIDs,
            'Handyman': jobHandymanAppliedIDs,
          }
        });
      }
      // delete jobsAppliedID from receiverID's Job Application -> Job Offers -> Handyman
      final offersDocs = await FirebaseFirestore.instance
          .collection('Job Application')
          .where('Customer ID', isEqualTo: receiverID)
          .get();
      if (offersDocs.docs.isNotEmpty) {
        final docID = offersDocs.docs.single.id;
        jobCustomerOffersIDs =
            offersDocs.docs.single.get('Job Offers.Customer');
        jobHandymanOffersIDs =
            offersDocs.docs.single.get('Job Offers.Handyman');

        print(jobCustomerOffersIDs);
        print(jobHandymanOffersIDs);

        jobHandymanOffersIDs.remove(jobsAppliedID);
        print(jobHandymanOffersIDs);

        await FirebaseFirestore.instance
            .collection('Job Application')
            .doc(docID)
            .update({
          'Job Offers': {
            'Customer': jobCustomerOffersIDs,
            'Handyman': jobHandymanOffersIDs,
          }
        });
      }
      // delete jobsApplied from jobUpload( jobID ) -> Applier IDs

      final jobUploadDoc = await FirebaseFirestore.instance
          .collection('Handyman Job Upload')
          .where('Job ID', isEqualTo: jobUploadID)
          .get();
      if (jobUploadDoc.docs.isNotEmpty) {
        final docID = jobUploadDoc.docs.single.id;
        List applierIDs =
            jobUploadDoc.docs.single.get('Job Details.Applier IDs');

        print(applierIDs);
        applierIDs.remove(jobsAppliedID);

        await FirebaseFirestore.instance
            .collection('Handyman Job Upload')
            .doc(docID)
            .update({
          'Job Details': {
            'Applier IDs': applierIDs,
            'People Applied': applierIDs.length,
          }
        });
      }
    } else {
      // delete document at Customer Jobs Applied
      await FirebaseFirestore.instance
          .collection('Handyman Jobs Applied')
          .doc(jobsAppliedID)
          .delete();

      // delete applier id at Job application -> Jobs Applied -> Handyman

      final querySnapshot = await FirebaseFirestore.instance
          .collection('Job Application')
          .where('Customer ID', isEqualTo: loggedInUserId)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final docID = querySnapshot.docs.single.id;
        jobCustomerAppliedIDs =
            querySnapshot.docs.single.get('Jobs Applied.Customer');
        jobHandymanAppliedIDs =
            querySnapshot.docs.single.get('Jobs Applied.Handyman');

        jobHandymanAppliedIDs.remove(jobsAppliedID);

        await FirebaseFirestore.instance
            .collection('Job Application')
            .doc(docID)
            .update({
          'Jobs Applied': {
            'Customer': jobCustomerAppliedIDs,
            'Handyman': jobHandymanAppliedIDs,
          }
        });
      }

      // delete applier id at Job application -> Jobs Offers -> Customer

      final offersDocs = await FirebaseFirestore.instance
          .collection('Job Application')
          .where('Customer ID', isEqualTo: receiverID)
          .get();
      if (offersDocs.docs.isNotEmpty) {
        final docID = offersDocs.docs.single.id;
        jobCustomerOffersIDs =
            offersDocs.docs.single.get('Job Offers.Customer');
        jobHandymanOffersIDs =
            offersDocs.docs.single.get('Job Offers.Handyman');

        jobCustomerOffersIDs.remove(jobsAppliedID);

        await FirebaseFirestore.instance
            .collection('Job Application')
            .doc(docID)
            .update({
          'Job Offers': {
            'Customer': jobCustomerOffersIDs,
            'Handyman': jobHandymanOffersIDs,
          }
        });
      }

      // delete applier id at job upload -> Job Details -> applier ids

      final jobUploadDoc = await FirebaseFirestore.instance
          .collection('Customer Job Upload')
          .where('Job ID', isEqualTo: jobUploadID)
          .get();
      if (jobUploadDoc.docs.isNotEmpty) {
        final docID = jobUploadDoc.docs.single.id;
        List applierIDs =
            jobUploadDoc.docs.single.get('Job Details.Applier IDs');
        final jobStatusApplication =
            jobUploadDoc.docs.single.get('Job Details.Job Status');
        final deadlineApplication =
            jobUploadDoc.docs.single.get('Job Details.Deadline');

        applierIDs.remove(jobsAppliedID);

        await FirebaseFirestore.instance
            .collection('Customer Job Upload')
            .doc(docID)
            .update({
          'Job Details': {
            'Applier IDs': applierIDs,
            'People Applied': applierIDs.length,
            'Job Status': jobStatusApplication,
            'Deadline': deadlineApplication
          }
        });
      }
    }
  }

  Future acceptOffer(String type) async {
    jobCustomerAppliedIDs.clear();
    jobHandymanAppliedIDs.clear();
    jobCustomerUpcomingIDs.clear();
    jobHandymanUpcomingIDs.clear();
    jobCustomerOffersIDs.clear();
    jobHandymanOffersIDs.clear();

    //get jobsAppliedID, applierID, receiverID
    final jobsAppliedID = moreOffers[selectedJob].documentID;
    final applierID = moreOffers[selectedJob].applierID;
    final receiverID = moreOffers[selectedJob].receiverID;

    try {
      if (type == 'Handyman Uploaded') {
        // change job status in Customer Jobs Applied to Accepted

        await FirebaseFirestore.instance
            .collection('Customer Jobs Applied')
            .doc(jobsAppliedID)
            .update({
          'Job Status': 'Accepted',
          'Accepted Date': Timestamp.now(),
        });

        // remove jobsAppliedID from Jobs Application (applierID) -> Applied -> Customer
        // add jobsAppliedID from Jobs Application (applierID) -> Upcoming -> Customer

        final appliedDocs = await FirebaseFirestore.instance
            .collection('Job Application')
            .where('Customer ID', isEqualTo: applierID)
            .get()
            .timeout(
          Duration(seconds: 30), // Set your desired timeout duration
          onTimeout: () {
            throw TimeoutException("Unable to communicate with server.");
          },
        );
        if (appliedDocs.docs.isNotEmpty) {
          final docID = appliedDocs.docs.single.id;
          jobCustomerAppliedIDs =
              appliedDocs.docs.single.get('Jobs Applied.Customer');
          jobHandymanAppliedIDs =
              appliedDocs.docs.single.get('Jobs Applied.Handyman');
          jobCustomerUpcomingIDs =
              appliedDocs.docs.single.get('Jobs Upcoming.Customer');
          jobHandymanUpcomingIDs =
              appliedDocs.docs.single.get('Jobs Upcoming.Handyman');

          jobCustomerAppliedIDs.remove(jobsAppliedID);
          jobCustomerUpcomingIDs.add(jobsAppliedID);

          await FirebaseFirestore.instance
              .collection('Job Application')
              .doc(docID)
              .update({
            'Jobs Applied': {
              'Customer': jobCustomerAppliedIDs,
              'Handyman': jobHandymanAppliedIDs,
            },
            'Jobs Upcoming': {
              'Customer': jobCustomerUpcomingIDs,
              'Handyman': jobHandymanUpcomingIDs,
            },
          });
        }

        // clear all variables used for reuse
        jobCustomerAppliedIDs.clear();
        jobHandymanAppliedIDs.clear();
        jobCustomerUpcomingIDs.clear();
        jobHandymanUpcomingIDs.clear();

        // remove jobsAppliedID from Jobs Application (receiverID) -> Offer -> Handyman
        // add jobsAppliedID from Jobs Application (receiverID) -> Upcoming -> Handyman}

        final offerDocs = await FirebaseFirestore.instance
            .collection('Job Application')
            .where('Customer ID', isEqualTo: receiverID)
            .get();
        if (offerDocs.docs.isNotEmpty) {
          final docID = offerDocs.docs.single.id;
          jobCustomerOffersIDs =
              offerDocs.docs.single.get('Job Offers.Customer');
          jobHandymanOffersIDs =
              offerDocs.docs.single.get('Job Offers.Handyman');
          jobCustomerUpcomingIDs =
              offerDocs.docs.single.get('Jobs Upcoming.Customer');
          jobHandymanUpcomingIDs =
              offerDocs.docs.single.get('Jobs Upcoming.Handyman');

          jobHandymanOffersIDs.remove(jobsAppliedID);
          jobHandymanUpcomingIDs.add(jobsAppliedID);

          await FirebaseFirestore.instance
              .collection('Job Application')
              .doc(docID)
              .update({
            'Job Offers': {
              'Customer': jobCustomerOffersIDs,
              'Handyman': jobHandymanOffersIDs,
            },
            'Jobs Upcoming': {
              'Customer': jobCustomerUpcomingIDs,
              'Handyman': jobHandymanUpcomingIDs,
            },
          });
        }
      } else {
        // change job status in Customer Jobs Applied to Accepted

        await FirebaseFirestore.instance
            .collection('Handyman Jobs Applied')
            .doc(jobsAppliedID)
            .update({
          'Job Status': 'Accepted',
          'Accepted Date': Timestamp.now(),
        });

        // remove jobsAppliedID from Jobs Application (applierID) -> Applied -> Customer
        // add jobsAppliedID from Jobs Application (applierID) -> Upcoming -> Customer

        final appliedDocs = await FirebaseFirestore.instance
            .collection('Job Application')
            .where('Customer ID', isEqualTo: applierID)
            .get();
        if (appliedDocs.docs.isNotEmpty) {
          final docID = appliedDocs.docs.single.id;
          jobCustomerAppliedIDs =
              appliedDocs.docs.single.get('Jobs Applied.Customer');
          jobHandymanAppliedIDs =
              appliedDocs.docs.single.get('Jobs Applied.Handyman');
          jobCustomerUpcomingIDs =
              appliedDocs.docs.single.get('Jobs Upcoming.Customer');
          jobHandymanUpcomingIDs =
              appliedDocs.docs.single.get('Jobs Upcoming.Handyman');

          jobHandymanAppliedIDs.remove(jobsAppliedID);
          jobHandymanUpcomingIDs.add(jobsAppliedID);

          await FirebaseFirestore.instance
              .collection('Job Application')
              .doc(docID)
              .update({
            'Jobs Applied': {
              'Customer': jobCustomerAppliedIDs,
              'Handyman': jobHandymanAppliedIDs,
            },
            'Jobs Upcoming': {
              'Customer': jobCustomerUpcomingIDs,
              'Handyman': jobHandymanUpcomingIDs,
            },
          });
        }

        // clear all variables used for reuse
        jobCustomerAppliedIDs.clear();
        jobHandymanAppliedIDs.clear();
        jobCustomerUpcomingIDs.clear();
        jobHandymanUpcomingIDs.clear();

        // remove jobsAppliedID from Jobs Application (receiverID) -> Offer -> Handyman
        // add jobsAppliedID from Jobs Application (receiverID) -> Upcoming -> Handyman}

        final offerDocs = await FirebaseFirestore.instance
            .collection('Job Application')
            .where('Customer ID', isEqualTo: receiverID)
            .get();
        if (offerDocs.docs.isNotEmpty) {
          final docID = offerDocs.docs.single.id;
          jobCustomerOffersIDs =
              offerDocs.docs.single.get('Job Offers.Customer');
          jobHandymanOffersIDs =
              offerDocs.docs.single.get('Job Offers.Handyman');
          jobCustomerUpcomingIDs =
              offerDocs.docs.single.get('Jobs Upcoming.Customer');
          jobHandymanUpcomingIDs =
              offerDocs.docs.single.get('Jobs Upcoming.Handyman');

          jobCustomerOffersIDs.remove(jobsAppliedID);
          jobCustomerUpcomingIDs.add(jobsAppliedID);

          await FirebaseFirestore.instance
              .collection('Job Application')
              .doc(docID)
              .update({
            'Job Offers': {
              'Customer': jobCustomerOffersIDs,
              'Handyman': jobHandymanOffersIDs,
            },
            'Jobs Upcoming': {
              'Customer': jobCustomerUpcomingIDs,
              'Handyman': jobHandymanUpcomingIDs,
            },
          });
        }
      }
    } on FirebaseException catch (error) {
      print(error.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  Future getUserJobApplicationIDS() async {
    jobHandymanUpcomingIDs.clear();
    jobHandymanAppliedIDs.clear();
    jobHandymanCompletedIDs.clear();
    jobHandymanOffersIDs.clear();
    jobCustomerUpcomingIDs.clear();
    jobCustomerAppliedIDs.clear();
    jobCustomerCompletedIDs.clear();
    jobCustomerOffersIDs.clear();

    final querySnapshot = await FirebaseFirestore.instance
        .collection('Job Application')
        .where('Customer ID', isEqualTo: loggedInUserId)
        .get()
        .timeout(
      Duration(seconds: 30), // Set your desired timeout duration
      onTimeout: () {
        throw TimeoutException("Unable to communicate with server.");
      },
    );

    if (querySnapshot.docs.isNotEmpty) {
      try {
        final docID = querySnapshot.docs.single.id;

        final document = await FirebaseFirestore.instance
            .collection('Job Application')
            .doc(docID)
            .get();

        final docData = document.data()!;
        jobHandymanUpcomingIDs = docData['Jobs Upcoming']['Handyman'];
        jobHandymanUpcomingIDs = docData['Jobs Upcoming']['Customer'];
        jobHandymanAppliedIDs = docData['Jobs Applied']['Handyman'];
        jobCustomerAppliedIDs = docData['Jobs Applied']['Customer'];
        jobHandymanCompletedIDs = docData['Jobs Completed']['Handyman'];
        jobCustomerCompletedIDs = docData['Jobs Completed']['Customer'];
        jobHandymanOffersIDs = docData['Job Offers']['Handyman'];
        jobCustomerOffersIDs = docData['Job Offers']['Customer'];
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future rescheduleJob(String type) async {
    try {
      if (type == 'Handyman Uploaded') {
        await FirebaseFirestore.instance
            .collection('Customer Jobs Applied')
            .doc(moreOffers[selectedJob].documentID)
            .update({
          'Schedule Date': rescheduleDate,
          'Schedule Time': rescheduleTime,
          'Job Status': 'Rescheduled',
        });
      } else {
        await FirebaseFirestore.instance
            .collection('Handyman Jobs Applied')
            .doc(moreOffers[selectedJob].documentID)
            .update({
          'Schedule Date': rescheduleDate,
          'Schedule Time': rescheduleTime,
          'Job Status': 'Rescheduled',
        });
      }
    } on FirebaseException catch (error) {
      print(error.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteFiles(String path) async {
    final directoryRef = FirebaseStorage.instance.ref().child(path);

    try {
      final querySnapshot = await directoryRef.listAll();
      querySnapshot.items.forEach((file) async {
        await file.delete();
      });

      querySnapshot.prefixes.forEach((folder) async {
        await deleteFilesInFolders(folder);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteFilesInFolders(Reference directoryRef) async {
    try {
      final querySnapshot = await directoryRef.listAll();
      querySnapshot.items.forEach((file) async {
        await file.delete();
      });

      querySnapshot.prefixes.forEach((folder) async {
        await deleteFilesInFolders(folder);
      });
    } catch (e) {
      print(e.toString());
    }
  }
}

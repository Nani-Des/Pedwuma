// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handyman_app/Components/profile_service_information.dart';
import 'package:handyman_app/Screens/Home/home_screen.dart';
import 'package:handyman_app/constants.dart';

import '../../../../../Components/job_upload_location_info.dart';
import '../../../../../Components/job_upload_service_info.dart';
import '../../../../../Components/job_upload_work_cert_info.dart';
import '../../../../../Components/profile_item.dart';
import '../../../../../Components/profile_item_dropdown.dart';
import '../../../../../Components/profile_location_information.dart';
import '../../../../../Components/profile_payment_information.dart';
import '../../../../../Components/profile_work_cert_information.dart';
import '../../../../../Services/storage_service.dart';
import '../../../../../wrapper.dart';
import '../../../../Home/Components/body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final chargeController = TextEditingController();
  Future register() async {
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
    //creating a collection in firestore database called 'Profile'
    final querySnapshot = await FirebaseFirestore.instance
        .collection('profile')
        .where('User ID', isEqualTo: loggedInUserId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final docId = querySnapshot.docs.first.id;

      await addCertification();
      await addExperience();

      await FirebaseFirestore.instance.collection('profile').doc(docId).update({
        'Service Information': {
          'Service Category': '',
          'Services Provided': '',
          'Charge': int.parse(chargeController.text.trim()),
          'Charge Rate': chargeRateHintText,
          'Level of Expertise': expertiseHintText,
        },
        'Work Experience & Certification': {
          'Certification': uploadCertList,
          'Experience': uploadExperienceList,
          'Rating': 0.0,
          'Number of Jobs': 0,
        },
      });
    }

    await Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Wrapper(),
        ),
      );
    });
  }

  Storage storage = Storage();

  Future addCertification() async {
    if (resultCertList != null) {
      resultCertList?.files.forEach((file) async {
        final fileNames = file.name;
        final filePath = file.path;
        await storage.profileMediaUpload(
            'Certification', filePath as String, fileNames);
      });
    } else {
      throw (AppLocalizations.of(context)!.as);
    }
  }

  Future addExperience() async {
    if (resultExperienceList != null) {
      resultExperienceList?.files.forEach((file) async {
        final fileNames = file.name;
        final filePath = file.path;
        await storage.profileMediaUpload(
            'Experience', filePath as String, fileNames);
      });
    } else {
      throw (AppLocalizations.of(context)!.as);
    }
  }

  @override
  void initState() {
    isServiceInfoReadOnly = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 25 * screenHeight),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 5.0, right: 10 * screenWidth),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context)!.servinfo,
                        style: TextStyle(
                          color: black,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 13 * screenHeight),
                Container(
                  constraints: BoxConstraints(
                    minHeight: 236 * screenHeight,
                  ),
                  width: 359 * screenWidth,
                  decoration: BoxDecoration(
                      color: sectionColor,
                      borderRadius: BorderRadius.circular(13)),
                  padding: EdgeInsets.symmetric(
                      horizontal: 23 * screenWidth,
                      vertical: 22 * screenHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          ProfileItem(
                            inputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3)
                            ],
                            isHintText: chargeHintText == '0' ? true : false,
                            isReadOnly: isServiceInfoReadOnly,
                            controller: chargeController,
                            title: 'Charge',
                            hintText: chargeHintText == '0'
                                ? '...'
                                : chargeHintText.toString(),
                            keyboardType: TextInputType.number,
                            isWidthMax: false,
                            width: 73,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: screenHeight * 1.0,
                                left: 10 * screenWidth),
                            child: Container(
                              height: 47 * screenHeight,
                              width: 40 * screenWidth,
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                    color: appointmentTimeColor, width: 1),
                              ),
                              child: Center(
                                child: Text(
                                  '\$',
                                  style: TextStyle(
                                    color: primary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: screenHeight * 1.0),
                            child: ChargeRateSelect(),
                          ),
                          SizedBox(width: 2),
                        ],
                      ),
                      SizedBox(height: 20 * screenHeight),
                      ExpertiseSelect(),
                      SizedBox(height: 10 * screenHeight),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30 * screenHeight),
            JobUploadWorkCertInfo(
                isReadOnly: jobUploadReadOnly,
                isHandyManUpload: true,
                isRegistration: true),
            SizedBox(height: 40 * screenHeight),
            Center(
              child: GestureDetector(
                onTap: register,
                child: Container(
                  height: 56 * screenHeight,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.reg,
                      style: TextStyle(
                        color: white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 23 * screenHeight),
          ],
        ),
      ),
    );
  }
}

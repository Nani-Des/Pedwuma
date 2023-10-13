import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handyman_app/Components/profile_item.dart';
import 'package:handyman_app/Services/storage_service.dart';

import '../constants.dart';
import 'add_file_item.dart';

class ProfileWorkExpInformation extends StatefulWidget {
  const ProfileWorkExpInformation({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileWorkExpInformation> createState() =>
      _ProfileWorkExpInformationState();
}

class _ProfileWorkExpInformationState extends State<ProfileWorkExpInformation> {
  Storage storage = Storage();

  Future updateWorkCertInfo() async {
    setState(() {
      isWorkExpReadOnly = true;
    });

    int job = int.parse(jobTotalHintText!);
    print(job.toString());
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('profile')
          .where('User ID', isEqualTo: loggedInUserId)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final docId = querySnapshot.docs.first.id;
        await FirebaseFirestore.instance
            .collection('profile')
            .doc(docId)
            .update({
          'Work Experience & Certification': {
            'Certification': selectedCertList,
            'Experience': selectedExperienceList,
            'Rating': ratingHintText,
            'Number of Jobs': int.parse(jobTotalHintText!),
          },
        });

        print(selectedCertList);
        print(selectedExperienceList);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.black45,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Center(
              child: Text(
                'Work Experience & Certification has been updated successfully',
                style: TextStyle(height: 1.3),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.black45,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Center(
              child: Text(
                'Work Experience & Certification could not update. Try again later.',
                style: TextStyle(height: 1.3),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future addFileCertification() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: ['pdf', 'txt', 'doc', 'docx'],
      type: FileType.custom,
    );
    if (result != null) {
      final fileName = result.files.single.name;
      final filePath = result.files.single.path!;

      storage.uploadFile(filePath, fileName, 'certification').then((value) {
        print('File Uploaded Successfully');
      });

      fileNameStore = fileName;
      certListFiles();
      print(selectedCertList);
    } else {
      print('File not found.');
    }
  }

  Future addFileExperience() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'txt', 'doc', 'docx'],
      allowMultiple: false,
    );
    if (result != null) {
      final fileName = result.files.single.name;
      final filePath = result.files.single.path!;

      storage.uploadFile(filePath, fileName, 'experience').then((value) {
        print('File Uploaded Successfully');
      });
      experienceListFiles();
      print(selectedExperienceList);
    } else {
      print('File not found.');
    }
  }

  Future experienceListFiles() async {
    await storage.listAllFiles('experience', selectedExperienceList);

    print(selectedExperienceList);
  }

  Future certListFiles() async {
    await storage.listAllFiles('certification', selectedCertList);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Work Experience & Certification',
                style: TextStyle(
                  color: black,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isWorkExpReadOnly = !isWorkExpReadOnly;
                  });
                },
                child: Container(
                  height: 37 * screenHeight,
                  width: 37 * screenWidth,
                  decoration: BoxDecoration(
                    color: white,
                    border: Border.all(
                        color: isWorkExpReadOnly ? sectionColor : primary,
                        width: 1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      isWorkExpReadOnly ? Icons.edit : Icons.clear,
                      color: primary,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 13 * screenHeight),
        Container(
          constraints: BoxConstraints(minHeight: 320),
          width: 359 * screenWidth,
          decoration: BoxDecoration(
              color: sectionColor, borderRadius: BorderRadius.circular(13)),
          padding: EdgeInsets.symmetric(
              horizontal: 23 * screenWidth, vertical: 22 * screenHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AddFileItem(
                directory: 'Certification',
                isReadOnly: isWorkExpReadOnly,
                selectedOptions: selectedCertList,
                screen: () {
                  setState(() {
                    addFileCertification();
                  });
                },
                title: 'Certification',
                hintText: 'Add all certifications here...',
              ),
              SizedBox(height: 20 * screenHeight),
              AddFileItem(
                directory: 'Experience',
                isReadOnly: isWorkExpReadOnly,
                selectedOptions: selectedExperienceList,
                title: 'Experience',
                hintText: 'Add any previous work here...',
                screen: () {
                  addFileExperience();
                },
              ),
              SizedBox(height: 20 * screenHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ProfileItem(
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4)
                    ],
                    isReadOnly: isWorkExpReadOnly,
                    isOverallRating: true,
                    title: 'Rating',
                    hintText: '',
                    keyboardType: TextInputType.number,
                    isWidthMax: false,
                    width: 140,
                  ),
                  SizedBox(width: 20 * screenWidth),
                  ProfileItem(
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(5)
                    ],
                    isHintText: false,
                    title: 'Number of Jobs',
                    hintText: jobTotalHintText.toString(),
                    keyboardType: TextInputType.number,
                    isWidthMax: false,
                    width: 139,
                  ),
                ],
              ),
              SizedBox(height: 10 * screenHeight),
              isWorkExpReadOnly
                  ? SizedBox()
                  : Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: screenHeight * 20.0),
                        child: GestureDetector(
                          onTap: updateWorkCertInfo,
                          child: Container(
                            height: 53 * screenHeight,
                            width: 310 * screenWidth,
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}

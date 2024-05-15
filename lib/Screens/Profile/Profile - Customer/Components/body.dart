import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:handyman_app/Services/storage_service.dart';
import 'package:handyman_app/constants.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../../Components/profile_location_information.dart';
import '../../../../Components/profile_payment_information.dart';
import '../../../../Components/profile_personal_information.dart';
import '../../../../Models/profile.dart';
import '../../../../Services/read_data.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final Storage storage = Storage();

  Future getProfileData() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    loggedInUserId = userId;

    final querySnapshot = await FirebaseFirestore.instance
        .collection('profile')
        .where('User ID', isEqualTo: userId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final profileData = querySnapshot.docs.first.data();
      final user = ProfileData(

      );

      setState(() {
        allProfile.clear();
        allProfile.add(user);


      });
    } else {
      setState(() {
        allProfile.clear();
      });
      return 'User Not Found';
    }
  }

  @override
  void initState() {
    getProfileData();
    super.initState();
  }

  var profilePicPath = '';
  var profilePicUrl = '';

  void profilePic() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
      type: FileType.custom,
    );

    if (result != null) {
      final filePath = result.files.single.path!;
      setState(() {
        profilePicPath = filePath;
      });

      //upload new profile pic
      File file = File(filePath);

      try {
        final pic = await FirebaseStorage.instance
            .ref('$loggedInUserId/profile')
            .child('profile_pic')
            .putFile(file);
        profilePicUrl = await pic.ref.getDownloadURL();

        final document = await FirebaseFirestore.instance
            .collection('users')
            .where('User ID', isEqualTo: loggedInUserId)
            .get();
        final docID = document.docs.single.id;
        await FirebaseFirestore.instance.collection('users').doc(docID).update(
          {
            "Pic": profilePicUrl,
          },
        );
      } catch (e) {
        print(e.toString());
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          backgroundColor: Colors.black45,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: const Center(
            child: Text(
              'No file selected.',
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (allProfile.isEmpty) {
      return Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 15 * screenWidth, vertical: 10 * screenHeight),
            child: Shimmer(
              color: white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 185.75 * screenHeight,
                          width: 177 * screenWidth,
                          decoration: BoxDecoration(
                            color: chatGrey,
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        Positioned(
                          bottom: -13,
                          right: -17,
                          child: Container(
                            height: 35 * screenHeight,
                            width: 35 * screenWidth,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: chatGrey,
                              border: Border.all(color: white, width: 3),
                            ),
                            child: Icon(
                              Icons.camera_alt_rounded,
                              color: grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                              'Personal Information',
                              style: TextStyle(
                                color: black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              height: 37 * screenHeight,
                              width: 37 * screenWidth,
                              decoration: BoxDecoration(
                                color: white,
                                border: Border.all(color: chatGrey, width: 1),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.edit,
                                  color: grey,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 13 * screenHeight),
                      Container(
                        width: 359 * screenWidth,
                        height: 390 * screenHeight,
                        decoration: BoxDecoration(
                            color: chatGrey,
                            borderRadius: BorderRadius.circular(13)),
                        padding: EdgeInsets.symmetric(
                            horizontal: 20 * screenWidth,
                            vertical: 35 * screenHeight),
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return Container(
                                height: 49 * screenHeight,
                                width: 310,
                                decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 20 * screenHeight);
                            },
                            itemCount: 5),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 15 * screenWidth, vertical: 10 * screenHeight),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  FutureBuilder(
                    future: Future.wait(
                      [
                        storage.downloadUrl('profile_pic'),
                        Future.delayed(
                          Duration(seconds: 2),
                        ),
                      ],
                    ),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData &&
                          snapshot.data![0] != null) {
                        imageUrl = snapshot.data![0].toString();
                        return profilePicPath == ''
                            ? Container(
                                height: 185.75 * screenHeight,
                                width: 177 * screenWidth,
                                decoration: BoxDecoration(
                                    color: sectionColor,
                                    borderRadius: BorderRadius.circular(18),
                                    image: DecorationImage(
                                      image: NetworkImage(imageUrl),
                                      fit: BoxFit.cover,
                                    )),
                                alignment: Alignment.bottomRight,
                              )
                            : Container(
                                height: 185.75 * screenHeight,
                                width: 177 * screenWidth,
                                decoration: BoxDecoration(
                                    color: sectionColor,
                                    borderRadius: BorderRadius.circular(18),
                                    image: DecorationImage(
                                      image: FileImage(File(profilePicPath)),
                                      fit: BoxFit.cover,
                                    )),
                                alignment: Alignment.bottomRight,
                              );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Shimmer(
                          color: white,
                          child: Container(
                            height: 185.75 * screenHeight,
                            width: 177 * screenWidth,
                            decoration: BoxDecoration(
                              color: sectionColor,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            alignment: Alignment.bottomRight,
                          ),
                        );
                      }
                      if (snapshot.hasError) {
                        return Container(
                          height: 185.75 * screenHeight,
                          width: 177 * screenWidth,
                          decoration: BoxDecoration(
                            color: sectionColor,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          alignment: Alignment.bottomRight,
                          child: Center(
                            child: Icon(
                              Icons.person,
                              color: grey,
                              size: 80,
                            ),
                          ),
                        );
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                  Positioned(
                    bottom: -13,
                    right: -17,
                    child: GestureDetector(
                      onTap: profilePic,
                      child: Container(
                        height: 35 * screenHeight,
                        width: 35 * screenWidth,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: sectionColor,
                          border: Border.all(color: white, width: 3),
                        ),
                        child: Icon(
                          Icons.camera_alt_rounded,
                          color: grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25 * screenHeight),
            ProfilePersonalInformation(),
            SizedBox(height: 25 * screenHeight),

          ],
        ),
      ),
    );
  }
}

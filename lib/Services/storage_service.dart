// ignore_for_file: avoid_print

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:handyman_app/constants.dart';

//TODO: ADD PORTFOLIO AND REFERENCES WHEN UPLOADING DATA
//TODO: READ DATA FROM LOCAL VARIABLE TO BE USED IN GRID AND SINGLE VIEW

class Storage {
  Future<void> uploadPic(String filePath, String fileName) async {
    File file = File(filePath);

    try {
      await FirebaseStorage.instance
          .ref('$loggedInUserId/profile')
          .child('profile_pic')
          .putFile(file);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<ListResult> listFiles() async {
    ListResult results =
        await FirebaseStorage.instance.ref('$loggedInUserId/images').listAll();
    return results;
  }

  Future<String> downloadUrl(String fileName) async {
    String downloadUrl = await FirebaseStorage.instance
        .ref('$loggedInUserId/profile/$fileName')
        .getDownloadURL();
    return downloadUrl;
  }

  Future<void> uploadFile(
      String filePath, String fileName, String directory) async {
    File file = File(filePath);

    try {
      await FirebaseStorage.instance
          .ref('$loggedInUserId/$directory')
          .child(fileName)
          .putFile(file);
    } catch (e) {
      print(e.toString());
    }
  }

  Future listAllFiles(String directory, List fileNames) async {
    ListResult results = await FirebaseStorage.instance
        .ref('$loggedInUserId/$directory')
        .listAll();
    for (int i = 0; i < results.items.length; i++) {
      final fileName = results.items[i].name;
      print(fileName);
      fileNames.add(fileName);
    }
    return fileNames;
  }

  Future fileDownloadUrl(String downloadUrl, String directory) async {
    String downloadUrl = await FirebaseStorage.instance
        .ref('$loggedInUserId/$directory')
        .getDownloadURL();
    return downloadUrl;
  }

  Future deleteFile(String directory, String fileName) async {
    try {
      await FirebaseStorage.instance
          .ref('$loggedInUserId/$directory')
          .child(fileName)
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future jobUploadFiles(String fileName, String directory, String filePath,
      String jobID, String type) async {
    File file = File(filePath);

    try {
      await FirebaseStorage.instance
          .ref('$loggedInUserId/$type/$jobID/$directory')
          .child(fileName)
          .putFile(file);
    } catch (e) {
      print(e.toString());
    }
  }

  Future profileMediaUpload(
      String directory, String filePath, String fileName) async {
    File file = File(filePath);

    try {
      await FirebaseStorage.instance
          .ref('$loggedInUserId/profile/$directory')
          .child(fileName)
          .putFile(file);
    } catch (e) {
      print(e.toString());
    }
  }

  Future getPortfolioDownloadUrl(String jobId, String type) async {
    jobPortfolioUrls.clear();
    try {
      final result = await FirebaseStorage.instance
          .ref('$currentJobClickedUserId/$type/$jobId/Portfolio')
          .listAll();

      for (final item in result.items) {
        final fileUrl = await item.getDownloadURL();
        jobPortfolioUrls.add(fileUrl);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

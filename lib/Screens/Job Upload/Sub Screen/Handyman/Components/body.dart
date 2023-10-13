// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../Components/upload_list_item.dart';
import '../../../../../Models/customer_job_uploads_data.dart';
import '../../../../../constants.dart';
import '../../../Modify/Handyman/edit_handyman_job_upload.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

List allHandymanJobsUpload = [];

class _BodyState extends State<Body> {
  Future getAllHandymanUploadedJobs() async {
    allHandymanJobsUpload.clear();
    try {
      final result = await FirebaseFirestore.instance
          .collection('Handyman Job Upload')
          .where('Customer ID', isEqualTo: loggedInUserId)
          .get();

      if (result.docs.isNotEmpty) {
        result.docs.forEach((doc) {
          final documentData = doc.data();

          final deadline = documentData['Deadline'];
          var status = '';
          print(deadline[8].toString() + deadline[9].toString());
          DateTime dateTime = DateTime.now();
          if (int.parse(deadline[8].toString() + deadline[9].toString()) <
              (dateTime.year - 2000)) {
            status = 'Expired';
          } else if (int.parse(
                  deadline[3].toString() + deadline[4].toString()) <
              (dateTime.month)) {
            status = 'Expired';
          } else if (int.parse(
                  deadline[0].toString() + deadline[1].toString()) <
              (dateTime.day)) {
            status = 'Expired';
          } else {
            status = 'Active';
          }
          final jobUploadData = CustomerJobUploadsData(
            jobUploadId: documentData['Job ID'],
            fullName: documentData['Name'],
            serviceProvided: documentData['Service Information']
                ['Service Provided'],
            image: documentData['User Pic'],
            uploadJobStatus: status,
            date: int.parse(documentData['Upload Time'].toString()[0] +
                        documentData['Upload Time'].toString()[1]) >
                    11
                ? documentData['Upload Time'] + ' PM'
                : documentData['Upload Time'] + ' AM',
            time: documentData['Upload Date'],
          );
          allHandymanJobsUpload.add(jobUploadData);
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAllHandymanUploadedJobs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return allHandymanJobsUpload.isEmpty
              ? Center(
                  child: Text(
                    'No Jobs Uploaded',
                    style: TextStyle(
                        color: primary,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                )
              : SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 20 * screenHeight),
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return UploadListItem(
                              index: index,
                              screen: EditHandymanJobUpload(),
                              name: allHandymanJobsUpload[index].fullName,
                              imageLocation: allHandymanJobsUpload[index].image,
                              serviceCat:
                                  allHandymanJobsUpload[index].serviceProvided,
                              date: allHandymanJobsUpload[index].date,
                              time: allHandymanJobsUpload[index].time,
                              jobStatus:
                                  allHandymanJobsUpload[index].uploadJobStatus);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 15 * screenHeight);
                        },
                        itemCount: allHandymanJobsUpload.length,
                      ),
                      SizedBox(height: 20 * screenHeight),
                    ],
                  ),
                );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

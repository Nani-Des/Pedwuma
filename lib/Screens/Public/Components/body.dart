import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../Components/job_category_item.dart';
import '../../../Models/handyman_category_data.dart';
import '../../../constants.dart';
import '../../Home/Components/body.dart';
import '../../Login/login_screen.dart';
import '../../Registration/registration_screen.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
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
      .where('User ID')
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
  final _firestore = FirebaseFirestore.instance;
  List<String> avatarUrls = [];

  @override
  void initState() {
    super.initState();
    _getAvatarUrls();
  }

  Future<void> _getAvatarUrls() async {
    // Get documents from "users" collection
    final querySnapshot = await _firestore.collection('users').get();

    // Extract avatar URLs from up to 10 non-empty "Pic" fields
    int count = 0;
    for (var document in querySnapshot.docs) {
      final String url = document['Pic'] as String? ?? '';
      if (url.isNotEmpty) {
        avatarUrls.add(url);
        count++;
      }

      // Break the loop if 10 URLs have been retrieved
      if (count == 10) {
        break;
      }
    }

    print('avatar url: ${avatarUrls.length}');

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // Place other components above the ListView.builder here

          Container(
            height: 120, // Set the desired height
            child: GestureDetector(
              onTap: () {
                Alert(
                  context: context,
                  type: AlertType.info,
                  title: AppLocalizations.of(context)!.gd,
                  style: AlertStyle(
                      titleStyle: TextStyle(fontWeight: FontWeight.w800),
                      descStyle:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
                  desc: AppLocalizations.of(context)!.gg,
                  buttons: [

                    DialogButton(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => RegistrationScreen())),
                      color: Color(0xFF0D47A1),
                      border: Border.all(color: Color(0xffe5f3ff)),
                      child: Text(
                        AppLocalizations.of(context)!.gf,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'DM-Sans',
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ).show();
              },
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: avatarUrls.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(avatarUrls[index]),
                      child: ClipOval(
                        child: Image.network(
                          avatarUrls[index],
                          width: 80, // Set the desired width
                          height: 80, // Set the desired height
                          fit: BoxFit.cover, // Set the fit property
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 12.0, left: screenWidth * 8),
                child: Text(
                  AppLocalizations.of(context)!.gi,
                  style: TextStyle(
                    color: black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              Spacer(),
              Image.asset('assets/icons/sort.png'),
            ],
          ),

          FutureBuilder(
            future: getHandymanCategoryData(),
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
                      ),
                    ),
                  ),
                )
                    : ListView.separated(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: jobDashboardPrice.toSet().toList().length,
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
            },
          ),

          // Place other components below the ListView.builder here
        ],
      ),
      backgroundColor: white,
    );
  }
}
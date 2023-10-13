import 'package:flutter/material.dart';
import '../../../../Components/default_back_button.dart';
import '../../../../constants.dart';
import '../../../Home/Components/body.dart' as home;
import '../../../Job Upload/Sub Screen/Handyman/Components/body.dart';

class HandymanJobUploadList extends StatelessWidget {
  const HandymanJobUploadList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          highlightColor: tabLight,
          onPressed: () {
            if (chargePHint != 'N/A' ||
                uploadTown != '' ||
                deadlineDay != 'Day' ||
                uploadPortfolioList.isNotEmpty ||
                uploadExperienceList.isNotEmpty ||
                uploadCertList.isNotEmpty) {
              seenByHintText = 'All';
              serviceCatHintText = home.allCategoriesName[0];
              chargePHint = 'N/A';
              expertHint = 'N/A';
              uploadHouseNum = '';
              uploadStreet = '';
              uploadTown = '';
              uploadRegion = '';
              deadlineDay = 'Day';
              deadlineMonth = 'Month';
              deadlineYear = 'Year';
              dropdownvalue = 'N/A';
              uploadCertList.clear();
              uploadExperienceList.clear();
              uploadPortfolioList.clear();
            }
            Navigator.pop(context);
          },
          icon: Padding(
            padding: EdgeInsets.only(left: screenWidth * 12.0),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: primary,
              weight: 15,
            ),
          ),
        ),
        title: Text(
          'Job Upload List',
          style: TextStyle(
            color: black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 0.0,
      ),
      backgroundColor: white,
      body: Body(),
    );
  }
}

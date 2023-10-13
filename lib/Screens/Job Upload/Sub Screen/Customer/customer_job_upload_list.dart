import 'package:flutter/material.dart';

import '../../../../Components/job_upload_optionals_info.dart';
import '../../../../constants.dart';
import '../../../Home/Components/body.dart' as home;
import '../../../Job Upload/Sub Screen/Customer/Components/body.dart';

class CustomerJobUploadList extends StatelessWidget {
  const CustomerJobUploadList({Key? key}) : super(key: key);

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
                isPortfolioTicked == true ||
                isReferencesTicked == true ||
                uploadPortfolioList.isNotEmpty) {
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
              uploadPortfolioList.clear();
              isPortfolioTicked = false;
              isReferencesTicked = false;
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

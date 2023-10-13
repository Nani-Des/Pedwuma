import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handyman_app/Components/job_category_item.dart';

import '../../../../Services/read_data.dart';
import '../../../../constants.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReadData readData = ReadData();

    return FutureBuilder(
      future: readData.getHandymanFavouritesData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return handymanFavouritesChargeList.isNotEmpty
              ? SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10 * screenHeight),
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: handymanFavouritesChargeList.length,
                        itemBuilder: (context, index) {
                          return JobCategoryItem(
                            isFavourite: true,
                            jobItemId: handymanFavouritesIDList[index],
                            chargeRate: handymanDashboardChargeRate[index],
                            isFavouriteSelected: true,
                            index: index,
                            price: handymanFavouritesChargeList[index],
                            imageLocation: handymanFavouritesImageList[index],
                            name: handymanFavouritesNameList[index],
                            status: handymanFavouritesStatusList[index],
                            jobType: handymanFavouritesJobTypeList[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: screenHeight * 20);
                        },
                      )
                    ],
                  ),
                )
              : Center(
                  child: Text(
                    'No favourites added.',
                    style: TextStyle(
                      color: primary,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Platform.isAndroid
                ? CircularProgressIndicator()
                : CupertinoActivityIndicator(),
          );
        }
        return Center(
          child: Platform.isAndroid
              ? CircularProgressIndicator()
              : CupertinoActivityIndicator(),
        );
      },
    );
  }
}

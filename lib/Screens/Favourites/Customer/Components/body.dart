// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handyman_app/Services/read_data.dart';

import '../../../../Components/category_item.dart';
import '../../../../constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ReadData readData = ReadData();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: readData.getCustomerFavouritesData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return customerFavouritesChargeList.isNotEmpty
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
                        itemCount: customerFavouritesChargeList.length,
                        itemBuilder: (context, index) {
                          return CategoryItem(
                            isFavourites: true,
                            chargeRate: customerFavouritesChargeRateList[index],
                            isFavouriteSelected: true,
                            index: index,
                            price: customerFavouritesChargeList[index],
                            imageLocation: customerFavouritesImageList[index],
                            name: customerFavouritesNameList[index],
                            rating: customerFavouritesRatingList[index],
                            jobType: customerFavouritesJobTypeList[index],
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
                    'No favourites added',
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

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../Components/category_item.dart';
import '../../Components/job_category_item.dart';
import '../../constants.dart';

class JobSearchDelegate extends SearchDelegate<void> {
  final List itemsToSearch;

  JobSearchDelegate({required this.itemsToSearch});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: primary,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios_rounded,
        color: black,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List filteredItems = itemsToSearch
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return filteredItems.isNotEmpty
        ? ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 35 * screenHeight),
            physics: BouncingScrollPhysics(),
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              late int itemIndex;
              if (jobDashboardJobType.contains(filteredItems[index])) {
                itemIndex = jobDashboardJobType.indexOf(filteredItems[index]);
              }
              JobCategoryItem(
                jobItemId: jobDashboardID[itemIndex],
                index: itemIndex,
                status: jobStatusOptions[itemIndex],
                name: jobDashboardName[itemIndex],
                imageLocation: jobDashboardImage[itemIndex],
                jobType: jobDashboardJobType[itemIndex],
                price: jobDashboardPrice[itemIndex],
                chargeRate: jobDashboardChargeRate[itemIndex],
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: screenHeight * 20);
            },
          )
        : Center(
            child: Text('Job Type is not available'),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List filteredItems = itemsToSearch
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return filteredItems.isNotEmpty
        ? ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 35 * screenHeight),
            physics: BouncingScrollPhysics(),
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              late int itemIndex;
              if (jobDashboardJobType.contains(filteredItems[index])) {
                itemIndex = jobDashboardJobType.indexOf(filteredItems[index]);
              }
              JobCategoryItem(
                jobItemId: jobDashboardID[itemIndex],
                index: itemIndex,
                status: jobStatusOptions[itemIndex],
                name: jobDashboardName[itemIndex],
                imageLocation: jobDashboardImage[itemIndex],
                jobType: jobDashboardJobType[itemIndex],
                price: jobDashboardPrice[itemIndex],
                chargeRate: jobDashboardChargeRate[itemIndex],
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: screenHeight * 20);
            },
          )
        : Center(
            child: Text('Job Type is not available'),
          );
  }
}

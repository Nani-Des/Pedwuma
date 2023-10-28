// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Components/category_item.dart';
import '../../constants.dart';

class HandymanSearchDelegate extends SearchDelegate<void> {
  final List itemsToSearch;

  HandymanSearchDelegate({required this.itemsToSearch});

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
              if (handymanDashboardJobType.contains(filteredItems[index])) {
                itemIndex =
                    handymanDashboardJobType.indexOf(filteredItems[index]);
              }
              return CategoryItem(
                imageLocation: handymanDashboardImage[itemIndex],
                jobType: handymanDashboardJobType[itemIndex],
                name: handymanDashboardName[itemIndex],
                price: handymanDashboardPrice[itemIndex],
                rating: handymanDashboardRating[itemIndex],
                chargeRate: handymanDashboardChargeRate[itemIndex],
                index: itemIndex,
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: screenHeight * 20);
            },
          )
        : Center(
            child: Text(AppLocalizations.of(context)!.by),
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
              if (handymanDashboardJobType.contains(filteredItems[index])) {
                itemIndex =
                    handymanDashboardJobType.indexOf(filteredItems[index]);
              }
              return CategoryItem(
                imageLocation: handymanDashboardImage[itemIndex],
                jobType: handymanDashboardJobType[itemIndex],
                name: handymanDashboardName[itemIndex],
                price: handymanDashboardPrice[itemIndex],
                rating: handymanDashboardRating[itemIndex],
                chargeRate: handymanDashboardChargeRate[itemIndex],
                index: itemIndex,
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: screenHeight * 20);
            },
          )
        : Center(
            child: Text(AppLocalizations.of(context)!.by),
          );
  }
}

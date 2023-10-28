import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Components/category_item.dart';
import '../../constants.dart';

class NotificationSearchDelegate extends SearchDelegate<void> {
  final List itemsToSearch;

  NotificationSearchDelegate({required this.itemsToSearch});

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

    return ListView.separated(
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(filteredItems[index]),
          onTap: () {
            // Handle item tap
            close(context, null);
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
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
              return filteredItems[index] == handymanDashboardJobType[index]
                  ? CategoryItem(
                      imageLocation: handymanDashboardImage[index],
                      jobType: handymanDashboardJobType[index],
                      name: handymanDashboardName[index],
                      price: handymanDashboardPrice[index],
                      rating: handymanDashboardRating[index],
                      chargeRate: handymanDashboardChargeRate[index],
                      index: index,
                    )
                  : SizedBox();
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

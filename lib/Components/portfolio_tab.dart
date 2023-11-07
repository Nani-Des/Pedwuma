// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:handyman_app/Components/single_view.dart';
import 'package:handyman_app/Services/storage_service.dart';

import '../constants.dart';
import 'grid_media.dart';
import 'media_view_type_tab.dart';

class PortfolioTab extends StatefulWidget {
  const PortfolioTab({
    Key? key,
  }) : super(key: key);

  @override
  State<PortfolioTab> createState() => _PortfolioTabState();
}

class _PortfolioTabState extends State<PortfolioTab> {
  @override
  Widget build(BuildContext context) {
    Storage storage = Storage();
    return FutureBuilder(
      future: storage.getPortfolioDownloadUrl(
          typeClicked == 'Customer'
              ? handymanDashboardID[handymanSelectedIndex]
              : jobDashboardID[jobSelectedIndex],
          typeClicked == 'Customer'
              ? 'Booking Profile'
              : 'Jobs'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //changed here... in case of collision or error later
              jobPortfolioUrls.isEmpty
                  ? SizedBox()
                  : MediaViewTypeTab(
                      gridCallback: () {
                        setState(() {
                          isGridViewSelected = !isGridViewSelected;

                          if (isGridViewSelected == true)
                            isSingleViewSelected = false;
                          if (isSingleViewSelected == false)
                            isGridViewSelected = true;
                        });
                      },
                      singleCallback: () {
                        setState(() {
                          isSingleViewSelected = !isSingleViewSelected;

                          if (isSingleViewSelected == true)
                            isGridViewSelected = false;
                          if (isGridViewSelected == false)
                            isSingleViewSelected = true;
                        });
                      },
                    ),
              //changed here... in case of collision or error later
              jobPortfolioUrls.isEmpty
                  ? SizedBox(height: 12 * screenHeight)
                  : SizedBox(height: 29 * screenHeight),
              if (isGridViewSelected == true)
                jobPortfolioUrls.isEmpty
                    ? Center(
                        child: Text('No portfolio present'),
                      )
                    : Padding(
                        padding: EdgeInsets.only(right: screenWidth * 13.0),
                        child: GridView.builder(
                          itemCount: jobPortfolioUrls.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return GridMedia(mediaUrl: jobPortfolioUrls[index]);
                          },
                        ),
                      ),
              if (isSingleViewSelected == true)
                jobPortfolioUrls.isEmpty
                    ? Center(
                        child: Text('No portfolio present'),
                      )
                    : ListView.separated(
                        itemCount: jobPortfolioUrls.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return SingleMedia(mediaUrl: jobPortfolioUrls[index]);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          // return SizedBox(height: 25 * screenHeight);
                          return Container(
                            alignment: Alignment.center,
                            height: 29 * screenHeight,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 180 * screenHeight,
                                  height: 3 * screenHeight,
                                  color: primary.withOpacity(0.1),
                                ),
                                Container(
                                  height: 18 * screenHeight,
                                  width: 20 * screenWidth,
                                  decoration: BoxDecoration(
                                      color: primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                                Container(
                                  width: 180 * screenHeight,
                                  height: 3 * screenHeight,
                                  color: primary.withOpacity(0.1),
                                )
                              ],
                            ),
                          );
                        },
                      )
            ],
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

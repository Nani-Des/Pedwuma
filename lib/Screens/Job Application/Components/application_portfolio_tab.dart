// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../Components/appointment_tab_row.dart';
import '../../../constants.dart';

List jobApplicationPortfolioList = [];

class ApplicationPortfolioTab extends StatefulWidget {
  const ApplicationPortfolioTab({
    super.key,
  });

  @override
  State<ApplicationPortfolioTab> createState() =>
      _ApplicationPortfolioTabState();
}

class _ApplicationPortfolioTabState extends State<ApplicationPortfolioTab> {
  Future selectPortfolio() async {
    try {
      final files = await FilePicker.platform
          .pickFiles(
        allowMultiple: true,
        type: FileType.media,
      )
          .catchError((err) {
        print(err.toString());
      });

      resultList = files!;

      files.files.forEach((file) {
        final filePath = file.path;
        final fileName = file.name;

        if (!jobApplicationPortfolioList.contains(filePath)) {
          setState(() {
            jobApplicationPortfolioList.add(filePath);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                duration: Duration(seconds: 2),
                backgroundColor: Colors.black45,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: Center(
                  child: Text(
                    '$fileName has already been added.',
                    style: TextStyle(height: 1.3),
                    textAlign: TextAlign.center,
                  ),
                )),
          );
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20 * screenWidth,
          vertical: 19 * screenHeight,
        ),
        constraints: BoxConstraints(minHeight: 135 * screenHeight),
        width: 383 * screenWidth,
        decoration: BoxDecoration(
          color: sectionColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppointmentTabRow(tabTitle: 'Portfolio', isCustomVisible: false),
            SizedBox(height: 22 * screenHeight),
            GestureDetector(
              onTap: selectPortfolio,
              child: Center(
                child: Container(
                  height: 34 * screenHeight,
                  width: 322 * screenWidth,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(width: 1, color: appointmentTimeColor),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15 * screenWidth),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Media:',
                        style: TextStyle(
                          color: chatTimeColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 40),
                      Text(
                        'Add portfolio here...',
                        style: TextStyle(
                          color: black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.add,
                        color: black,
                      ),
                      SizedBox(width: 6),
                    ],
                  ),
                ),
              ),
            ),
            jobApplicationPortfolioList.isEmpty
                ? SizedBox()
                : SizedBox(height: 15 * screenHeight),
            jobApplicationPortfolioList.isEmpty
                ? SizedBox()
                : Text(
                    'Media Count: ${jobApplicationPortfolioList.length}',
                    style: TextStyle(
                      color: primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            jobApplicationPortfolioList.isEmpty
                ? SizedBox()
                : SizedBox(height: 15 * screenHeight),
            jobApplicationPortfolioList.isEmpty
                ? SizedBox()
                : SizedBox(
                    height: 90 * screenHeight,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 90 * screenHeight,
                              width: 80 * screenWidth,
                              decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(9),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(File(
                                          jobApplicationPortfolioList[
                                              index])))),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 19 * screenWidth);
                        },
                        itemCount: jobApplicationPortfolioList.length),
                  ),
          ],
        ),
      ),
    );
  }
}

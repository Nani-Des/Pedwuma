// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../constants.dart';

class ServicesTab extends StatelessWidget {
  final String text;
  const ServicesTab({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.0 * screenHeight),
      child: Container(
        padding:
            EdgeInsets.only(left: 30 * screenWidth, right: 20 * screenWidth),
        height: 78 * screenHeight,
        width: 352 * screenWidth,
        decoration: BoxDecoration(
          color: sectionColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 270 * screenWidth,
              child: Text(
                text,
                style: TextStyle(
                    color: black, fontWeight: FontWeight.w500, fontSize: 18),
              ),
            ),
            Icon(Icons.ac_unit, color: primary),
          ],
        ),
      ),
    );
  }
}

class AdditionalInfo extends StatefulWidget {
  final String text;
  final List fileName;
  const AdditionalInfo({
    Key? key,
    required this.text,
    required this.fileName,
  }) : super(key: key);

  @override
  State<AdditionalInfo> createState() => _AdditionalInfoState();
}

class _AdditionalInfoState extends State<AdditionalInfo> {
  bool isMinimized = true;

  @override
  void initState() {
    isMinimized = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.0 * screenHeight),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isMinimized = !isMinimized;
              });
            },
            child: Container(
              padding: EdgeInsets.only(
                left: 30 * screenWidth,
                right: 12 * screenWidth,
                top: isMinimized ? 0 : 20 * screenHeight,
                bottom: isMinimized ? 0 : 30 * screenHeight,
              ),
              constraints: BoxConstraints(
                minHeight: 78 * screenHeight,
              ),
              width: 352 * screenWidth,
              decoration: BoxDecoration(
                color: sectionColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 260 * screenWidth,
                        child: Text(
                          widget.text,
                          style: TextStyle(
                              color: black,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                      ),
                      isMinimized
                          ? Icon(Icons.keyboard_arrow_right_rounded,
                              size: 40, color: black)
                          : Icon(Icons.keyboard_arrow_down_rounded,
                              size: 40, color: primary),
                    ],
                  ),
                  isMinimized
                      ? SizedBox()
                      : SizedBox(
                          height: 19 * screenHeight,
                        ),
                  isMinimized
                      ? SizedBox()
                      : widget.fileName.isEmpty
                          ? Center(
                              child: Text('No files added'),
                            )
                          : ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 20 * screenHeight,
                                      width: 20 * screenWidth,
                                      decoration: BoxDecoration(
                                          // color: black,
                                          ),
                                      child: Icon(
                                        Icons.picture_as_pdf_rounded,
                                        color: primary,
                                      ),
                                    ),
                                    SizedBox(width: 10 * screenWidth),
                                    SizedBox(
                                      width: 278 * screenWidth,
                                      child: Text(
                                        widget.fileName[index],
                                        style: TextStyle(
                                            color: black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 25 * screenHeight);
                              },
                              itemCount: widget.fileName.length),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

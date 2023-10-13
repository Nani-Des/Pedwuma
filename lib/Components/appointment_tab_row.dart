import 'package:flutter/material.dart';

import '../constants.dart';

class AppointmentTabRow extends StatefulWidget {
  bool isCustomVisible;
  bool isRecallAddressVisisble;
  final String tabTitle;
  VoidCallback? onCustomTap;
  AppointmentTabRow({
    Key? key,
    required this.tabTitle,
    this.isCustomVisible = true,
    this.isRecallAddressVisisble = false,
    this.onCustomTap,
  }) : super(key: key);

  @override
  State<AppointmentTabRow> createState() => _AppointmentTabRowState();
}

class _AppointmentTabRowState extends State<AppointmentTabRow> {
  @override
  Widget build(BuildContext context) {
    void AddressRecall() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Center(
              child: Text(
                'Saved Addresses',
                style: TextStyle(
                  color: black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            content: Container(
              constraints: BoxConstraints(
                minHeight: 5 * screenHeight,
              ),
              // height: 357 * screenHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(24)),
              padding: EdgeInsets.symmetric(
                vertical: 22 * screenWidth,
                horizontal: 5 * screenWidth,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  addressTownName.isEmpty
                      ? Center(
                          child: Text('No addresses saved.',
                              style: TextStyle(
                                color: primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              )),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  apppointmentRegion = regionValue;
                                  apppointmentHouseNum = addressHouseNum[index];
                                  apppointmentStreet = addressStreetName[index];
                                  apppointmentTown = addressTownName[index];
                                });
                              },
                              child: Container(
                                constraints: BoxConstraints(
                                    minHeight: 50 * screenHeight),
                                width: 310 * screenWidth,
                                decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      color: appointmentTimeColor, width: 1),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15 * screenWidth,
                                    vertical: 12 * screenHeight),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'Address ' + (index + 1).toString(),
                                          style: TextStyle(
                                            color: primary,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      addressHouseNum[index] +
                                          ',\n' +
                                          addressStreetName[index] +
                                          ', ' +
                                          addressTownName[index] +
                                          ',\n' +
                                          addressRegionName[index] +
                                          ', Ghana',
                                      style: TextStyle(
                                        color: black,
                                        fontSize: 16,
                                        height: 1.3,
                                      ),
                                    ),
                                    SizedBox(height: 10 * screenHeight),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 12 * screenHeight);
                          },
                          itemCount: addressTownName.length)
                ],
              ),
            ),
          );
        },
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          widget.tabTitle,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: black,
          ),
        ),
        Spacer(),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 31 * screenHeight,
            width: 30 * screenWidth,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: white,
                border: Border.all(
                  color: primary,
                  width: 2,
                )),
            child: Image.asset('assets/icons/info.png'),
          ),
        ),
        SizedBox(width: 7 * screenWidth),
        widget.isCustomVisible
            ? Padding(
                padding: EdgeInsets.only(right: screenWidth * 8.0),
                child: GestureDetector(
                  onTap: widget.onCustomTap,
                  child: Container(
                    height: 31 * screenHeight,
                    width: 80 * screenWidth,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: white,
                        border: Border.all(
                          color: primary,
                          width: 2,
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/icons/plus.png'),
                        Text(
                          'Custom',
                          style: TextStyle(
                            color: black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : SizedBox(),
        widget.isRecallAddressVisisble
            ? Padding(
                padding: EdgeInsets.only(right: screenWidth * 8.0),
                child: GestureDetector(
                  onTap: () {
                    AddressRecall();
                  },
                  child: Container(
                    height: 31 * screenHeight,
                    width: 30 * screenWidth,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: white,
                        border: Border.all(
                          color: primary,
                          width: 2,
                        )),
                    child: Icon(
                      Icons.refresh,
                      color: primary,
                    ),
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}

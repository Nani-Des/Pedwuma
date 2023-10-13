import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handyman_app/Components/profile_item_dropdown.dart';

import '../constants.dart';

class JobUploadLocationInfo extends StatefulWidget {
  bool isReadOnly;
  JobUploadLocationInfo({
    Key? key,
    this.isReadOnly = false,
  }) : super(key: key);

  @override
  State<JobUploadLocationInfo> createState() => _JobUploadLocationInfoState();
}

class _JobUploadLocationInfoState extends State<JobUploadLocationInfo> {
  final streetNameController = TextEditingController();
  final townController = TextEditingController();
  final houseNumController = TextEditingController();

  @override
  void dispose() {
    streetNameController.dispose();
    townController.dispose();
    houseNumController.dispose();
  }

  bool FieldsCheck() {
    if (streetNameController.text.trim().isNotEmpty &&
        townController.text.trim().isNotEmpty &&
        houseNumController.text.trim().isNotEmpty &&
        regionValue != 'N/A') {
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.black45,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Center(
              child: Text(
                'One or more fields have a problem. Check them again.',
                style: TextStyle(height: 1.3),
                textAlign: TextAlign.center,
              ),
            )),
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 5.0),
          child: Text(
            'Location',
            style: TextStyle(
              color: black,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 13 * screenHeight),
        Container(
          constraints: BoxConstraints(minHeight: 100),
          width: 359 * screenWidth,
          decoration: BoxDecoration(
              color: sectionColor, borderRadius: BorderRadius.circular(13)),
          padding: EdgeInsets.symmetric(
              horizontal: 23 * screenWidth, vertical: 22 * screenHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ProfileItemAddAddress(
                isReadOnly: widget.isReadOnly,
                screen: () {
                  Navigator.pop(context);

                  if (FieldsCheck()) {
                    setState(() {
                      uploadTown = townController.text.trim();
                      uploadStreet = streetNameController.text.trim();
                      uploadHouseNum = houseNumController.text.trim();
                      uploadRegion = regionValue;
                    });
                  }
                },
                title: 'Address',
                hintText: 'Add address here...',
                streetNameController: streetNameController,
                townController: townController,
                houseNumController: houseNumController,
              ),
              SizedBox(height: 12 * screenHeight),
              uploadTown == ''
                  ? Center(
                      child: Text(
                        'No addresses added',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(
                      constraints: BoxConstraints(minHeight: 50 * screenHeight),
                      width: 310 * screenWidth,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(7),
                        border:
                            Border.all(color: appointmentTimeColor, width: 1),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 15 * screenWidth,
                          vertical: 12 * screenHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Address',
                                style: TextStyle(
                                  color: primary,
                                  fontSize: 16,
                                ),
                              ),
                              GestureDetector(
                                onTap: widget.isReadOnly
                                    ? () {}
                                    : () {
                                        setState(() {
                                          uploadRegion = '';
                                          uploadHouseNum = '';
                                          uploadStreet = '';
                                          uploadTown = '';
                                          streetNameController.clear();
                                          townController.clear();
                                          houseNumController.clear();
                                          regionValue = 'N/A';
                                          dropdownvalue = 'N/A';
                                        });
                                      },
                                child: Container(
                                    height: 25 * screenHeight,
                                    width: 25 * screenWidth,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: white,
                                        border: Border.all(
                                          color: appointmentTimeColor,
                                          width: 1,
                                        )),
                                    child: Icon(
                                      Icons.remove,
                                      color: primary,
                                    )),
                              ),
                            ],
                          ),
                          Text(
                            uploadHouseNum +
                                ',\n' +
                                uploadStreet +
                                ', ' +
                                uploadTown +
                                ',\n' +
                                uploadRegion +
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
              SizedBox(height: 5 * screenHeight),
            ],
          ),
        ),
      ],
    );
  }
}

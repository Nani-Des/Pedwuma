// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handyman_app/Components/profile_item_dropdown.dart';
import 'package:handyman_app/Components/saved_addresses.dart';

import '../constants.dart';

class ProfileLocationInformation extends StatefulWidget {
  const ProfileLocationInformation({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileLocationInformation> createState() =>
      _ProfileLocationInformationState();
}

class _ProfileLocationInformationState
    extends State<ProfileLocationInformation> {
  final streetNameController = TextEditingController();
  final townController = TextEditingController();
  final houseNumController = TextEditingController();

  @override
  void dispose() {
    streetNameController.dispose();
    townController.dispose();
    houseNumController.dispose();
  }

  final userId = FirebaseAuth.instance.currentUser!.uid;

  Future saveLocation() async {
    setState(() {
      isLocationReadOnly = true;
    });
    if (AddressPresent()) {
      try {
        updateLocation();
      } catch (e) {
        print(
          e.toString(),
        );
      }
    } else {
      try {
        updateLocation();
      } catch (e) {
        print(
          e.toString(),
        );
      }
    }
  }

  Future updateLocation() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('profile')
        .where('User ID', isEqualTo: userId)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      final docId = querySnapshot.docs.first.id;

      await FirebaseFirestore.instance.collection('profile').doc(docId).update({
        'Address Information': {
          'Street Name': addressStreetName,
          'Town': addressTownName,
          'Region': addressRegionName,
          'House Number': addressHouseNum,
        }
      });
    } else {
      throw 'User Not Found';
    }
  }

  bool AddressPresent() {
    if (addressStreetName.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.black45,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Center(
              child: Text(
                'Location Information has been added successfully.',
              ),
            )),
      );
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
                'No addresses present. All addresses will be removed from cloud storage.',
                textAlign: TextAlign.center,
              ),
            )),
      );
      return false;
    }
  }

  bool InputAddressFieldsCheck() {
    if (streetNameController.text.trim().isNotEmpty &&
        townController.text.trim().isNotEmpty &&
        regionValue != 'N/A' &&
        houseNumController.text.trim().isNotEmpty) {
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
                'One or more fields has a problem. Try again',
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Location',
                style: TextStyle(
                  color: black,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isLocationReadOnly = !isLocationReadOnly;
                  });
                },
                child: Container(
                  height: 37 * screenHeight,
                  width: 37 * screenWidth,
                  decoration: BoxDecoration(
                    color: white,
                    border: Border.all(
                        color: isLocationReadOnly ? sectionColor : primary,
                        width: 1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      isLocationReadOnly ? Icons.edit : Icons.clear,
                      color: primary,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
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
                isReadOnly: isLocationReadOnly,
                screen: () {
                  //if address entered in pop up is present in previous addresses, display Snackbar and ignore address
                  if (InputAddressFieldsCheck()) {
                    if (addressTownName.contains(townController.text.trim()) &&
                        addressStreetName
                            .contains(streetNameController.text.trim()) &&
                        addressHouseNum
                            .contains(houseNumController.text.trim())) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.black45,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            content: Center(
                              child: Text(
                                'Address entered is already present. Try a different address.',
                                style: TextStyle(height: 1.3),
                                textAlign: TextAlign.center,
                              ),
                            )),
                      );
                    }
                    //if address entered in pop up is NOT present in previous addresses, then add address
                    else {
                      setState(() {
                        addressStreetName.add(streetNameController.text);
                        addressTownName.add(townController.text);
                        addressHouseNum.add(houseNumController.text);
                        addressRegionName.add(regionValue);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.black45,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            content: Center(
                              child: Text(
                                'Address has been added successfully.',
                                textAlign: TextAlign.center,
                              ),
                            )),
                      );
                    }
                  }
                  Navigator.pop(context);
                  print(addressStreetName);
                  print(addressHouseNum);
                  print(addressTownName);
                  print(addressRegionName);
                  streetNameController.clear();
                  townController.clear();
                  houseNumController.clear();
                },
                title: 'Address',
                hintText: 'Add address here...',
                streetNameController: streetNameController,
                townController: townController,
                houseNumController: houseNumController,
              ),
              SizedBox(height: 12 * screenHeight),
              addressTownName.isEmpty
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
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          constraints:
                              BoxConstraints(minHeight: 50 * screenHeight),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Address ${index + 1}',
                                    style: TextStyle(
                                      color: primary,
                                      fontSize: 16,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      {
                                        if (isLocationReadOnly == false)
                                          setState(() {
                                            addressRegionName.removeAt(index);
                                            addressTownName.removeAt(index);
                                            addressStreetName.removeAt(index);
                                            addressHouseNum.removeAt(index);
                                          });
                                      }
                                    },
                                    child: Container(
                                        height: 25 * screenHeight,
                                        width: 25 * screenWidth,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
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
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 12 * screenHeight);
                      },
                      itemCount: addressTownName.length),
              isLocationReadOnly
                  ? SizedBox()
                  : Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: screenHeight * 20.0),
                        child: GestureDetector(
                          onTap: saveLocation,
                          child: Container(
                            height: 53 * screenHeight,
                            width: 310 * screenWidth,
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
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

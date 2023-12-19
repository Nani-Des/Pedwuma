import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handyman_app/Components/profile_item.dart';
import 'package:handyman_app/Components/profile_item_dropdown.dart';
import 'package:handyman_app/Screens/Home/Components/body.dart';

import '../Models/category.dart';
import '../constants.dart';

class ProfileServiceInformation extends StatefulWidget {
  const ProfileServiceInformation({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileServiceInformation> createState() =>
      _ProfileServiceInformationState();
}

class _ProfileServiceInformationState extends State<ProfileServiceInformation> {
  final chargeController = TextEditingController();

  @override
  void dispose() {
    chargeController.dispose();
    super.dispose();
  }

  Future updateServiceInfo() async {
    setState(() {
      isServiceInfoReadOnly = true;
    });

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('profile')
          .where('User ID', isEqualTo: loggedInUserId)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final docId = querySnapshot.docs.first.id;
        await FirebaseFirestore.instance
            .collection('profile')
            .doc(docId)
            .update({
          'Service Information': {
            'Service Category': selectedServiceCatList,
            'Services Provided': selectedServiceProvList,
            'Charge': int.parse(chargeController.text.trim()),
            'Charge Rate': chargeRateHintText,
            'Level of Expertise': expertiseHintText,
          },
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
                  'Personal profile successfully updated.',
                ),
              )),
        );
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
                'Service Information could not update. Try again later.',
                style: TextStyle(height: 1.3),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // @override
  // void initState() {
  //   // getCategoryServices(selectedServiceCatList);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              EdgeInsets.only(left: screenWidth * 5.0, right: 10 * screenWidth),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Service Information',
                style: TextStyle(
                  color: black,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isServiceInfoReadOnly = !isServiceInfoReadOnly;
                  });
                },
                child: Container(
                  height: 37 * screenHeight,
                  width: 37 * screenWidth,
                  decoration: BoxDecoration(
                    color: white,
                    border: Border.all(
                        color: isServiceInfoReadOnly ? sectionColor : primary,
                        width: 1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      isServiceInfoReadOnly ? Icons.edit : Icons.clear,
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
          constraints: BoxConstraints(
            minHeight: 422 * screenHeight,
          ),
          width: 359 * screenWidth,
          decoration: BoxDecoration(
              color: sectionColor, borderRadius: BorderRadius.circular(13)),
          padding: EdgeInsets.symmetric(
              horizontal: 23 * screenWidth, vertical: 22 * screenHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ProfileItemDropDown(
                isReadOnly: isServiceInfoReadOnly,
                selectedOptions: selectedServiceCatList,
                title: 'Service Category',
                hintText: 'Choose all that apply...',
                listName: allCategoriesName.toSet().toList(),
              ),
              SizedBox(height: 20 * screenHeight),
              ProfileItemDropDown(
                isReadOnly: isServiceInfoReadOnly,
                selectedOptions: selectedServiceProvList,
                title: 'Services Provided',
                hintText: 'Choose all that apply...',
                listName: allSelectedServiceProvided.toSet().toList(),
              ),
              SizedBox(height: 20 * screenHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  ProfileItem(
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3)
                    ],
                    isHintText: chargeHintText == '0' ? true : false,
                    isReadOnly: isServiceInfoReadOnly,
                    controller: chargeController,
                    title: 'Charge',
                    hintText: chargeHintText == '0'
                        ? '...'
                        : chargeHintText.toString(),
                    keyboardType: TextInputType.number,
                    isWidthMax: false,
                    width: 73,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: screenHeight * 1.0, left: 10 * screenWidth),
                    child: Container(
                      height: 47 * screenHeight,
                      width: 40 * screenWidth,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(7),
                        border:
                            Border.all(color: appointmentTimeColor, width: 1),
                      ),
                      child: Center(
                        child: Text(
                          '\₵',
                          style: TextStyle(
                            color: primary,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 1.0),
                    child: ChargeRateSelect(),
                  ),
                  SizedBox(width: 2),
                ],
              ),
              SizedBox(height: 20 * screenHeight),
              ExpertiseSelect(),
              SizedBox(height: 10 * screenHeight),
              isServiceInfoReadOnly
                  ? SizedBox()
                  : Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: screenHeight * 20.0),
                        child: GestureDetector(
                          onTap: updateServiceInfo,
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
            ],
          ),
        ),
      ],
    );
  }
}

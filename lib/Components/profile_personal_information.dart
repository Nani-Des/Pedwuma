import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handyman_app/Components/profile_item.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../Services/read_data.dart';
import '../constants.dart';

class ProfilePersonalInformation extends StatefulWidget {
  const ProfilePersonalInformation({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePersonalInformation> createState() =>
      _ProfilePersonalInformationState();
}

class _ProfilePersonalInformationState
    extends State<ProfilePersonalInformation> {
  final _emailControlller = TextEditingController();
  final _firstNameControlller = TextEditingController();
  final _lastNameControlller = TextEditingController();
  final _numberControlller = TextEditingController();

  @override
  void dispose() {
    _emailControlller.dispose();
    _firstNameControlller.dispose();
    _lastNameControlller.dispose();
    _numberControlller.dispose();

    super.dispose();
  }

  Future updatePersonalInfo() async {
    setState(() {
      isPersonalInfoReadOnly = true;
    });
    if (FieldsCheck()) {
      try {
        final String userId = FirebaseAuth.instance.currentUser!.uid;

        final querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('User ID', isEqualTo: userId)
            .get();
        final docId = querySnapshot.docs.first.id;
        print(docId);

        await FirebaseFirestore.instance.collection('users').doc(docId).update(
          {
            'First Name': _firstNameControlller.text.trim(),
            'Last Name': _lastNameControlller.text.trim(),
            'Email Address': _emailControlller.text.trim(),
            'Mobile Number': int.parse('0' + _numberControlller.text.trim()),
          },
        );
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
      } catch (e) {
        print(e.toString());
      }
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
    }
  }

  bool FieldsCheck() {
    if (_firstNameControlller.text.trim() != allUsers[0].firstName &&
        _firstNameControlller.text.trim().isNotEmpty &&
        _lastNameControlller.text.trim() != allUsers[0].lastName &&
        _lastNameControlller.text.trim().isNotEmpty &&
        _emailControlller.text.trim() != allUsers[0].email &&
        _emailControlller.text.trim().isNotEmpty &&
        _numberControlller.text.trim() != allUsers[0].number &&
        _numberControlller.text.trim().isNotEmpty) {
      print('First Name can be updated');
      return true;
    } else {
      _firstNameControlller.clear();
      _lastNameControlller.clear();
      _emailControlller.clear();
      _numberControlller.clear();
      print("There's an error in one of the fields");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var numberMask = MaskTextInputFormatter(
        mask: '+### (#) ###-###-###',
        filter: {
          "#": RegExp(r'[0-9]'),
        },
        type: MaskAutoCompletionType.lazy);

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
                'Personal Information',
                style: TextStyle(
                  color: black,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isPersonalInfoReadOnly = !isPersonalInfoReadOnly;
                  });
                },
                child: Container(
                  height: 37 * screenHeight,
                  width: 37 * screenWidth,
                  decoration: BoxDecoration(
                    color: white,
                    border: Border.all(
                        color: isPersonalInfoReadOnly ? sectionColor : primary,
                        width: 1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      isPersonalInfoReadOnly ? Icons.edit : Icons.clear,
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
          width: 359 * screenWidth,
          decoration: BoxDecoration(
              color: sectionColor, borderRadius: BorderRadius.circular(13)),
          padding: EdgeInsets.symmetric(
              horizontal: 23 * screenWidth, vertical: 22 * screenHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ProfileItem(
                inputFormatter: [
                  FilteringTextInputFormatter.allow(
                      RegExp("[a-zA-Z\\s]")), // Only allow letters and spaces
                  LengthLimitingTextInputFormatter(25),
                ],
                controller: _firstNameControlller,
                isHintText: false,
                isReadOnly: isPersonalInfoReadOnly,
                title: 'First Name',
                hintText: allUsers[0].firstName,
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 20 * screenHeight),
              ProfileItem(
                inputFormatter: [
                  FilteringTextInputFormatter.allow(
                      RegExp("[a-zA-Z\\s]")), // Only allow letters and spaces
                  LengthLimitingTextInputFormatter(25),
                ],
                controller: _lastNameControlller,
                isHintText: false,
                isReadOnly: isPersonalInfoReadOnly,
                title: 'Last Name',
                hintText: allUsers[0].lastName,
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 20 * screenHeight),
              ProfileItem(
                inputFormatter: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@.]')),

                  LengthLimitingTextInputFormatter(
                      30) // Deny specific characters
                ],
                controller: _emailControlller,
                isHintText: false,
                isReadOnly: isPersonalInfoReadOnly,
                title: 'Email',
                hintText: allUsers[0].email,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20 * screenHeight),
              ProfileItem(
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(13),
                  numberMask,
                ],
                controller: _numberControlller,
                isHintText: false,
                isReadOnly: isPersonalInfoReadOnly,
                title: 'Mobile Number',
                hintText: '+233 (0) ' + allUsers[0].number.toString(),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10 * screenHeight),
              isPersonalInfoReadOnly
                  ? SizedBox()
                  : Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: screenHeight * 20.0),
                        child: GestureDetector(
                          onTap: updatePersonalInfo,
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

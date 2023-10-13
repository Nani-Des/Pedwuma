import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handyman_app/Components/profile_item.dart';
import 'package:handyman_app/Components/profile_item_dropdown.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../constants.dart';

class ProfilePaymentInformation extends StatefulWidget {
  const ProfilePaymentInformation({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePaymentInformation> createState() =>
      _ProfilePaymentInformationState();
}

class _ProfilePaymentInformationState extends State<ProfilePaymentInformation> {
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();
  final _payPalController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _payPalController.dispose();
    super.dispose();
  }

  Future updatePaymentInfo() async {
    setState(() {
      isPaymentInfoReadOnly = true;
    });

    // update current user's firebase record with payment information

    if (CheckFields()) {
      try {
        updateDetails();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.black45,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Center(
              child: Text(
                'Payment profile successfully updated.',
              ),
            ),
          ),
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
          ),
        ),
      );
    }
  }

  // late final String userId;

  Future updateDetails() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final querySnapshot = await FirebaseFirestore.instance
        .collection('profile')
        .where('User ID', isEqualTo: userId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final docId = querySnapshot.docs.first.id;

      await FirebaseFirestore.instance.collection('profile').doc(docId).update({
        'Mobile Money Type': selectedMomoOptions,
        'Credit Card Information': {
          'Card Number': int.parse(_cardNumberController.text.trim()),
          'Expiry Date': _expiryDateController.text.length >= 4
              ? _expiryDateController.text[0] +
                  _expiryDateController.text[1] +
                  '/' +
                  _expiryDateController.text[2] +
                  _expiryDateController.text[3]
              : 'Invalid Expiry Date',
          'CVV': int.parse(_cvvController.text.trim()),
        },
        'PayPal': _payPalController.text.trim(),
      });
    } else {
      return 'User Not Found';
    }
  }

  bool CheckFields() {
    if (_cardNumberController.text.trim().isNotEmpty &&
        _cvvController.text.trim().isNotEmpty &&
        _expiryDateController.text.trim().isNotEmpty &&
        _payPalController.text.trim().isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var cardNumberMask = MaskTextInputFormatter(
        mask: '#### #### #### ####',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
    var expiryDatemask = MaskTextInputFormatter(
        mask: '##/##',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);

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
                'Payment Information',
                style: TextStyle(
                  color: black,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isPaymentInfoReadOnly = !isPaymentInfoReadOnly;
                  });
                },
                child: Container(
                  height: 37 * screenHeight,
                  width: 37 * screenWidth,
                  decoration: BoxDecoration(
                    color: white,
                    border: Border.all(
                        color: isPaymentInfoReadOnly ? sectionColor : primary,
                        width: 1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      isPaymentInfoReadOnly ? Icons.edit : Icons.clear,
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
          constraints: BoxConstraints(minHeight: 382),
          width: 359 * screenWidth,
          decoration: BoxDecoration(
              color: sectionColor, borderRadius: BorderRadius.circular(13)),
          padding: EdgeInsets.symmetric(
              horizontal: 23 * screenWidth, vertical: 22 * screenHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //range index error is from here
              ProfileItemAddFile(
                isReadOnly: isPaymentInfoReadOnly,
                isMomoOptions: true,
                selectedOptions: selectedMomoOptions,
                title: 'Mobile Money',
                hintText: 'Select all that apply...',
                listName: momoListOptions,
              ),
              SizedBox(height: 20 * screenHeight),
              ProfileItem(
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                  cardNumberMask,
                ],
                isHintText: cardNumberHintText == null ? true : false,
                // maxLength: 16,
                isReadOnly: isPaymentInfoReadOnly,
                controller: _cardNumberController,
                imageAssetLocation: 'assets/icons/credit_card.png',
                isCreditCard: true,
                isWidthMax: false,
                width: 310,
                title: 'Credit Card',
                hintText: cardNumberHintText == null
                    ? 'Enter card number...'
                    : '**** **** **** ****',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 11 * screenHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ProfileItem(
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(5),
                      expiryDatemask,
                    ],
                    isHintText: expiryDateHintText == null ? true : false,
                    isReadOnly: isPaymentInfoReadOnly,
                    controller: _expiryDateController,
                    isTitlePresent: false,
                    title: '',
                    hintText: expiryDateHintText == null ? 'MM/YY' : '**/**',
                    keyboardType: TextInputType.datetime,
                    isWidthMax: false,
                    width: 174,
                  ),
                  SizedBox(width: 20 * screenWidth),
                  ProfileItem(
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4)
                    ],
                    isHintText: cvvHintText == null ? true : false,
                    isReadOnly: isPaymentInfoReadOnly,
                    controller: _cvvController,
                    isInputObscured: true,
                    isTitlePresent: false,
                    title: '',
                    hintText: cvvHintText == null ? 'CVV/CVC' : '****',
                    keyboardType: TextInputType.number,
                    isWidthMax: false,
                    width: 116,
                  ),
                ],
              ),
              SizedBox(height: 20 * screenHeight),
              ProfileItem(
                inputFormatter: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@.]')),

                  LengthLimitingTextInputFormatter(
                      30) // Deny specific characters
                ],
                isHintText: payPalHintText == null ? true : false,
                isReadOnly: isPaymentInfoReadOnly,
                controller: _payPalController,
                title: 'PayPal',
                hintText: payPalHintText == null
                    ? 'Enter PayPal address...'
                    : payPalHintText.toString(),
                keyboardType: TextInputType.emailAddress,
                isCreditCard: true,
                imageAssetLocation: 'assets/icons/pay_pal.png',
              ),
              SizedBox(height: 10 * screenHeight),
              isPaymentInfoReadOnly
                  ? SizedBox()
                  : Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: screenHeight * 20.0),
                        child: GestureDetector(
                          onTap: updatePaymentInfo,
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

//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:handyman_app/Components/profile_item.dart';
// import 'package:handyman_app/Components/profile_item_dropdown.dart';
// import 'package:handyman_app/Models/profile.dart';
// import 'package:handyman_app/Models/users.dart';
// import 'package:handyman_app/Read%20Data/get_user_first_name.dart';
//
// import '../constants.dart';
//
// class ProfilePaymentInformation extends StatefulWidget {
//   const ProfilePaymentInformation({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<ProfilePaymentInformation> createState() =>
//       _ProfilePaymentInformationState();
// }
//
// class _ProfilePaymentInformationState extends State<ProfilePaymentInformation> {
//   final _cardNumberController = TextEditingController();
//   final _expiryDateController = TextEditingController();
//   final _cvvController = TextEditingController();
//   final _payPalController = TextEditingController();
//
//   @override
//   void dispose() {
//     _cardNumberController.dispose();
//     _expiryDateController.dispose();
//     _cvvController.dispose();
//     _payPalController.dispose();
//     super.dispose();
//   }
//
//   Future updatePaymentInfo() async {
//     setState(() {
//       isPaymentInfoReadOnly = true;
//     });
//
//     // update current user's firebase record with payment information
//
//     if (CheckFields()) {
//       try {
//         updateDetails();
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             duration: Duration(seconds: 2),
//             backgroundColor: Colors.black45,
//             behavior: SnackBarBehavior.floating,
//             shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//             content: Center(
//               child: Text(
//                 'Payment profile successfully updated.',
//               ),
//             ),
//           ),
//         );
//       } catch (e) {
//         print(e.toString());
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           duration: Duration(seconds: 2),
//           backgroundColor: Colors.black45,
//           behavior: SnackBarBehavior.floating,
//           shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//           content: Center(
//             child: Text(
//               'One or more fields has a problem. Try again',
//             ),
//           ),
//         ),
//       );
//     }
//   }
//
//   // late final String userId;
//
//   Future updateDetails() async {
//     final userId = FirebaseAuth.instance.currentUser!.uid;
//     final querySnapshot = await FirebaseFirestore.instance
//         .collection('profile')
//         .where('User ID', isEqualTo: userId)
//         .get();
//
//     if (querySnapshot.docs.isNotEmpty) {
//       final docId = querySnapshot.docs.first.id;
//
//       await FirebaseFirestore.instance.collection('profile').doc(docId).update({
//         'Mobile Money Type': selectedMomoOptions,
//         'Credit Card Information': {
//           'Card Number': int.parse(_cardNumberController.text.trim()),
//           'Expiry Date': _expiryDateController.text.length >= 4
//               ? _expiryDateController.text[0] +
//               _expiryDateController.text[1] +
//               '/' +
//               _expiryDateController.text[2] +
//               _expiryDateController.text[3]
//               : 'Invalid Expiry Date',
//           'CVV': int.parse(_cvvController.text.trim()),
//         },
//         'PayPal': _payPalController.text.trim(),
//       });
//     } else {
//       return 'User Not Found';
//     }
//   }
//
//   Future getProfileData() async {
//     final userId = FirebaseAuth.instance.currentUser!.uid;
//
//     final querySnapshot = await FirebaseFirestore.instance
//         .collection('profile')
//         .where('User ID', isEqualTo: userId)
//         .get();
//
//     if (querySnapshot.docs.isNotEmpty) {
//       final profileData = querySnapshot.docs.first.data();
//       final user = ProfileData(
//         cardNumber: profileData['Credit Card Information'] != null
//             ? profileData['Credit Card Information']['Card Number']
//             : null,
//         expiryDate: profileData['Credit Card Information'] != null
//             ? profileData['Credit Card Information']['Expiry Date']
//             : null,
//         cvv: profileData['Credit Card Information'] != null
//             ? profileData['Credit Card Information']['CVV']
//             : null,
//         momoType: profileData['Mobile Money Type'] != null
//             ? (profileData['Mobile Money Type'] as List<dynamic>).cast<String>()
//             : null,
//         payPalAddress:
//         profileData['PayPal'] != null ? profileData['PayPal'] : null,
//       );
//
//       allProfile.clear();
//       allProfile.add(user);
//       print(allProfile[0].cvv);
//       print(allProfile[0].expiryDate);
//       print(allProfile[0].cardNumber);
//       print(allProfile[0].payPalAddress);
//       print(allProfile[0].momoType);
//
//       if (allProfile[0].momoType != null) {
//         selectedMomoOptions = allProfile[0].momoType;
//       }
//     } else {
//       return 'User Not Found';
//     }
//   }
//
//   bool CheckFields() {
//     if (_cardNumberController.text.trim().isNotEmpty &&
//         _cvvController.text.trim().isNotEmpty &&
//         _expiryDateController.text.trim().isNotEmpty &&
//         _payPalController.text.trim().isNotEmpty) {
//       return true;
//     } else {
//       return false;
//     }
//   }
//
//   @override
//   void initState() {
//     getProfileData();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     getProfileData();
//
//
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Padding(
//           padding: EdgeInsets.only(left: screenWidth * 5.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 'Payment Information',
//                 style: TextStyle(
//                   color: black,
//                   fontSize: 17,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     isPaymentInfoReadOnly = !isPaymentInfoReadOnly;
//                   });
//                 },
//                 child: Container(
//                   height: 37 * screenHeight,
//                   width: 37 * screenWidth,
//                   decoration: BoxDecoration(
//                     color: white,
//                     border: Border.all(
//                         color: isPaymentInfoReadOnly ? sectionColor : primary,
//                         width: 1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Center(
//                     child: Icon(
//                       isPaymentInfoReadOnly ? Icons.edit : Icons.clear,
//                       color: primary,
//                       size: 20,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 13 * screenHeight),
//         Container(
//           constraints: BoxConstraints(minHeight: 382),
//           width: 359 * screenWidth,
//           decoration: BoxDecoration(
//               color: sectionColor, borderRadius: BorderRadius.circular(13)),
//           padding: EdgeInsets.symmetric(
//               horizontal: 23 * screenWidth, vertical: 22 * screenHeight),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               ProfileItemAddFile(
//                 isReadOnly: isPaymentInfoReadOnly,
//                 isMomoOptions: true,
//                 selectedOptions: selectedMomoOptions,
//                 title: 'Mobile Money',
//                 hintText: 'Select all that apply...',
//                 listName: momoListOptions,
//               ),
//               SizedBox(height: 20 * screenHeight),
//               ProfileItem(
//                 isHintText: allProfile[0].cardNumber == null ? true : false,
//                 maxLength: 16,
//                 isReadOnly: isPaymentInfoReadOnly,
//                 controller: _cardNumberController,
//                 imageAssetLocation: 'assets/icons/credit_card.png',
//                 isCreditCard: true,
//                 title: 'Credit Card',
//                 hintText: allProfile[0].cardNumber == null
//                     ? 'Add credit card number here...'
//                     : '**** **** **** ****',
//                 keyboardType: TextInputType.number,
//               ),
//               SizedBox(height: 11 * screenHeight),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   ProfileItem(
//                     isHintText: allProfile[0].expiryDate == null ? true : false,
//                     maxLength: 4,
//                     isReadOnly: isPaymentInfoReadOnly,
//                     controller: _expiryDateController,
//                     isTitlePresent: false,
//                     title: '',
//                     hintText:
//                     allProfile[0].expiryDate == null ? 'MM/YY' : '**/**',
//                     keyboardType: TextInputType.datetime,
//                     isWidthMax: false,
//                     width: 174,
//                   ),
//                   SizedBox(width: 20 * screenWidth),
//                   ProfileItem(
//                     isHintText: allProfile[0].cvv == null ? true : false,
//                     isReadOnly: isPaymentInfoReadOnly,
//                     controller: _cvvController,
//                     isInputObscured: true,
//                     isTitlePresent: false,
//                     title: '',
//                     hintText: allProfile[0].cvv == null ? 'CVV/CVC' : '****',
//                     keyboardType: TextInputType.number,
//                     isWidthMax: false,
//                     width: 116,
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20 * screenHeight),
//               ProfileItem(
//                 isHintText: allProfile[0].payPalAddress == null ? true : false,
//                 isReadOnly: isPaymentInfoReadOnly,
//                 controller: _payPalController,
//                 title: 'PayPal',
//                 hintText: allProfile[0].payPalAddress == null
//                     ? 'Enter PayPal address...'
//                     : allProfile[0].payPalAddress,
//                 keyboardType: TextInputType.emailAddress,
//                 isCreditCard: true,
//                 imageAssetLocation: 'assets/icons/pay_pal.png',
//               ),
//               SizedBox(height: 10 * screenHeight),
//               isPaymentInfoReadOnly
//                   ? SizedBox()
//                   : Center(
//                 child: Padding(
//                   padding: EdgeInsets.only(top: screenHeight * 20.0),
//                   child: GestureDetector(
//                     onTap: updatePaymentInfo,
//                     child: Container(
//                       height: 53 * screenHeight,
//                       width: 310 * screenWidth,
//                       decoration: BoxDecoration(
//                         color: primary,
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Center(
//                         child: Text(
//                           'Save',
//                           style: TextStyle(
//                             color: white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 5 * screenHeight),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

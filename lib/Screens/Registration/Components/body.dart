// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handyman_app/Screens/Home/home_screen.dart';
import 'package:handyman_app/Screens/Login/login_screen.dart';
import 'package:handyman_app/Screens/Registration/Sub%20Screen/Registration%20Continuation/registration_continuation_screen.dart';
import '../../../Components/credentials_button.dart';
import '../../../Components/credentials_container.dart';
import '../../../Components/social_media_container.dart';
import '../../../Models/users.dart';
import '../../../Services/read_data.dart';
import '../../../constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../wrapper.dart';
import '../../Dashboard/Handymen/handymen_dashboard_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _numberController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _numberController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            insetPadding: EdgeInsets.symmetric(horizontal: 150 * screenWidth),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                (Platform.isIOS)
                    ? const CupertinoActivityIndicator(
                        radius: 20,
                        color: Color(0xff32B5BD),
                      )
                    : const CircularProgressIndicator(
                        color: Color(0xff32B5BD),
                      ),
              ],
            ),
          );
        },
      );

      if (confirmPassword() &&
          firstName() &&
          email() &&
          number()) {
        print("Selected Role: $roleValue");
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),

        );

        userId = FirebaseAuth.instance.currentUser!.uid;
        loggedInUserId = userId;

        await ReadData().getFCMToken(false);

        addDetails(
          _firstNameController.text.trim(),
          _lastNameController.text.trim(),
          _emailController.text.trim(),
          0 + int.parse(_numberController.text),
          roleValue,
          userId,
          fcmToken,
        );

        addProfileDetails(
          userId, //userId
          '', //momoType
          null, //card number
          null, //expiry date
          null, //cvv
          null, //paypal
          '', //street name
          '', //town
          '', //region
          '', //house number
        );

        allUsers.clear();
        getUserData();

        final userData = await getUserData();

        // If user data is not found, show an error message
        if (userData == 'User Not Found.') {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(AppLocalizations.of(context)!.tj),
                content: Text(AppLocalizations.of(context)!.tk),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(AppLocalizations.of(context)!.tl),
                  ),
                ],
              );
            },
          );
          return;
        }

        await Future.delayed(Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Wrapper(),
            ),
          );
        });
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      print(e.code.toString());

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(
                e.code.toString().toUpperCase(),
                style: TextStyle(color: primary, fontSize: 17),
              ),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            content: Text(
              AppLocalizations.of(context)!.tm,
              style: TextStyle(
                height: 1.4,
                fontSize: 16,
                color: black,
              ),
            ),
          );
        },
      );
    } catch (err) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'Error'.toUpperCase(),
                style: TextStyle(color: primary, fontSize: 17),
              ),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            content: Text(
              AppLocalizations.of(context)!.tm,
              style: TextStyle(
                height: 1.4,
                fontSize: 16,
                color: black,
              ),
            ),
          );
        },
      );
    }
  }

  bool confirmPassword() {
    if (_passwordController.text.trim() ==
            _confirmPasswordController.text.trim() &&
        _passwordController.text.trim() != null &&
        _confirmPasswordController.text.trim() != null) {
      return true;
    } else {
      setState(() {
        registerPasswordError = true;
      });
      print(AppLocalizations.of(context)!.tn);
      return false;
    }
  }

  bool firstName() {
    if (_firstNameController.text.isNotEmpty) {
      setState(() {
        registerFirstNameError = false;
      });
      return true;
    } else {
      print(AppLocalizations.of(context)!.to);
      setState(() {
        registerFirstNameError = true;
      });
      return false;
    }
  }



  bool email() {
    if (_emailController.text.isNotEmpty) {
      setState(() {
        registerEmailError = false;
      });
      return true;
    } else {
      print(AppLocalizations.of(context)!.tq);
      setState(() {
        registerEmailError = true;
      });
      return false;
    }
  }

  bool number() {
    if (_numberController.text.isNotEmpty) {
      setState(() {
        registerNumberError = false;
      });
      return true;
    } else {
      print(AppLocalizations.of(context)!.tr);
      setState(() {
        registerNumberError = true;
      });
      return false;
    }
  }

  Future addDetails(String firstName, String lastName, String email, int number,
      String role, String id, String token) async {
    FirebaseFirestore.instance.collection('users').add(
      {
        'First Name': firstName,
        'Last Name': lastName,
        'Email Address': email,
        'Mobile Number': number,
        'Role': role,
        'User ID': id,
        'Pic': '',
        'FCM Token': token,
      },
    );
  }

  Future addProfileDetails(
      String id,
      String? momoType,
      int? cardNumber,
      String? expiryDate,
      int? cvv,
      String? payPal,
      String? streetName,
      String? town,
      String? region,
      String? houseNum) async {
    //creating a collection in firestore database called 'Profile'
    await FirebaseFirestore.instance.collection('profile').add({
      'User ID': id,
      'Mobile Money Type': selectedMomoOptions,
      'Credit Card Information': {
        'Card Number': cardNumber,
        'Expiry Date': expiryDate,
        'CVV': cvv,
      },
      'PayPal': payPal,
      'Address Information': {
        'Street Name': streetName,
        'Town': town,
        'Region': region,
        'House Number': houseNum,
      },
    });
  }

  late final String userId;

  Future getUserData() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('User ID', isEqualTo: userId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final userData = querySnapshot.docs.first.data();
      final userLogin = UserData(
        pic: userData['Pic'],
        userId: userData['User ID'],
        firstName: userData['First Name'],
        lastName: userData['Last Name'],
        number: userData['Mobile Number'],
        email: userData['Email Address'],
        role: userData['Role'],
      );
      allUsers.add(userLogin);
      return userData;
    } else {
      return 'User Not Found.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 19.5,
            vertical: 15 * screenHeight,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Padding(
                padding: EdgeInsets.only(left: 90 * screenWidth),
                child: Text(
                  AppLocalizations.of(context)!.ti,
                  style: TextStyle(
                    color: black,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CredentialsContainer(
                    inputFormatter: [
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z\\s]")),
                      LengthLimitingTextInputFormatter(15),
                    ],
                    errorTextField: registerFirstNameError,
                    controller: _firstNameController,
                    title: AppLocalizations.of(context)!.tt,
                    hintText: AppLocalizations.of(context)!.tu,
                    isPassword: false,
                    iconText: 'N',

                  ),
                  registerFirstNameError
                      ? SizedBox(width: 12 * screenWidth)
                      : SizedBox(),
                  registerFirstNameError
                      ? Text(
                    AppLocalizations.of(context)!.tv,
                    style: TextStyle(
                      color: complementaryRed,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                      : SizedBox(),
                  SizedBox(width: 20 * screenHeight),

                  // Add more CredentialsContainer widgets as needed
                ],
              ),
            ),
              SizedBox(height: 20 * screenHeight),
              CredentialsContainer(
                inputFormatter: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@.]')),

                  LengthLimitingTextInputFormatter(
                      30) // Deny specific characters
                ],
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                title: AppLocalizations.of(context)!.tz,
                hintText: AppLocalizations.of(context)!.aa,
                isPassword: false,
                errorTextField: registerEmailError,
              ),
              registerEmailError
                  ? SizedBox(height: 12 * screenHeight)
                  : SizedBox(),
              registerEmailError
                  ? Text(
                AppLocalizations.of(context)!.ab,
                      style: TextStyle(
                        color: complementaryRed,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : SizedBox(),
              SizedBox(height: 20 * screenHeight),
              CredentialsContainer(
                inputFormatter: [
                  LengthLimitingTextInputFormatter(
                      40) // Deny specific characters
                ],
                controller: _passwordController,
                title: AppLocalizations.of(context)!.ac,
                hintText: AppLocalizations.of(context)!.ad,
                isPassword: true,
                isPasswordVisible: true,
                errorTextField: registerPasswordError,
              ),
              registerPasswordError
                  ? SizedBox(height: 12 * screenHeight)
                  : SizedBox(),
              registerPasswordError
                  ? Text(
                AppLocalizations.of(context)!.ae,
                      style: TextStyle(
                        color: complementaryRed,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : SizedBox(),
              SizedBox(height: 20 * screenHeight),
              CredentialsContainer(
                inputFormatter: [
                  LengthLimitingTextInputFormatter(
                      40) // Deny specific characters
                ],
                controller: _confirmPasswordController,
                title: AppLocalizations.of(context)!.af,
                hintText: AppLocalizations.of(context)!.ag,
                isPassword: true,
                isPasswordVisible: true,
                errorTextField: registerPasswordError,
              ),
              registerPasswordError
                  ? SizedBox(height: 12 * screenHeight)
                  : SizedBox(),
              registerPasswordError
                  ? Text(
                AppLocalizations.of(context)!.ah,
                      style: TextStyle(
                        color: complementaryRed,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : SizedBox(),
              SizedBox(height: 20 * screenHeight),
              CredentialsContainer(
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                  // numberMask,
                ],
                keyboardType: TextInputType.number,
                controller: _numberController,
                title: AppLocalizations.of(context)!.ai,
                iconText: '#',
                hintText: AppLocalizations.of(context)!.aj,
                isPassword: false,
                errorTextField: registerNumberError,
              ),
              registerNumberError
                  ? SizedBox(height: 12 * screenHeight)
                  : SizedBox(),
              registerNumberError
                  ? Text(
                AppLocalizations.of(context)!.ak,
                      style: TextStyle(
                        color: complementaryRed,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : SizedBox(),
              SizedBox(height: 20 * screenHeight),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 2.5),
                    child: Text(
                      AppLocalizations.of(context)!.al,
                      style: TextStyle(
                        color: black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 12 * screenHeight),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 53 * screenHeight,
                        width: 51 * screenWidth,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: appointmentTimeColor, width: 1),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/icons/role_icon.png',
                            height: 15.23 * screenHeight,
                            width: 21.75 * screenWidth,
                            color: semiGrey,
                          ),
                        ),
                      ),
                      SizedBox(width: 12 * screenWidth),
                      Row(
                        children: [
                          Radio(
                            value: 'Regular Customer',
                            groupValue: roleValue,
                            onChanged: (value) {
                              setState(() {
                                roleValue = value.toString();
                              });
                            },
                          ),
                          Text(
                            'Requester',
                            style: TextStyle(
                              fontSize: 16,
                              color: black,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                          Radio(
                            value: 'Professional Handyman',
                            groupValue: roleValue,
                            onChanged: (value) {
                              setState(() {
                                roleValue = value.toString();

                              });
                            },
                          ),

                          Text(
                            'Worker',
                            style: TextStyle(
                              fontSize: 16,
                              color: black,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),

              SizedBox(height: 20 * screenHeight),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isTermsAndCondAgreed = !isTermsAndCondAgreed;
                        });
                      },
                      child: Container(
                        height: 20 * screenHeight,
                        width: 20 * screenWidth,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(2),
                          border:
                              Border.all(color: appointmentTimeColor, width: 1),
                        ),
                        alignment: Alignment.center,
                        child: isTermsAndCondAgreed
                            ? Container(
                                height: 16 * screenHeight,
                                width: 16 * screenWidth,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  // borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                    child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                )),
                              )
                            : SizedBox(),
                      ),
                    ),
                    SizedBox(width: 12 * screenWidth),
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 2.0),
                      child: Text(
                        AppLocalizations.of(context)!.an,
                        style: TextStyle(
                          height: 1.2,
                          color: black,
                          fontSize: 15,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40 * screenHeight),
              isTermsAndCondAgreed
                  ? CredentialsButton(buttonText: AppLocalizations.of(context)!.signup, screen: signUp)
                  : Container(
                      height: 53 * screenHeight,
                      width: 351 * screenWidth,
                      decoration: BoxDecoration(
                        color: sectionColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.signup,
                          style: TextStyle(
                            color: grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 30 * screenHeight),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context)!.aq,
                    style: TextStyle(
                      color: semiGrey,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 5 * screenWidth),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)!.signin,
                      style: TextStyle(
                        color: primary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

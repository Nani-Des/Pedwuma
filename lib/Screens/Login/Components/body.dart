// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handyman_app/Screens/Forgot%20Password/forgot_password_screen.dart';
import 'package:handyman_app/Screens/Home/home_screen.dart';
import 'package:handyman_app/Screens/Registration/registration_screen.dart';
import 'package:handyman_app/Services/read_data.dart';
import 'package:handyman_app/constants.dart';
import 'package:handyman_app/wrapper.dart';
import '../../../Components/credentials_button.dart';
import '../../../Components/credentials_container.dart';
import '../../../Components/social_media_container.dart';
import '../../../Models/users.dart';
import '../../Home/Components/body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ReadData readData = ReadData();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future signIn() async {
    try {
      //display alert dialog box with loading indicator
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
      //user sign in with credentials
      if (_emailController.text.trim() != 'admin@admin.com') {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } else {
        setState(() {
          loginTextFieldError = true;
        });
        throw Exception();
      }

      //obtaining current user's UID from firebase
      userId = FirebaseAuth.instance.currentUser!.uid;
      loggedInUserId = userId;
      //getting current user's data into in-app variable for easy access
      getUserData();
      await readData.getUserJobApplicationIDS();
      await ReadData().getFCMToken(true);

      final userData = await getUserData();

      // If user data is not found, show an error message
      if (userData == 'User Not Found.') {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.tj),
              content: Text(AppLocalizations.of(context)!.bg),
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

      //Delaying opening next route(screen) in order to load data needed on next screen
      await Future.delayed(Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Wrapper(),
          ),
        );
      });

      setState(() {
        loginTextFieldError = false;
      });
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'wrong-password') {
        setState(() {
          loginTextFieldError = true;
        });
      }

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
              '${AppLocalizations.of(context)!.tm}',
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
                AppLocalizations.of(context)!.err.toUpperCase(),
                style: TextStyle(color: primary, fontSize: 17),
              ),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            content: Text(
              '${AppLocalizations.of(context)!.tm}',
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

  late final String userId;

  Future getUserData() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('User ID', isEqualTo: userId)
        .get()
        .timeout(
      Duration(seconds: 30), // Set your desired timeout duration
      onTimeout: () {
        throw TimeoutException(AppLocalizations.of(context)!.ba);
      },
    );

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
      return AppLocalizations.of(context)!.tj;
    }
  }

  @override
  void initState() {
    allUsers.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 19.5,
            vertical: 35 * screenHeight,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 35 * screenHeight),
              Padding(
                padding: EdgeInsets.only(left: 5.5 * screenWidth),
                child: Text(
                  AppLocalizations.of(context)!.bb,
                  style: TextStyle(
                    color: black,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 6.5 * screenWidth,
                    top: 15 * screenHeight,
                    bottom: 54 * screenHeight),
                child: Text(
                  AppLocalizations.of(context)!.bc,
                  style: TextStyle(
                    color: semiGrey,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              CredentialsContainer(
                inputFormatter: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@.]')),

                  LengthLimitingTextInputFormatter(
                      30) // Deny specific characters
                ],
                errorTextField: loginTextFieldError,
                controller: _emailController,
                title: AppLocalizations.of(context)!.tz,
                hintText: AppLocalizations.of(context)!.aa,
                isPassword: false,
                keyboardType: TextInputType.emailAddress,
                isPasswordVisible: false,
              ),
              SizedBox(height: 20 * screenHeight),
              CredentialsContainer(
                inputFormatter: [
                  LengthLimitingTextInputFormatter(
                      40) // Deny specific characters
                ],
                errorTextField: loginTextFieldError,
                controller: _passwordController,
                title: AppLocalizations.of(context)!.ac,
                hintText: AppLocalizations.of(context)!.ad,
                isPassword: true,
                isPasswordVisible: true,
              ),
              loginTextFieldError
                  ? SizedBox(height: 20 * screenHeight)
                  : SizedBox(),
              loginTextFieldError
                  ? Center(
                      child: Text(
                        AppLocalizations.of(context)!.bd,
                        style: TextStyle(
                          color: complementaryRed,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : SizedBox(),
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
                          isRememberMeClicked = !isRememberMeClicked;
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
                        child: isRememberMeClicked
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
                        AppLocalizations.of(context)!.be,
                        style: TextStyle(
                          height: 1.2,
                          color: black,
                          fontSize: 15,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.frgt,
                        style: TextStyle(
                          color: complementaryRed,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 40 * screenHeight),
              CredentialsButton(
                screen: signIn,
              ),
              SizedBox(height: 30 * screenHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 1.5 * screenHeight,
                    width: 60 * screenWidth,
                    color: grey,
                  ),
                  SizedBox(width: 24 * screenWidth),

                  SizedBox(width: 24 * screenWidth),
                  Container(
                    height: 1.5 * screenHeight,
                    width: 60 * screenWidth,
                    color: grey,
                  ),
                ],
              ),
              SizedBox(height: 30 * screenHeight),

              loginTextFieldError
                  ? SizedBox(height: 65 * screenHeight)
                  : SizedBox(height: 89 * screenHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context)!.bf,
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
                          builder: (context) => RegistrationScreen(),
                        ),
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)!.signup,
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

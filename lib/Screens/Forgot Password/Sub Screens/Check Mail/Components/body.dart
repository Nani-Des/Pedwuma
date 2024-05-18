import 'package:flutter/material.dart';
import 'package:handyman_app/Components/credentials_button.dart';
import 'package:handyman_app/Screens/Forgot%20Password/Sub%20Screens/Create%20New%20Password/create_new_password_screen.dart';
import 'package:handyman_app/Screens/Forgot%20Password/forgot_password_screen.dart';
import 'package:handyman_app/Screens/Login/login_screen.dart';

import '../../../../../constants.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 50 * screenHeight),
          Padding(
            padding: EdgeInsets.only(left: 95 * screenWidth),
            child: Image.asset(
              'assets/images/check_mail.png',
              height: 190 * screenHeight,
              width: 231.49 * screenWidth,
            ),
          ),
          SizedBox(height: 22 * screenHeight),
          Center(
            child: Text(
              'Check your mail',
              style: TextStyle(
                color: black,
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 15 * screenHeight),
          Center(
            child: Container(
              width: 254 * screenWidth,
              child: Text(
                'We have sent password recovery instructions to your email.',
                style: TextStyle(
                  height: 1.45,
                  color: semiGrey,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 50 * screenHeight),
          Center(
            child: CredentialsButton(
              screen: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              buttonText: 'Skip',
            ),
          ),
          SizedBox(height: 22 * screenHeight),
          Center(
            child: CredentialsButton(
              screen: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              buttonText: "Skip, I'm done Confirming",
              isConfirmLater: true,
            ),
          ),
          SizedBox(height: 95 * screenHeight),
          Center(
            child: Text(
              'Did not receive the email? Check your spam folder.',
              style: TextStyle(
                height: 1.45,
                color: semiGrey,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'or',
                style: TextStyle(
                  height: 1.45,
                  color: semiGrey,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(width: 4 * screenWidth),
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
                  'try another email address',
                  style: TextStyle(
                    height: 1.45,
                    color: primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

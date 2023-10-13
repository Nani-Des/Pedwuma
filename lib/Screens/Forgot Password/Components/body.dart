import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handyman_app/Components/credentials_button.dart';
import 'package:handyman_app/Components/credentials_container.dart';
import 'package:handyman_app/Screens/Forgot%20Password/Sub%20Screens/Check%20Mail/check_mail_screen.dart';
import 'package:handyman_app/constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future forgotPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckMailScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        forgotPasswordEmailError = true;
      });
      print(e.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 19.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 15 * screenHeight),
            Center(
              child: Image.asset(
                'assets/images/forgot_password.png',
                height: 161.44 * screenHeight,
                width: 242.77 * screenWidth,
              ),
            ),
            SizedBox(height: 37.56 * screenHeight),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 5.5),
              child: Text(
                'Forgot Password',
                style: TextStyle(
                  color: black,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 15 * screenHeight),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 7.5),
              child: Container(
                width: 335 * screenWidth,
                child: Text(
                  'Don’t worry it happen. Reset your password by '
                  'entering your email below and follow the '
                  'instructions sent by mail to your account.',
                  style: TextStyle(
                    height: 1.45,
                    color: semiGrey,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 49 * screenHeight),
            CredentialsContainer(
              inputFormatter: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@.]')),

                LengthLimitingTextInputFormatter(30) // Deny specific characters
              ],
              errorTextField: forgotPasswordEmailError,
              controller: _emailController,
              title: 'Email Address',
              hintText: 'Enter your email address',
            ),
            forgotPasswordEmailError
                ? SizedBox(height: 12 * screenHeight)
                : SizedBox(),
            forgotPasswordEmailError
                ? Text(
                    'Email Address field cannot be empty',
                    style: TextStyle(
                      color: complementaryRed,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : SizedBox(),
            SizedBox(height: 92 * screenHeight),
            Center(
              child: CredentialsButton(
                screen: forgotPassword,
                buttonText: 'Send Instructions',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

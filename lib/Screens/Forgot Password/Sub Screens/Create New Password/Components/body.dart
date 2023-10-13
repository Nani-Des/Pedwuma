import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handyman_app/Components/credentials_button.dart';
import 'package:handyman_app/Screens/Login/login_screen.dart';

import '../../../../../Components/credentials_container.dart';
import '../../../../../constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 19.5 * screenWidth),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 15 * screenHeight),
            Center(
              child: Image.asset(
                'assets/images/new_password.png',
                height: 161.44 * screenHeight,
                width: 242.77 * screenWidth,
              ),
            ),
            SizedBox(height: 37.56 * screenHeight),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 5.5),
              child: Text(
                'Create New Password',
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
                width: 310 * screenWidth,
                child: Text(
                  'Your new password must be different from previously used passwords',
                  style: TextStyle(
                    height: 1.45,
                    color: semiGrey,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 21 * screenHeight),
            CredentialsContainer(
              inputFormatter: [
                LengthLimitingTextInputFormatter(40) // Deny specific characters
              ],
              controller: _passwordController,
              isPassword: true,
              title: 'Password',
              hintText: 'Enter your password',
            ),
            SizedBox(height: 8 * screenHeight),
            Text(
              'Must be at least 8 characters long',
              style: TextStyle(
                height: 1.45,
                color: semiGrey,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20 * screenHeight),
            CredentialsContainer(
              inputFormatter: [
                LengthLimitingTextInputFormatter(40) // Deny specific characters
              ],
              controller: _confirmPasswordController,
              isPassword: true,
              title: 'Confirm Password',
              hintText: 'Enter your password',
            ),
            SizedBox(height: 8 * screenHeight),
            Text(
              'Both passwords must match',
              style: TextStyle(
                height: 1.45,
                color: semiGrey,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 58 * screenHeight),
            // CredentialsButton(
            //   screen: LoginScreen(),
            //   buttonText: 'Reset Password',
            // )
          ],
        ),
      ),
    );
  }
}

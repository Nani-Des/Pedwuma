// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:handyman_app/Screens/Login/login_screen.dart';
import 'package:handyman_app/Screens/Public/public_screen.dart';
import 'package:handyman_app/Screens/Registration/registration_screen.dart';

import '../../../Components/appointment_button.dart';
import '../../../constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Home/home_screen.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        FirstScreen(),
        SecondScreen(),
        ThirdScreen(),
      ],
    );
  }
}


class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 37.0,
                right: 23 * screenWidth,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context)!.welcometo,
                        style: TextStyle(
                          color: black,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 6 * screenWidth),
                      Text(
                        'Pedwuma',
                        style: TextStyle(
                          color: primary,
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 13.0,
                      top: 13 * screenHeight,
                    ),

                  ),
                ],
              ),
            ),
            SizedBox(height: 50 * screenHeight),
            Container(
              height: 300 * screenHeight,
              width: 381 * screenWidth,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/welcome_pic.png'),
                  )),
            ),
            SizedBox(height: 48 * screenHeight),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 324 * screenWidth,
                    child: Column(
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context)!.tb,
                          style: TextStyle(
                            color: black,
                            fontSize: 17,
                            fontFamily: 'Junge',
                            height: 1.3,
                          ),
                          textAlign: TextAlign.center,
                        ),


                      ],
                    ),
                  ),
                  SizedBox(height: 150 * screenHeight),
                  Text(
                    'Pedwuma',
                    style: TextStyle(
                      color: primary,
                      fontSize: 17,
                    ),
                    textAlign: TextAlign.center,
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 37.0,
                right: 23 * screenWidth,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context)!.fz,
                        style: TextStyle(
                          color: black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 6 * screenWidth),

                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 13.0,
                      top: 13 * screenHeight,
                    ),

                  ),
                ],
              ),
            ),
            SizedBox(height: 50 * screenHeight),
            Container(
              height: 300 * screenHeight,
              width: 381 * screenWidth,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/welcome_pic1.png'),
                  )),
            ),
            SizedBox(height: 48 * screenHeight),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 324 * screenWidth,
                    child: Column(
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context)!.handyworker,
                          style: TextStyle(
                            color: black,
                            fontSize: 17,
                            fontFamily: 'Junge',
                            height: 1.3,
                          ),
                          textAlign: TextAlign.center,
                        ),


                      ],
                    ),
                  ),
                  SizedBox(height: 150 * screenHeight),
                  Text(
                    'Pedwuma',
                    style: TextStyle(
                      color: primary,
                      fontSize: 17,
                    ),
                    textAlign: TextAlign.center,
                  ),

                ],
              ),
            ),
            SizedBox(height: 110 * screenHeight),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     AppointmentButton(
            //       isWelcomeScreen: true,
            //       text: AppLocalizations.of(context)!.login,
            //       containerColor: primary,
            //       textColor: white,
            //       press: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => LoginScreen(),
            //           ),
            //         );
            //       },
            //     ),
            //     SizedBox(width: 3 * screenWidth),
            //     AppointmentButton(
            //       isWelcomeScreen: true,
            //       text: AppLocalizations.of(context)!.reg,
            //       containerColor: sectionColor,
            //       textColor: textGreyColor,
            //       press: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => RegistrationScreen(),
            //           ),
            //         );
            //       },
            //     ),
            //   ],
            // ),


          ],
        ),
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 37.0,
                right: 23 * screenWidth,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context)!.ga,
                        style: TextStyle(
                          color: black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 6 * screenWidth),

                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 13.0,
                      top: 13 * screenHeight,
                    ),

                  ),
                ],
              ),
            ),
            SizedBox(height: 50 * screenHeight),
            Container(
              height: 300 * screenHeight,
              width: 381 * screenWidth,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/welcome_pic2.png'),
                  )),
            ),
            SizedBox(height: 48 * screenHeight),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 324 * screenWidth,
                    child: Column(
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context)!.gb,
                          style: TextStyle(
                            color: black,
                            fontSize: 17,
                            fontFamily: 'Junge',
                            height: 1.3,
                          ),
                          textAlign: TextAlign.center,
                        ),


                      ],
                    ),
                  ),
                  SizedBox(height: 35 * screenHeight),
                  Text(
                    AppLocalizations.of(context)!.gc,
                    style: TextStyle(
                      color: primary,
                      fontSize: 17,
                    ),
                    textAlign: TextAlign.center,
                  ),

                ],
              ),
            ),
            SizedBox(height: 80 * screenHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    // Handle the skip action
                    // You can add navigation or any other action here
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PublicScreen())
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.gl,
                          style: TextStyle(
                            color: Colors.black, // Set your desired color
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(width: 8),
                        // Animated skip icon (You can replace this with your desired skip icon)
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.black, // Set your desired color
                          size: 24,

                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}



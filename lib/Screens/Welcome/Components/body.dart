// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:handyman_app/Screens/Login/login_screen.dart';
import 'package:handyman_app/Screens/Registration/registration_screen.dart';

import '../../../Components/appointment_button.dart';
import '../../../constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

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
                    child: Text(
                      AppLocalizations.of(context)!.ta,
                      style: TextStyle(
                        color: black,
                        fontSize: 20,
                        fontFamily: 'Junge',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50 * screenHeight),
            Container(
              height: 243.41 * screenHeight,
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
                        Text(
                          AppLocalizations.of(context)!.tc,
                          style: TextStyle(
                            color: black,
                            fontSize: 17,
                            fontFamily: 'Junge',
                            height: 1.3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          AppLocalizations.of(context)!.td,
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
                  SizedBox(height: 2 * screenHeight),
                  Text(
                    AppLocalizations.of(context)!.te,
                    style: TextStyle(
                      color: primary,
                      fontSize: 17,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    width: 324 * screenWidth,
                    child: Column(
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context)!.tf,
                          style: TextStyle(
                            color: black,
                            fontSize: 17,
                            fontFamily: 'Junge',
                            height: 1.3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          AppLocalizations.of(context)!.tg,
                          style: TextStyle(
                            color: black,
                            fontSize: 17,
                            fontFamily: 'Junge',
                            height: 1.3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          AppLocalizations.of(context)!.th,
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
                ],
              ),
            ),
            SizedBox(height: 85 * screenHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppointmentButton(
                  isWelcomeScreen: true,
                  text: AppLocalizations.of(context)!.login,
                  containerColor: primary,
                  textColor: white,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(width: 3 * screenWidth),
                AppointmentButton(
                  isWelcomeScreen: true,
                  text: AppLocalizations.of(context)!.reg,
                  containerColor: sectionColor,
                  textColor: textGreyColor,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistrationScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

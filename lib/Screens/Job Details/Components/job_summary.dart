import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handyman_app/Screens/Job%20Application/job_application_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../Services/read_data.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';
import '../../Registration/registration_screen.dart';

class JobSummary extends StatelessWidget {
  const JobSummary({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 226 * screenHeight,
      ),
      width: 390 * screenWidth,
      decoration: BoxDecoration(
        color: sectionColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
      ),
      padding: EdgeInsets.only(
        top: 31 * screenHeight,
        bottom: 13 * screenHeight,
        right: 8 * screenWidth,
        left: 20 * screenWidth,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: SizedBox(
              width: 350 * screenWidth,
              child: Text(
                allJobItemList[0].jobService+' ' + AppLocalizations.of(context)!.gk,
                style: TextStyle(
                  color: black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.visible,
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 23 * screenHeight),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      height: 92 * screenHeight,
                      width: 86 * screenWidth,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(10),
                        border: allJobItemList[0].pic == ''
                            ? null
                            : Border.all(color: appointmentTimeColor, width: 1),
                        image: DecorationImage(
                            image: NetworkImage(allJobItemList[0].pic),
                            fit: BoxFit.cover),
                      ),
                      child: allJobItemList[0].pic == ''
                          ? Center(
                              child: Icon(
                              Icons.person,
                              color: grey,
                              size: 42,
                            ))
                          : null),
                  SizedBox(height: 12 * screenHeight),
                  Icon(Icons.verified_rounded, color: green),
                ],
              ),
              SizedBox(width: 10.35 * screenWidth),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 147 * screenWidth,
                    child: Text(
                      allJobItemList[0].fullName,
                      style: TextStyle(
                        color: black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 15 * screenHeight),
                  Text(
                    '149.5' + ' km',
                    style: TextStyle(
                      color: black,
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'away from you',
                    style: TextStyle(
                      color: black,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '\₵' +
                        allJobItemList[0].charge.toString() +
                        '/' +
                        allJobItemList[0].chargeRate,
                    style: TextStyle(
                      color: primary,
                      fontSize: 21.64,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 23 * screenHeight),
                  GestureDetector(
                    onTap: () async {
                      // Check if the user is logged in
                      User? user = FirebaseAuth.instance.currentUser;

                      if (user != null) {
                        // User is logged in, navigate to the JobApplicationScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const JobApplicationScreen(),
                          ),
                        );
                      } else {
                        // User is not logged in, show a login prompt or navigate to the login screen.
                        // For example, you can navigate to the login screen.
                        Alert(
                          context: context,
                          type: AlertType.info,
                          title: AppLocalizations.of(context)!.gd,
                          style: AlertStyle(
                              titleStyle: TextStyle(fontWeight: FontWeight.w800),
                              descStyle:
                              TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
                          desc: AppLocalizations.of(context)!.gg,
                          buttons: [

                            DialogButton(
                              onPressed: () => Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => LoginScreen())),
                              color: Color(0xFF0D47A1),
                              border: Border.all(color: Color(0xffe5f3ff)),
                              child: Text(
                                AppLocalizations.of(context)!.ge,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'DM-Sans',
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ).show(); // Replace '/login' with your actual login route
                      }
                    },
                    child: Container(
                      height: 47 * screenHeight,
                      width: 109 * screenWidth,
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(7),
                        boxShadow: [
                          BoxShadow(
                            color: black.withOpacity(0.25),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.gh,
                          style: TextStyle(
                            color: white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          Center(
            child: Container(
              height: 4 * screenHeight,
              width: 59 * screenWidth,
              decoration: BoxDecoration(
                  color: grey, borderRadius: BorderRadius.circular(6)),
            ),
          )
        ],
      ),
    );
  }
}

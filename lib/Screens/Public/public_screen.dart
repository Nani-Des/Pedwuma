import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handyman_app/Components/default_back_button.dart';
import 'package:handyman_app/Components/drawer_header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:handyman_app/Screens/Job%20Upload/Customer/customer_job_upload_screen.dart';
import 'package:handyman_app/Screens/Login/login_screen.dart';
import 'package:handyman_app/Screens/Notifications/notification_screen.dart'; // Import the screen
import 'package:handyman_app/constants.dart';
import '../Public/Components/body.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../Registration/registration_screen.dart';




class PublicScreen extends StatefulWidget {
  const PublicScreen({Key? key}) : super(key: key);

  @override
  State<PublicScreen> createState() =>
      _PublicScreenState();
}

class _PublicScreenState extends State<PublicScreen> {
  bool isDrawerClicked = false;
  bool showSpeechBubble = true; // Set to false to hide the speech bubble

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Builder(
        //   builder: (context) => InkWell(
        //     onTap: () {
        //       Scaffold.of(context).openDrawer();
        //     },
        //     borderRadius: BorderRadius.circular(4),
        //     splashColor: sectionColor,
        //     child: Stack(
        //       alignment: Alignment.center,
        //       children: [
        //         // Image assets
        //         Padding(
        //           padding: EdgeInsets.only(left: screenWidth * 14.0),
        //           child: Image.asset(
        //             'assets/icons/menu.png',
        //             color: primary,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        elevation: 0.0,
        backgroundColor: white,
        actions: [
          // Speech bubble external to the container holding Image.asset
          if (showSpeechBubble)
            GestureDetector(
              onTap: () {
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
                    ),

                    DialogButton(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => RegistrationScreen())),
                      color: Color(0xFF0D47A1),
                      border: Border.all(color: Color(0xffe5f3ff)),
                      child: Text(
                        AppLocalizations.of(context)!.gf,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'DM-Sans',
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ).show();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 2),
                  height: 10,
                   decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        AppLocalizations.of(context)!.gj,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          Container(
            margin: EdgeInsets.only(right: screenWidth * 20),
            height: screenHeight * 40,
            width: screenWidth * 40,
            decoration: BoxDecoration(
              border: Border.all(color: sectionColor, width: 1),
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imageUrl),
              ),
            ),
            child: imageUrl == ''
                ? Center(child: Icon(Icons.person, color: grey))
                : null,
          ),
        ],
      ),
           backgroundColor: Colors.white,
      body: Body(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handyman_app/Components/default_back_button.dart';
import 'package:handyman_app/Components/drawer_header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
              child: Container(
                margin: EdgeInsets.only(left: screenWidth * 10, top: screenHeight * 20, bottom: screenHeight * 20), // Adjust the margin as needed
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue, // You can change the color
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
                child: Text(
                  AppLocalizations.of(context)!.gj,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
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

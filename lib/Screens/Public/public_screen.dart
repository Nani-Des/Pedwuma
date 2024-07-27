import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handyman_app/Components/default_back_button.dart';
import 'package:handyman_app/Components/drawer_header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:handyman_app/Screens/Job%20Upload/Customer/customer_job_upload_screen.dart';
import 'package:handyman_app/Screens/Login/login_screen.dart';
import 'package:handyman_app/Screens/Notifications/notification_screen.dart';
import 'package:handyman_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Admin/admin_panel.dart';
import '../Public/Components/body.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../Registration/registration_screen.dart';

class PublicScreen extends StatefulWidget {
  const PublicScreen({Key? key}) : super(key: key);

  @override
  State<PublicScreen> createState() => _PublicScreenState();
}

class _PublicScreenState extends State<PublicScreen> {
  bool isDrawerClicked = false;
  bool showSpeechBubble = true;

  Future<void> _showPinDialog(BuildContext context) async {
    final TextEditingController pinController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter PIN'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: pinController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter 4-digit PIN',
                  ),
                  maxLength: 4,
                  obscureText: true,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Verify'),
              onPressed: () async {
                String enteredPin = pinController.text;
                if (await _verifyPin(enteredPin)) {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminPanel()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Invalid PIN')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> _verifyPin(String enteredPin) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      await FirebaseFirestore.instance
          .collection('Admin')
          .doc('Pass')
          .get();
      String storedPin = documentSnapshot.data()?['Pass'] ?? '';
      return enteredPin == storedPin;
    } catch (e) {
      print('Error verifying PIN: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: white,
        actions: [
          if (showSpeechBubble)
            GestureDetector(
              onTap: () {
                Alert(
                  context: context,
                  type: AlertType.info,
                  title: AppLocalizations.of(context)!.gd,
                  style: AlertStyle(
                      titleStyle: TextStyle(fontWeight: FontWeight.w800),
                      descStyle: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 18)),
                  desc: AppLocalizations.of(context)!.gg,
                  buttons: [
                    DialogButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen())),
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
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegistrationScreen())),
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
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
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
            child: PopupMenuButton<int>(
              icon: CircleAvatar(
                radius: screenWidth * 20,
                backgroundImage: NetworkImage(imageUrl),
                backgroundColor: sectionColor,
                child: imageUrl == ''
                    ? Center(child: Icon(Icons.person, color: grey))
                    : null,
              ),
              onSelected: (value) {
                if (value == 1) {
                  _showPinDialog(context);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(Icons.admin_panel_settings, color: primary),
                      SizedBox(width: 8),
                      Text("Admin"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Body(),
    );
  }
}

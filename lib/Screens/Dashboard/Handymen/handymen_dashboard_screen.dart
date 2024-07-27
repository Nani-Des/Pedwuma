import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handyman_app/Components/default_back_button.dart';
import 'package:handyman_app/Components/drawer_header.dart';
import 'package:handyman_app/Screens/Dashboard/Handymen/Components/body.dart';
import 'package:handyman_app/Screens/Notifications/notification_screen.dart'; // Import the screen
import 'package:handyman_app/constants.dart';
import '../../../Admin/admin_panel.dart';
import '../../Home/home_screen.dart';
import '../../Job Upload/Customer/customer_job_upload_screen.dart';
import '../../Profile/Profile - Customer/profile_customer.dart';
import 'Components/customer_drawer.dart';



class HandymanDashboardScreen extends StatefulWidget {
  const HandymanDashboardScreen({Key? key}) : super(key: key);

  @override
  State<HandymanDashboardScreen> createState() =>
      _HandymanDashboardScreenState();
}

class _HandymanDashboardScreenState extends State<HandymanDashboardScreen> {
  bool isDrawerClicked = false;
  bool showSpeechBubble = true; // Set to false to hide the speech bubble

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
        leading: Builder(
          builder: (context) => InkWell(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            borderRadius: BorderRadius.circular(4),
            splashColor: sectionColor,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Image assets
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 14.0),
                  child: Image.asset(
                    'assets/icons/menu.png',
                    color: primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        elevation: 0.0,
        backgroundColor: white,
        actions: [
          // Speech bubble external to the container holding Image.asset
          if (showSpeechBubble)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomerJobUploadScreen()),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 2),
                  height: 15,
                   decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        'Post a Job',
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
          GestureDetector(
            onTap: () {
              // Navigate to the profile screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileCustomer()),
              );
            },
            child: Container(
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
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Body(),
      drawerEnableOpenDragGesture: true,
      drawer: CustomerDrawer(),
    );
  }
}
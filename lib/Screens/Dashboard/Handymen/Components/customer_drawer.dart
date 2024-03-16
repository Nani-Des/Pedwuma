// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handyman_app/Screens/Bookings/customer_bookings_screen.dart';
import 'package:handyman_app/Screens/Chat/Sub%20Screen/chat.dart';
import 'package:handyman_app/Screens/Favourites/Customer/customer_favourite_screen.dart';
import 'package:handyman_app/Screens/Job%20Upload/Customer/customer_job_upload_screen.dart';
import 'package:handyman_app/Screens/Location/location_screen.dart';
import 'package:handyman_app/Screens/Login/login_screen.dart';
import '../../../../Components/drawer_header.dart';
import '../../../../Components/drawer_tile.dart';
import '../../../../Services/account_deletion.dart';
import '../../../../Services/read_data.dart';
import '../../../../constants.dart';
import '../../../../help.dart';
import '../../../Profile/Profile - Customer/profile_customer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomerDrawer extends StatelessWidget {
  const CustomerDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future signOut() async {
      await FirebaseAuth.instance.signOut();
      allUsers.clear();
      imageUrl = '';

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
          (route) => false);
    }

    return SafeArea(
      child: Drawer(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topRight: Radius.circular(5),
          bottomRight: Radius.circular(5),
        )),
        elevation: 0.0,
        width: 287 * screenWidth,
        backgroundColor: white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 8 * screenHeight),
            DrawerHeaderCreated(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 20.0, vertical: 21 * screenHeight),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.arrow_right, color: black, size: 35),
                  SizedBox(width: 17 * screenWidth),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 7.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 190 * screenWidth,
                          child: Text(
                            allUsers[0].firstName + ' ' + allUsers[0].lastName,
                            style: TextStyle(
                              color: black,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                        SizedBox(height: 9 * screenHeight),
                        SizedBox(
                          width: 190 * screenWidth,
                          child: Text(
                            allUsers[0].email,
                            style: TextStyle(
                              color: black,
                              fontSize: 15,
                              fontWeight: FontWeight.w100,
                            ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 23.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 1 * screenHeight,
                      width: screenWidth * 233,
                      color: grey,
                    ),
                  ),
                  SizedBox(height: 27 * screenHeight),

                  DrawerTile(
                    title: AppLocalizations.of(context)!.profile,
                    icon: Icons.person,
                    screen: ProfileCustomer(),
                  ),
                  SizedBox(height: 15 * screenHeight),
                  DrawerTile(
                    title: "Bookings",
                    icon: Icons.bookmark,
                    screen: CustomerBookingsScreen(),
                  ),
                  SizedBox(height: 20 * screenHeight),
                  Center(
                    child: Container(
                      height: 1 * screenHeight,
                      width: screenWidth * 233,
                      color: grey,
                    ),
                  ),
                  SizedBox(height: 20 * screenHeight),
                  DrawerTile(
                    title: AppLocalizations.of(context)!.jobupload,
                    icon: Icons.cloud_upload,
                    screen: CustomerJobUploadScreen(),

                  ),
                  SizedBox(height: 20 * screenHeight),
                  DrawerTile(
                    title: AppLocalizations.of(context)!.fav,
                    icon: Icons.favorite,
                    screen: CustomerFavouritesScreen(),
                  ),


                  SizedBox(height: 20 * screenHeight),


                  Center(
                    child: Container(
                      height: 1 * screenHeight,
                      width: screenWidth * 233,
                      color: grey,
                    ),
                  ),
                  SizedBox(height: 27 * screenHeight),
                  DrawerTile(
                    title: AppLocalizations.of(context)!.chats,
                    icon: Icons.textsms_rounded,
                    screen: ChatMessaging(),
                  ),
                  SizedBox(height: 20 * screenHeight),
                  DrawerTile(
                    title: AppLocalizations.of(context)!.bs,
                    icon: Icons.help_rounded,
                    screen: HelpSupportPage()
                  ),
                  SizedBox(height: 27 * screenHeight),


                  Center(
                    child: Container(
                      height: 1 * screenHeight,
                      width: screenWidth * 233,
                      color: grey,
                    ),
                  ),
                  SizedBox(height: 27 * screenHeight),

                  GestureDetector(
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirm Deletion"),
                            content: Text("Are you sure you want to delete your account? This action cannot be undone."),
                            actions: <Widget>[
                              TextButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                              ),
                              TextButton(
                                child: Text("Delete"),
                                onPressed: () {
                                  // Call the account deletion service
                                  AccountDeletionService().deleteAccount(context);
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                              ),
                            ],
                          );
                        },
                      );


                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.delete_forever, color: primary),
                        SizedBox(width: 22 * screenWidth),
                        Text(
                          "Delete Account",
                          style: TextStyle(
                            color: black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 27 * screenHeight),




                  GestureDetector(
                    onTap: signOut,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.logout, color: primary),
                        SizedBox(width: 22 * screenWidth),
                        Text(
                          AppLocalizations.of(context)!.logout,
                          style: TextStyle(
                            color: black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20 * screenHeight),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

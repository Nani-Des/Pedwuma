import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handyman_app/Screens/My%20Jobs/my_jobs_screen.dart';
import 'package:handyman_app/Screens/Profile/Profile%20-%20Handyman/profile_handyman.dart';
import 'package:handyman_app/Screens/Settings/settings_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../../Components/drawer_header.dart';
import '../../../../Components/drawer_tile.dart';
import '../../../../Services/account_deletion.dart';
import '../../../../Services/read_data.dart';
import '../../../../constants.dart';
import '../../../../help.dart';
import '../../../Chat/Sub Screen/chat.dart';
import '../../../Favourites/Handyman/handyman_favourites_screen.dart';
import '../../../Home/home_screen.dart';
import '../../../Job Upload/Handyman/handyman_job_upload_screen.dart';
import '../../../Location/location_screen.dart';
import '../../../Login/login_screen.dart';
import '../../../Notifications/notification_screen.dart';
import '../../Handymen/handymen_dashboard_screen.dart';

class HandymanDrawer extends StatelessWidget {
  const HandymanDrawer({
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
        elevation: 0,
        width: 287 * screenWidth,
        backgroundColor: white,
        child: ListView(
          // Wrap the content in a ListView
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
                    title: AppLocalizations.of(context)!.home,
                    icon: Icons.question_mark,
                    screen: HandymanDashboardScreen(),
                  ),
                  SizedBox(height: 20 * screenHeight),
                  DrawerTile(
                    title: AppLocalizations.of(context)!.profile,
                    icon: Icons.person,
                    screen: HandymanProfileScreen(),
                  ),
                  SizedBox(height: 20 * screenHeight),
                  DrawerTile(
                    title: AppLocalizations.of(context)!.myjobs,
                    icon: Icons.work_history_rounded,
                    screen: MyJobsScreen(),
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
                  DrawerTile(
                    title: AppLocalizations.of(context)!.profileupload,
                    icon: Icons.cloud_upload,
                    screen: HandymanJobUploadScreen(),
                  ),
                  SizedBox(height: 20 * screenHeight),
                  DrawerTile(
                    title: AppLocalizations.of(context)!.fav,
                    icon: Icons.favorite,
                    screen: HandymanFavouritesScreen(),
                  ),
                  SizedBox(height: 20 * screenHeight),

                  SizedBox(height: 27 * screenHeight),
                  Center(
                    child: Container(
                      height: 1 * screenHeight,
                      width: screenWidth * 233,
                      color: grey,
                    ),
                  ),
                  SizedBox(height: 27 * screenHeight),
                  // DrawerTile(
                  //   title: 'Contact Us',
                  //   icon: Icons.call,
                  //   screen: NotificationScreen(),
                  // ),
                  DrawerTile(
                    title: AppLocalizations.of(context)!.chats,
                    icon: Icons.textsms_rounded,
                    screen: ChatMessaging(),
                  ),
                  SizedBox(height: 20 * screenHeight),
                  DrawerTile(
                    title: AppLocalizations.of(context)!.bs,
                    icon: Icons.help_rounded,
                    screen: HelpSupportPage(),
                  ),
                  SizedBox(height: 27 * screenHeight),

                  Center(
                    child: Container(
                      height: 1 * screenHeight,
                      width: screenWidth * 233,
                      color: grey,
                    ),
                  ),
                  SizedBox(height: 20 * screenHeight),
                  GestureDetector(
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirm Deletion"),
                            content: Text("Are you sure you want to delete your account?  This action cannot be undone."),
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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handyman_app/Screens/Dashboard/Handymen/handymen_dashboard_screen.dart';
import 'package:handyman_app/Screens/Profile/Profile%20-%20Handyman/profile_handyman.dart';
import 'package:handyman_app/constants.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: SvgPicture.asset(
            'assets/icons/repair_illustration.svg',
            height: 203 * screenHeight,
            width: 215.56 * screenWidth,
          ),
        ),
        SizedBox(height: 23 * screenHeight),
        Text(
          'Successful!',
          style: TextStyle(
              color: white, fontSize: 30, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 10 * screenHeight),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 47.0 * screenWidth),
          child: Text(
            'An offer has been sent to the handyman. You will be notified '
            'of the status of the offer. \nThank You.',
            style: TextStyle(color: white, fontSize: 17),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 86 * screenHeight),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HandymanDashboardScreen(),
                ));
          },
          child: Container(
            height: 64 * screenHeight,
            width: 335 * screenWidth,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 2, color: white),
            ),
            alignment: Alignment.center,
            child: Container(
              height: 44 * screenHeight,
              width: 315 * screenWidth,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  'Great!',
                  style: TextStyle(
                      color: primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

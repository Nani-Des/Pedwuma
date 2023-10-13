import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:handyman_app/constants.dart';
import 'package:page_transition/page_transition.dart';

import 'Sub Screens/splash_screen_cont.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splashIconSize: 700,
        splash: Image.asset('assets/images/app_logo.png'),
        nextScreen: SplashScreenCont(),
        splashTransition: SplashTransition.scaleTransition,
        backgroundColor: white,
        pageTransitionType: PageTransitionType.fade,
        animationDuration: Duration(seconds: 2),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../constants.dart';

class HomeScreenTabs1 extends StatelessWidget {
  final String title;
  final Widget screen;
  bool isButtonClickable;
  HomeScreenTabs1({
    Key? key,
    required this.title,
    required this.screen,
    this.isButtonClickable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: isButtonClickable
          ? () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => screen,
          ),
        );
      }
          : () {},
      child: Container(
        height: size.height * 0.1032,
        width: size.width * 0.3958,
        decoration: BoxDecoration(
          // Use BoxDecoration with image property for the background image
          image: DecorationImage(
            image: AssetImage('assets/images/home4.jpg'), // Adjust the image path
            fit: BoxFit.fill, // You can use BoxFit.fill if you want to stretch the image
          ),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: isButtonClickable
                  ? primary.withOpacity(0.10)
                  : semiGrey.withOpacity(0.08),
              spreadRadius: 8.0,
              blurRadius: 10,
              offset: Offset(2, 3),
            ),
          ],
        ),
        child: Center(
          child: Container(
            // Wrap the Text widget with a Container
            color: Colors.white, // Set the background color to white
            padding: EdgeInsets.all(6.0), // Add padding for better visibility
            child: Text(
              title,
              style: TextStyle(
                color: isButtonClickable ? primary : grey,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

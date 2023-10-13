import 'package:flutter/material.dart';

import '../constants.dart';

class UploadButton extends StatelessWidget {
  IconData icon;
  VoidCallback screen;
  String buttonText;
  bool isIconPresent;
  UploadButton(
      {Key? key,
      this.icon = Icons.check_circle_rounded,
      this.buttonText = 'Proceed',
      this.isIconPresent = false,
      required this.screen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: screen,
        child: Container(
          height: 56 * screenHeight,
          width: 390 * screenWidth,
          decoration: BoxDecoration(
            color: primary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
            border: Border.all(color: white, width: 0.5),
          ),
          child: isIconPresent
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                      Icon(icon, color: white),
                      SizedBox(width: 9 * screenWidth),
                      Text(
                        buttonText,
                        style: TextStyle(
                          color: white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ])
              : Center(
                  child: Text(
                  buttonText,
                  style: TextStyle(
                    color: white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                )),
        ),
      ),
    );
  }
}

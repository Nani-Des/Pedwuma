import 'package:flutter/material.dart';

import '../constants.dart';

class ContactPersonnelButton extends StatelessWidget {
  final bool call;
  final VoidCallback press;
  const ContactPersonnelButton({
    Key? key,
    required this.call,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: (call == true)
          ? green.withOpacity(0.5)
          : Color(0xff361BDE).withOpacity(0.3),
      highlightColor: Colors.transparent,
      onTap: press,
      borderRadius: BorderRadius.circular(7),
      child: Ink(
        height: 53 * screenHeight,
        width: 168.05 * screenWidth,
        decoration: BoxDecoration(
          color: call == true ? Color(0xffC5FFD1) : Color(0xffD3DAFF),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Padding(
          padding: call == true
              ? EdgeInsets.only(right: screenWidth * 10.0)
              : EdgeInsets.only(right: screenWidth * 4.0),
          child: call == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/icons/call.png'),
                    SizedBox(width: 6 * screenWidth),
                    Text(
                      'Call',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff1BAE0F),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/icons/message.png'),
                    SizedBox(width: 6 * screenWidth),
                    Text(
                      'Message',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff361BDE),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

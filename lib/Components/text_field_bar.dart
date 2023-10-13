import 'package:flutter/material.dart';

import '../constants.dart';

class TextfieldBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback screen;
  const TextfieldBar({
    Key? key,
    required this.screen,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 73 * screenHeight,
        width: 390 * screenWidth,
        decoration: BoxDecoration(color: sectionColor, boxShadow: [
          BoxShadow(
            color: appointmentTimeColor.withOpacity(0.1),
            offset: Offset(0, -2),
            blurRadius: 17,
            spreadRadius: 0,
          )
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 13 * screenWidth),
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.emoji_emotions_rounded,
                color: primary,
              ),
            ),
            SizedBox(width: 9 * screenWidth),
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.add,
                color: primary,
              ),
            ),
            SizedBox(width: 12 * screenWidth),
            Container(
              height: screenHeight * 50.62,
              width: 255 * screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: white,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 10.0),
                child: TextField(
                  controller: controller,
                  cursorHeight: 22,
                  autofocus: false,
                  autocorrect: true,
                  enableSuggestions: true,
                  clipBehavior: Clip.antiAlias,
                  cursorColor: black.withOpacity(0.6),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  minLines: 1,
                  decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      hintText: 'Enter message ...',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w200,
                        color: black,
                        fontSize: 16,
                      )),
                  style: TextStyle(
                    overflow: TextOverflow.clip,
                    color: black,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            SizedBox(width: 6 * screenWidth),
            IconButton(
                onPressed: screen,
                icon: Icon(
                  Icons.send_outlined,
                  color: primary,
                  size: 25,
                ))
          ],
        ),
      ),
    );
  }
}

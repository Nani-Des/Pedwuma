import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

class NoteTextArea extends StatelessWidget {
  final TextEditingController controller;
  num width;
  bool isNoteEditable;
  NoteTextArea({
    Key? key,
    required this.controller,
    this.isNoteEditable = true,
    this.width = 11,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: screenWidth * width),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16 * screenWidth,
          // vertical: 5 * screenHeight,
        ),
        width: 322 * screenWidth,
        constraints: BoxConstraints(minHeight: 90 * screenHeight),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: white,
          border: Border.all(color: chatTimeColor, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              enabled: isNoteEditable,
              controller: controller,
              inputFormatters: [
                LengthLimitingTextInputFormatter(150),
              ],
              cursorHeight: 22,
              autofocus: false,
              autocorrect: true,
              enableSuggestions: true,
              cursorColor: black.withOpacity(0.6),
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              minLines: 4,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: 'Add notes here...',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w200,
                  color: black,
                  fontSize: 14,
                ),
              ),
              style: TextStyle(
                  overflow: TextOverflow.visible,
                  color: black,
                  fontSize: 17,
                  height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}

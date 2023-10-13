import 'package:flutter/material.dart';

import '../constants.dart';

class AddressBars extends StatefulWidget {
  final String heading;
  final String text;
  bool isFullAddressBar;
  AddressBars({
    Key? key,
    required this.heading,
    required this.text,
    this.isFullAddressBar = false,
  }) : super(key: key);

  @override
  State<AddressBars> createState() => _AddressBarsState();
}

class _AddressBarsState extends State<AddressBars> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: screenWidth * 11.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isAddressBarClicked = !isAddressBarClicked;
          });
        },
        child: Container(
          padding: EdgeInsets.only(
              left: 14 * screenWidth, right: 26.91 * screenWidth),
          // height: 34 * screenHeight,
          constraints: BoxConstraints(
            minHeight: 34 * screenHeight,
            maxHeight: double.infinity,
          ),
          width: 322 * screenWidth,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(9),
            border: Border.all(
                color: chatTimeColor, width: 1, style: BorderStyle.solid),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 8.5 * screenHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.heading + ':',
                    style: TextStyle(
                      color: chatTimeColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: widget.isFullAddressBar
                        ? EdgeInsets.only(right: screenWidth * 35.0)
                        : EdgeInsets.only(right: screenWidth * 8.0),
                    child: Text(
                      widget.text,
                      style: TextStyle(
                        color: black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  widget.isFullAddressBar
                      ? Image.asset(
                          'assets/icons/plus.png',
                          color: isAddressBarClicked ? primary : black,
                        )
                      : Image.asset(
                          'assets/icons/forward_arrow_small.png',
                          color: isAddressBarClicked ? primary : black,
                        ),
                ],
              ),
              isAddressBarClicked
                  ? Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextField(
                            textCapitalization: TextCapitalization.sentences,
                            cursorHeight: 22,
                            autofocus: true,
                            autocorrect: true,
                            enableSuggestions: true,
                            clipBehavior: Clip.antiAlias,
                            cursorColor: black.withOpacity(0.6),
                            decoration: InputDecoration(
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintText: 'Send message ...',
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
                        ],
                      ),
                    )
                  : SizedBox(height: 0, width: 0),
            ],
          ),
        ),
      ),
    );
  }
}

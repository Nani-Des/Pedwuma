import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handyman_app/Components/personnel_rating_summary.dart';

import '../constants.dart';

class ProfileItem extends StatelessWidget {
  final List<TextInputFormatter> inputFormatter;
  TextEditingController? controller;
  String imageAssetLocation;
  final String title;
  final String hintText;
  TextInputType keyboardType;
  bool isWidthMax;
  bool isOverallRating;
  bool isCreditCard;
  bool isTitlePresent;
  bool isInputObscured;
  bool isReadOnly;
  bool isHintText;
  num width;
  int maxLength;
  ProfileItem({
    Key? key,
    required this.title,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.isWidthMax = true,
    this.isOverallRating = false,
    this.isCreditCard = false,
    this.isTitlePresent = true,
    this.isReadOnly = true,
    this.isInputObscured = false,
    this.isHintText = true,
    this.maxLength = 1000,
    this.imageAssetLocation = 'assets/icons/credit_card.png',
    this.width = 0,
    required this.inputFormatter,
    TextEditingController? controller,
  })  : controller = controller ?? TextEditingController(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        isTitlePresent
            ? Padding(
                padding: EdgeInsets.only(left: screenWidth * 11.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: black,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : SizedBox(height: 0, width: 0),
        SizedBox(height: 6 * screenHeight),
        Container(
          height: 49 * screenHeight,
          width: isWidthMax ? 310 * screenWidth : width * screenWidth,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(7),
          ),
          //TODO: Remove underline under text when typing when WiFi come back and center cursor
          child: isOverallRating
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    PersonnelRatingSummary(rating: ratingHintText.toString()),
                  ],
                )
              : TextField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: controller,
                  readOnly: isReadOnly,
                  obscureText: isInputObscured ? true : false,
                  obscuringCharacter: "*",
                  maxLength: isInputObscured ? 4 : maxLength,
                  keyboardType: keyboardType,
                  cursorHeight: 18 * screenHeight,
                  enableSuggestions: true,
                  autocorrect: true,
                  cursorColor: black,
                  textAlign: isWidthMax ? TextAlign.left : TextAlign.center,
                  decoration: InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    hintText: hintText,
                    suffixIcon: isCreditCard
                        ? Image.asset(
                            imageAssetLocation,
                            height: 19.44 * screenHeight,
                            width: 25 * screenWidth,
                          )
                        : null,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: black,
                      fontWeight:
                          isHintText ? FontWeight.w200 : FontWeight.w400,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 15 * screenWidth,
                        vertical: 15 * screenHeight),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: black,
                    fontSize: 16,
                    overflow: TextOverflow.clip,
                  ),
                  inputFormatters: inputFormatter,
                ),
        ),
      ],
    );
  }
}

class ProfileAddressItem extends StatelessWidget {
  final List<TextInputFormatter> inputFormatter;
  String imageAssetLocation;
  final String title;
  final String hintText;
  TextInputType keyboardType;
  bool isWidthMax;
  bool isOverallRating;
  bool isCreditCard;
  bool isTitlePresent;
  bool isInputObscured;
  num width;
  final textEditingController;
  ProfileAddressItem({
    Key? key,
    required this.title,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.isWidthMax = true,
    this.isOverallRating = false,
    this.isCreditCard = false,
    this.isTitlePresent = true,
    this.isInputObscured = false,
    this.imageAssetLocation = 'assets/icons/credit_card.png',
    this.width = 0,
    this.textEditingController,
    required this.inputFormatter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 1.5),
          child: Text(
            title,
            style: TextStyle(
              color: primary,
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(height: 7 * screenHeight),
        Container(
          height: 49 * screenHeight,
          width: isWidthMax ? 275 * screenWidth : width * screenWidth,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: appointmentTimeColor, width: 1),
          ),
          child: TextField(
            inputFormatters: inputFormatter,
            textAlignVertical: TextAlignVertical.center,
            enableSuggestions: true,
            // autocorrect: true,
            obscureText: isInputObscured ? true : false,
            obscuringCharacter: "*",
            maxLength: isInputObscured ? 4 : null,
            keyboardType: keyboardType,
            cursorHeight: 25 * screenHeight,
            cursorColor: black,
            controller: textEditingController,
            textAlign: isWidthMax ? TextAlign.left : TextAlign.center,
            decoration: InputDecoration(
              counterText: '',
              border: InputBorder.none,
              hintText: hintText,
              suffixIcon: isCreditCard
                  ? Image.asset(
                      imageAssetLocation,
                      height: 19.44 * screenHeight,
                      width: 25 * screenWidth,
                    )
                  : null,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 15 * screenWidth, vertical: 15 * screenHeight),
            ),
            textCapitalization: TextCapitalization.sentences,
            style: TextStyle(
              decoration: TextDecoration.none,
              color: black,
              fontSize: 16,
              overflow: TextOverflow.clip,
            ),
          ),
        ),
      ],
    );
  }
}

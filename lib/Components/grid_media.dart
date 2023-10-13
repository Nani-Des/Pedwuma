import 'package:flutter/material.dart';

import '../constants.dart';

class GridMedia extends StatelessWidget {
  final String mediaUrl;
  const GridMedia({
    Key? key,
    required this.mediaUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: 12 * screenWidth, bottom: 11 * screenHeight),
      child: Container(
        height: 180 * screenHeight,
        width: 178 * screenWidth,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: primary.withOpacity(0.1), width: 2),
        ),
        alignment: Alignment.center,
        child: Container(
          height: 167 * screenHeight,
          width: 159.11 * screenWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                mediaUrl,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

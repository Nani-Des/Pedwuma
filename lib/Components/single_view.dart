import 'package:flutter/material.dart';

import '../constants.dart';

class SingleMedia extends StatelessWidget {
  final String mediaUrl;
  const SingleMedia({
    Key? key,
    required this.mediaUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300 * screenHeight,
        width: 325 * screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(mediaUrl),
          ),
        ),
      ),
    );
  }
}

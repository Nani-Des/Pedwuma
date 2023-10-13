import 'package:flutter/material.dart';

import '../constants.dart';

class HomeButtons extends StatelessWidget {
  final String title;
  final VoidCallback press;
  const HomeButtons({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        height: size.height * 0.0585,
        width: size.width * 0.3208,
        decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: white, fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../constants.dart';

class SearchBarItem extends StatelessWidget {
  final VoidCallback onSearchTap;
  final String hintText;
  const SearchBarItem({
    Key? key,
    required this.hintText,
    required this.onSearchTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onSearchTap,
        child: Container(
          height: screenHeight * 53,
          width: 355 * screenWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xffEBF6F9),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: screenWidth * 20),
              Image.asset('assets/icons/search.png'),
              SizedBox(width: screenWidth * 20),
              Text(
                hintText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

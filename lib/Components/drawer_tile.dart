import 'package:flutter/material.dart';

import '../constants.dart';

class DrawerTile extends StatelessWidget {
  final Widget screen;
  final String title;
  final IconData icon;
  const DrawerTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.screen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => screen,
            ));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(icon, color: primary),
          SizedBox(width: 22 * screenWidth),
          Text(
            title,
            style: TextStyle(
              color: black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}

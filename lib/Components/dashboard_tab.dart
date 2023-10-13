import 'package:flutter/material.dart';

import '../constants.dart';

class DashboardTab extends StatelessWidget {
  final int index;
  final int selectedTabIndex;
  final String text;
  final Function onTabSelected;
  const DashboardTab({
    Key? key,
    required this.text,
    required this.index,
    required this.selectedTabIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTabSelected = index == selectedTabIndex;
    return GestureDetector(
      onTap: () {
        if (!isTabSelected) {
          onTabSelected(index);
        }
      },
      child: Container(
        constraints: BoxConstraints(minWidth: 112 * screenWidth),
        height: 48 * screenHeight,
        padding: EdgeInsets.symmetric(horizontal: 28 * screenWidth),
        decoration: BoxDecoration(
          color: isTabSelected ? primary : sectionColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 170 * screenWidth),
            child: Text(
              text,
              style: TextStyle(
                color: isTabSelected ? white : black,
                fontWeight: isTabSelected ? FontWeight.w700 : FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}

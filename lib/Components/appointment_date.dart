import 'package:flutter/material.dart';

import '../constants.dart';

int appointmentDateIndex = 0;

class AppointmentDate extends StatelessWidget {
  final Function onDaySelected;
  final int selectedDay;
  final int index;
  final String day;
  final String date;
  const AppointmentDate({
    Key? key,
    required this.day,
    required this.date,
    required this.index,
    required this.onDaySelected,
    required this.selectedDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDateSelected = selectedDay == index;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          day,
          style: TextStyle(
              color: textGreyColor, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 11),
        GestureDetector(
          onTap: () {
            appointmentDateIndex = index;
            if (!isDateSelected) {
              onDaySelected(index);
            }
          },
          child: Container(
            height: 38 * screenHeight,
            width: 38 * screenWidth,
            decoration: BoxDecoration(
              color: isDateSelected ? primary : white,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Center(
              child: Text(
                date,
                style: TextStyle(
                  color: isDateSelected ? white : black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

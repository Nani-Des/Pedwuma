import 'package:flutter/material.dart';

import '../constants.dart';

int appointmentTimeIndex = 0;

class AppointmentStaticTime extends StatelessWidget {
  final int selectedTime;
  final int index;
  final String time;
  final Function onTimeSelected;
  const AppointmentStaticTime({
    Key? key,
    required this.time,
    required this.index,
    required this.selectedTime,
    required this.onTimeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTimeSelected = index == selectedTime;

    return GestureDetector(
      onTap: () {
        appointmentTimeIndex = index;
        if (!isTimeSelected) {
          onTimeSelected(index);
        }
      },
      child: Container(
        height: 34 * screenHeight,
        width: 96 * screenWidth,
        decoration: BoxDecoration(
            color: isTimeSelected ? primary : white,
            borderRadius: BorderRadius.circular(9),
            border: isTimeSelected
                ? null
                : Border.all(color: chatTimeColor, width: 1)),
        child: Center(
          child: Text(
            time,
            style: TextStyle(
              color: isTimeSelected ? white : black,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

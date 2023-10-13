import 'package:flutter/material.dart';

import '../constants.dart';
import 'appointment_date.dart';
import 'appointment_tab_row.dart';

class ScheduleDayTab extends StatefulWidget {
  const ScheduleDayTab({
    Key? key,
  }) : super(key: key);

  @override
  State<ScheduleDayTab> createState() => _ScheduleDayTabState();
}

int selectedDay = 0;
final List<DateTime> dates = [];

//TODO: FIND A WAY TO LIMIT IT TO THE DEADLINE DAY SET BY THE CUSTOMER
class _ScheduleDayTabState extends State<ScheduleDayTab> {
  void onDaySelected(int index) {
    setState(() {
      selectedDay = index;
    });
  }

  String getWeekdayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final currentWeekday = currentDate.weekday;

    for (int i = currentWeekday; i <= 20; i++) {
      dates.add(currentDate.add(Duration(days: i - currentWeekday)));
    }
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20 * screenWidth,
          vertical: 10 * screenHeight,
        ),
        height: 159 * screenHeight,
        width: 383 * screenWidth,
        decoration: BoxDecoration(
          color: sectionColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppointmentTabRow(tabTitle: 'Schedule Day', isCustomVisible: false),
            SizedBox(height: 16 * screenHeight),
            Flexible(
              child: Center(
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final date = dates[index];
                    final weekday = getWeekdayName(date.weekday);
                    return AppointmentDate(
                      selectedDay: selectedDay,
                      onDaySelected: onDaySelected,
                      date: date.day.toString(),
                      day: weekday,
                      index: index,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 12 * screenWidth);
                  },
                  itemCount: 10,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

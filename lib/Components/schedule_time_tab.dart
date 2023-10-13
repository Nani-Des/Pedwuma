import 'package:flutter/material.dart';

import '../constants.dart';
import 'appointment_static_time.dart';
import 'appointment_tab_row.dart';

class ScheduleTimeTab extends StatefulWidget {
  const ScheduleTimeTab({
    Key? key,
  }) : super(key: key);

  @override
  State<ScheduleTimeTab> createState() => _ScheduleTimeTabState();
}

int selectedTime = 0;

class _ScheduleTimeTabState extends State<ScheduleTimeTab> {
  void onTimeSelected(int index) {
    setState(() {
      selectedTime = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20 * screenWidth,
          vertical: 19 * screenHeight,
        ),
        height: 172 * screenHeight,
        width: 383 * screenWidth,
        decoration: BoxDecoration(
          color: sectionColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppointmentTabRow(
                tabTitle: 'Schedule Time',
                onCustomTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((time) {
                    setState(() {
                      if (time!.hour > 11) {
                        jobApplicationTime =
                            '${(time.hour - 12) > 9 ? (time.hour - 12) : (time.hour - 12) == 0 ? '12' : time.hour - 12}:${time.minute > 9 ? time.minute : '0${time.minute}'} PM';
                      } else {
                        jobApplicationTime =
                            '${time.hour > 9 ? time.hour : time.hour == 0 ? '12' : time.hour}:${time.minute > 9 ? time.minute : '0${time.minute}'} AM';
                      }
                      if (timeList.length == 5) {
                        setState(() {
                          onTimeSelected(5);
                          timeList.add(jobApplicationTime);
                        });
                      } else {
                        setState(() {
                          onTimeSelected(5);
                          timeList[5] = jobApplicationTime;
                        });
                      }
                    });
                  });
                }),
            SizedBox(height: 16 * screenHeight),
            Flexible(
              child: GridView.builder(
                padding: EdgeInsets.only(left: 11 * screenWidth),
                itemCount: timeList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return AppointmentStaticTime(
                    time: timeList[index],
                    index: index,
                    selectedTime: selectedTime,
                    onTimeSelected: onTimeSelected,
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 17 * screenWidth,
                    crossAxisSpacing: 12 * screenHeight,
                    mainAxisExtent: 96 * screenWidth,
                    crossAxisCount: 2),
              ),
            ),
            SizedBox(height: 10 * screenHeight),
          ],
        ),
      ),
    );
  }
}

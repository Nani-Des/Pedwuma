import 'package:flutter/material.dart';
import 'package:handyman_app/Components/schedule_time_tab.dart';
import 'package:handyman_app/Screens/Job%20Application/Components/application_portfolio_tab.dart';
import 'package:handyman_app/Screens/Job%20Application/Components/body.dart';

import '../../Components/default_back_button.dart';
import '../../Components/schedule_day_tab.dart';
import '../../constants.dart';

class JobApplicationScreen extends StatefulWidget {
  const JobApplicationScreen({Key? key}) : super(key: key);

  @override
  State<JobApplicationScreen> createState() => _JobApplicationScreenState();
}

class _JobApplicationScreenState extends State<JobApplicationScreen> {
  @override
  void initState() {
    if (timeList.length > 5) {
      timeList.removeAt(5);
    }
    selectedDay = 0;
    selectedTime = 0;
    addressValue = 'Home';
    apppointmentTown = '';
    apppointmentStreet = '';
    apppointmentHouseNum = '';
    apppointmentRegion = '';
    dropdownvalue = 'N/A';
    jobApplicationLinks.clear();
    jobApplicationPortfolioList.clear();
    resultList = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: DefaultBackButton(),
        elevation: 0.0,
        backgroundColor: white,
        title: Text(
          'Job Application',
          style: TextStyle(
            color: black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: white,
      body: Body(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:handyman_app/Screens/Dashboard/Handymen/handymen_dashboard_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Components/default_back_button.dart';
import '../../constants.dart';
import '../Bookings/Components/body.dart';

class CustomerBookingsScreen extends StatelessWidget {
  const CustomerBookingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: DefaultBackButton(
          isNormalBackButton: false,
          screen: HandymanDashboardScreen(),
        ),
        title: Text(
          AppLocalizations.of(context)!.bookings,
          style: TextStyle(
            color: black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: white,
        elevation: 0.0,
      ),
      body: Body(),
      backgroundColor: white,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:handyman_app/Screens/Bookings/customer_bookings_screen.dart';

import '../../../constants.dart';
import '../../Successful/Payment Successful/Components/body.dart';

class PaymentSuccessfulScreen extends StatelessWidget {
  const PaymentSuccessfulScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0.0,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomerBookingsScreen(),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Skip',
                  style: TextStyle(
                      color: white, fontSize: 17, fontWeight: FontWeight.w500),
                ),
                Icon(Icons.arrow_forward_rounded, color: white),
              ],
            ),
          ),
          SizedBox(width: 12 * screenWidth),
        ],
      ),
      backgroundColor: primary,
      body: Body(),
    );
  }
}

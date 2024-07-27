import 'package:flutter/material.dart';
import 'package:handyman_app/Admin/admin_services/user_status.dart'; // Import user status logic

class UserActionsDialog extends StatelessWidget {
  final String userId;

  UserActionsDialog({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'User Actions',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.0),
          buildButton(context, 'Disable', Colors.red),
          SizedBox(height: 8.0),
          buildButton(context, 'Enable', Colors.green), // Added enable button

        ],
      ),
    );
  }

  Widget buildButton(BuildContext context, String text, Color color) {
    return TextButton(
      onPressed: () async {
        Navigator.of(context).pop(); // Close the dialog
        if (text == 'Disable') {
          await disableUser(userId);
        } else if (text == 'Enable') { // Handle enable action
          await enableUser(userId);
        }
      },
      child: Text(
        text,
        style: TextStyle(color: color),
      ),
    );
  }
}

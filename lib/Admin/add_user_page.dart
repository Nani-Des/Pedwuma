import 'package:flutter/material.dart';

class AddUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: Center(
        child: ElevatedButton( // Changed from RaisedButton to ElevatedButton
          onPressed: () {
            _navigateToAddUser(context); // Navigate to add user page
          },
          child: Text('Add User'),
        ),
      ),
    );
  }

  void _navigateToAddUser(BuildContext context) {
    // Implement navigation logic to add user page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddUserForm()),
    );
  }
}

class AddUserForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User Form'),
      ),
      body: Center(
        child: Text('Add user form goes here'),
      ),
    );
  }
}

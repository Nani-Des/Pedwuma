import 'package:flutter/material.dart';
import 'package:handyman_app/Admin/Components/user_actions_dialog.dart';

class UserTile extends StatelessWidget {
  final Map<String, dynamic> user;

  UserTile({required this.user});

  void _showUserActions(BuildContext context) {
    final userId = user.containsKey('User ID') ? user['User ID'] : '';
    showDialog(
      context: context,
      builder: (BuildContext context) => UserActionsDialog(userId: userId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pic = user.containsKey('Pic') ? user['Pic'] : null;
    final firstName = user.containsKey('First Name') ? user['First Name'] : '';
    final lastName = user.containsKey('Last Name') ? user['Last Name'] : '';
    final role = user.containsKey('Role') ? user['Role'] : '';
    final mobileNumber = user.containsKey('Mobile Number') ? user['Mobile Number'] : '';

    return ListTile(
      leading: pic != null ? CircleAvatar(backgroundImage: NetworkImage(pic)) : CircleAvatar(child: Icon(Icons.person)),
      title: Text('$firstName $lastName'),
      subtitle: Text('Role: $role\nMobile: $mobileNumber'),
      onTap: () => _showUserActions(context),
    );
  }
}

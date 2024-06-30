import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handyman_app/Admin/Components/user_tile.dart';
import 'package:handyman_app/constants.dart';

import '../add_user_page.dart';

class UserSearchPage extends StatefulWidget {
  @override
  _UserSearchPageState createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _searchResults = [];

  void _searchUsers(String query) async {
    final results = await FirebaseFirestore.instance
        .collection('users')
        .where('First Name', isGreaterThanOrEqualTo: query)
        .where('First Name', isLessThanOrEqualTo: query + '\uf8ff')
        .get();

    final results2 = await FirebaseFirestore.instance
        .collection('users')
        .where('Last Name', isGreaterThanOrEqualTo: query)
        .where('Last Name', isLessThanOrEqualTo: query + '\uf8ff')
        .get();

    setState(() {
      _searchResults = results.docs + results2.docs;
    });
  }

  void _navigateToAddUser() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AddUserPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Users'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _navigateToAddUser,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by First Name or Last Name',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => _searchUsers(_searchController.text),
                ),
              ),
              onChanged: (query) {
                if (query.isEmpty) {
                  setState(() {
                    _searchResults = [];
                  });
                } else {
                  _searchUsers(query);
                }
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final user = _searchResults[index].data() as Map<String, dynamic>?;

                  if (user == null) {
                    return ListTile(
                      title: Text('Invalid user data'),
                    );
                  }

                  return UserTile(user: user);
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: white,
    );
  }
}

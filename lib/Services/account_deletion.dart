import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:handyman_app/Services/read_data.dart';

import '../Screens/Login/login_screen.dart';
import '../constants.dart';

class AccountDeletionService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> deleteAccount(BuildContext context) async {
    // Get the current user
    User? user = _auth.currentUser;

    if (user != null) {
      try {

        // Retrieve documents where User ID field matches the signed-in user's ID
        QuerySnapshot querySnapshot = await _firestore
            .collection('users')
            .where('User ID', isEqualTo: user.uid)
            .get();

        // Check if there is a match
        if (querySnapshot.docs.isNotEmpty) {
          // Delete user from authentication
          await user.delete();

          // Delete user data from Firestore
          await _firestore.collection('users').doc(querySnapshot.docs.first.id).delete();

          // Delete user-related documents from other collections
          List<String> collections = [
            'Booking Profile',
            'Bookmark',
            'Jobs',
            'Location',
            'Reviews',
            'Services',
            'profile',
          ];

          for (String collection in collections) {
            // Query documents in the collection where UserId field matches the signed-in user's ID
            QuerySnapshot userRelatedDocs = await _firestore
                .collection(collection)
                .where('User ID', isEqualTo: user.uid)
                .get();

            // Delete each document found in the collection
            for (QueryDocumentSnapshot document in userRelatedDocs.docs) {
              await _firestore.collection(collection).doc(document.id).delete();
            }
          }




          await FirebaseAuth.instance.signOut();
          allUsers.clear();
          imageUrl = '';


          print('Account deleted successfully.');
        } else {
          // Handle case where user data is not found
          print('User data not found for the signed-in user.');
        }
      } catch (error) {
        // Handle error as needed
        print('Error deleting account: $error');
      }
    } else {
      // Handle case where no user is signed in
      print('No user is currently signed in.');
    }
  }
}
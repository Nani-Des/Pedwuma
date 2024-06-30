import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> disableUser(String userId) async {
  try {
    // Retrieve the user document with the given userId
    QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('User ID', isEqualTo: userId)
        .get();

    if (userSnapshot.docs.isNotEmpty) {
      // Get the document ID
      String docId = userSnapshot.docs.first.id;

      // Update the user's status to disabled
      await FirebaseFirestore.instance
          .collection('users')
          .doc(docId)
          .update({'status': false});

      print('User with ID $userId has been disabled.');
    } else {
      print('No user found with ID $userId.');
    }
  } catch (e) {
    print('Error disabling user: $e');
  }
}

Future<void> enableUser(String userId) async {
  try {
    // Retrieve the user document with the given userId
    QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('User ID', isEqualTo: userId)
        .get();

    if (userSnapshot.docs.isNotEmpty) {
      // Get the document ID
      String docId = userSnapshot.docs.first.id;

      // Update the user's status to enabled
      await FirebaseFirestore.instance
          .collection('users')
          .doc(docId)
          .update({'status': true});

      print('User with ID $userId has been enabled.');
    } else {
      print('No user found with ID $userId.');
    }
  } catch (e) {
    print('Error enabling user: $e');
  }
}

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'Components/grid_item.dart';
// import 'Components/user_search_page.dart';
//
// class AdminPanel extends StatefulWidget {
//   @override
//   _AdminPanelState createState() => _AdminPanelState();
// }
//
// class _AdminPanelState extends State<AdminPanel> {
//   int userCount = 0;
//   int serviceCount = 0;
//   int jobCount = 0;
//   int applicationCount = 0;
//   int bookingCount = 0;
//   int workerCount = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchCounts();
//   }
//
//   Future<void> _fetchCounts() async {
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//     QuerySnapshot usersSnapshot = await firestore.collection('users').where('status', isEqualTo: true).get();
//     QuerySnapshot servicesSnapshot = await firestore.collection('Services').get();
//     QuerySnapshot jobsSnapshot = await firestore.collection('Jobs').get();
//     QuerySnapshot applicationsSnapshot = await firestore.collection('Applications').get();
//     QuerySnapshot bookingsSnapshot = await firestore.collection('Bookings').get();
//     QuerySnapshot workersSnapshot = await firestore.collection('Booking Profile').get();
//
//     setState(() {
//       userCount = usersSnapshot.docs.length;
//       serviceCount = servicesSnapshot.docs.length;
//       jobCount = jobsSnapshot.docs.length;
//       applicationCount = applicationsSnapshot.docs.length;
//       bookingCount = bookingsSnapshot.docs.length;
//       workerCount = workersSnapshot.docs.length;
//     });
//   }
//
//   void _navigateToUserSearch(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => UserSearchPage()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin Panel'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: GridView.count(
//           crossAxisCount: 2,
//           crossAxisSpacing: 10.0,
//           mainAxisSpacing: 10.0,
//           children: <Widget>[
//             GridItem(
//               title: 'Users',
//               count: userCount,
//               onPressed: () => _navigateToUserSearch(context),
//             ),
//             GridItem(title: 'Services', count: serviceCount, onPressed: () {}),
//             GridItem(title: 'Jobs', count: jobCount, onPressed: () {}),
//             GridItem(title: 'Applications', count: applicationCount, onPressed: () {}),
//             GridItem(title: 'Bookings', count: bookingCount, onPressed: () {}),
//             GridItem(title: 'Worker Profiles', count: workerCount, onPressed: () {}),
//           ],
//         ),
//       ),
//     );
//   }
// }
// //
// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:math' show asin, atan2, cos, pi, sin, sqrt;
//
// class LocationScreena extends StatefulWidget {
//   final LatLng? initialSelectedPostion;
//   const LocationScreena({Key? key, this.initialSelectedPostion})
//       : super(key: key);
//
//   @override
//   State<LocationScreena> createState() => _LocationScreenaState();
// }
//
// class _LocationScreenaState extends State<LocationScreena>
//     with TickerProviderStateMixin {
//   late GoogleMapController mapController;
//   late AnimationController lifter;
//   LatLng selectedPosition = LatLng(6.6745, -1.5716); // Default position
//   Stream<DocumentSnapshot>? _stream;
//   LatLng? currentLocation;
//   var userDocID = '';
//
//   @override
//   void initState() {
//     super.initState();
//
//     lifter = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     );
//
//     lifter.addListener(() {
//       setState(() {});
//     });
//
//     getLocationCoordinates();
//
//     // // Start listening to the stream for location changes
//     // _stream = FirebaseFirestore.instance
//     //     .collection('users')
//     //     .doc(userDocID)
//     //     .snapshots();
//
//     _stream = FirebaseFirestore.instance
//         .collection('Location')
//         .doc('Q4GIG34vEj1XinwDRavP')
//         .snapshots();
//   }
//
//   Future getLocationCoordinates() async {
//     final document = await FirebaseFirestore.instance
//         .collection('Customer/Booking Profile')
//         .where('User ID',
//             isEqualTo: 'user_id gotten from jobid job -> jobUpload ')
//         .get();
//     if (document.docs.isNotEmpty) {
//       final docID = document.docs.single.id;
//       final customerID = document.docs.single.get('User ID');
//
//       final userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .where('User ID', isEqualTo: customerID)
//           .get();
//       userDocID = userDoc.docs.single.id;
//     }
//   }
//
//   Stream getHandymanLoc() {
//     return FirebaseFirestore.instance
//         .collection('Location')
//         .doc('')
//         .snapshots();
//   }
//
//   onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//     if (widget.initialSelectedPostion != null) {
//       mapController.animateCamera(CameraUpdate.newCameraPosition(
//         CameraPosition(target: widget.initialSelectedPostion!, zoom: 18),
//       ));
//     }
//   }
//
//   // Calculate distance between two lat & long points using Haversine formula.
//   //haversine formula is a very accurate way of computing distances between two points on the surface of a sphere using the latitude and longitude
//   double calculateDistance(LatLng point1, LatLng point2) {
//     const int earthRadius = 6371000; // Radius of the earth in meters
//     final lat1Rad = degreesToRadians(point1.latitude);
//     final lat2Rad = degreesToRadians(point2.latitude);
//     final deltaLatRad = degreesToRadians(point2.latitude - point1.latitude);
//     final deltaLonRad = degreesToRadians(point2.longitude - point1.longitude);
//
//     final a = sin(deltaLatRad / 2) * sin(deltaLatRad / 2) +
//         cos(lat1Rad) *
//             cos(lat2Rad) *
//             sin(deltaLonRad / 2) *
//             sin(deltaLonRad / 2);
//     final c = 2 * atan2(sqrt(a), sqrt(1 - a));
//
//     return earthRadius * c;
//   }
//
//   // Converting degrees to radians.
//   double degreesToRadians(double degrees) {
//     return degrees * (pi / 180);
//   }
//
//   @override
//   void dispose() {
//     mapController.dispose();
//     lifter.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<DocumentSnapshot>(
//         stream: _stream,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasData) {
//             var data = snapshot.data?.data() as Map<String, dynamic>;
//             double latitude = data['Latitude'] ?? 0.0;
//             double longitude = data['Longitude'] ?? 0.0;
//             selectedPosition = LatLng(latitude, longitude);
//
//             return Stack(
//               children: [
//                 GoogleMap(
//                   mapType: MapType.normal,
//                   myLocationEnabled: true,
//                   myLocationButtonEnabled: false,
//                   zoomControlsEnabled: false,
//                   initialCameraPosition: CameraPosition(
//                     target: currentLocation ?? selectedPosition,
//                     zoom: 14.4746,
//                   ),
//                   onMapCreated: onMapCreated,
//                   markers: {
//                     // Marker for the current user's location
//                     if (currentLocation != null)
//                       Marker(
//                         markerId: MarkerId('current_location'),
//                         position: currentLocation!,
//                         icon: BitmapDescriptor.defaultMarkerWithHue(
//                             BitmapDescriptor.hueBlue),
//                         infoWindow: InfoWindow(title: 'Me'),
//                       ),
//                     // Marker for the selected location from Firestore
//                     Marker(
//                       markerId: MarkerId('selected_location'),
//                       position: selectedPosition,
//                       icon: BitmapDescriptor.defaultMarkerWithHue(
//                           BitmapDescriptor.hueRed),
//                       infoWindow: InfoWindow(
//                         title: 'Handyman/Customer',
//                       ),
//                     ),
//                   },
//                 ),
//                 Center(
//                   child: Transform.translate(
//                     offset: Offset(.0, -20 + (lifter.value * -15)),
//                     child: SizedBox(
//                       height: 40,
//                       width: 40,
//                       child: Image.asset('assets/icons/location_pin.png'),
//                     ),
//                   ),
//                 ),
//                 Center(
//                   child: FadeTransition(
//                     opacity: lifter,
//                     child: const CircleAvatar(
//                       radius: 2,
//                       backgroundColor: Colors.grey,
//                     ),
//                   ),
//                 ),
//                 SafeArea(
//                   child: Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Padding(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 24, vertical: 30),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Align(
//                             alignment: Alignment.bottomRight,
//                             child: FloatingActionButton(
//                               elevation: 10,
//                               backgroundColor: Colors.grey[50],
//                               foregroundColor: Colors.blueGrey,
//                               onPressed: () async {
//                                 bool serviceEnabled =
//                                     await Geolocator.isLocationServiceEnabled();
//                                 if (serviceEnabled) {
//                                   Position pos =
//                                       await Geolocator.getCurrentPosition();
//                                   LatLng currentPos =
//                                       LatLng(pos.latitude, pos.longitude);
//                                   setState(() {
//                                     currentLocation = currentPos;
//                                     mapController.animateCamera(
//                                       CameraUpdate.newCameraPosition(
//                                         CameraPosition(
//                                             target: currentPos, zoom: 18),
//                                       ),
//                                     );
//                                   });
//                                 } else {
//                                   print('Location services are disabled.');
//                                 }
//                               },
//                               child: const Icon(Icons.my_location),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           if (currentLocation != null)
//                             Text(
//                               'Distance: ${calculateDistance(currentLocation!, selectedPosition).toStringAsFixed(2)} meters',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18,
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 SafeArea(
//                   child: Align(
//                     alignment: Alignment.topLeft,
//                     child: Container(
//                       height: 54,
//                       alignment: Alignment.centerLeft,
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: Material(
//                         color: Colors.grey[50],
//                         elevation: 10,
//                         borderRadius: BorderRadius.circular(16),
//                         child: IconButton(
//                           color: Colors.blueGrey,
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           icon: const Icon(Icons.arrow_back),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           } else {
//             return Center(child: Text('No data available.'));
//           }
//         },
//       ),
//     );
//   }
// }

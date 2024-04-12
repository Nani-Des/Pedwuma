// // ignore_for_file: prefer_const_constructors
//
// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:math' show asin, atan2, cos, pi, sin, sqrt;
//
// import 'package:handyman_app/Services/read_data.dart';
// import 'package:handyman_app/constants.dart';
//
// class LocationScreen extends StatefulWidget {
//   final LatLng? initialSelectedPostion;
//   final String role;
//   const LocationScreen(
//       {Key? key, this.initialSelectedPostion, required this.role})
//       : super(key: key);
//
//   @override
//   State<LocationScreen> createState() => _LocationScreenState();
// }
//
// class _LocationScreenState extends State<LocationScreen>
//     with TickerProviderStateMixin {
//   late GoogleMapController mapController;
//   late AnimationController lifter;
//   LatLng selectedPosition = LatLng(6.6745, -1.5716); // Default position
//   Stream<DocumentSnapshot>? _stream;
//   LatLng? currentLocation;
//   String locationDocID = '';
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
//     getLocationDocID().then((_) {
//       _stream = FirebaseFirestore.instance
//           .collection('Location')
//           .doc(locationDocID)
//           .snapshots();
//     });
//
//     updateLocationPeriodically();
//   }
//
//   void updateLocation(Position newLocation) async {
//     final document = await FirebaseFirestore.instance
//         .collection('Location')
//         .where('User ID', isEqualTo: loggedInUserId)
//         .get();
//     final docID = document.docs.single.id;
//
//     await FirebaseFirestore.instance.collection('Location').doc(docID).update({
//       'Latitude': newLocation.latitude,
//       'Longitude': newLocation.longitude,
//     });
//   }
//
//   void updateLocationPeriodically() {
//     Future<void>.delayed(const Duration(seconds: 15)).then((_) async {
//       Position newLocation = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//
//       updateLocation(newLocation);
//       updateLocationPeriodically();
//     });
//   }
//
//   Future getLocationDocID() async {
//     final String userID;
//     if (moreOffers[selectedJob].applierID == loggedInUserId) {
//       userID = moreOffers[selectedJob].receiverID;
//     } else {
//       userID = moreOffers[selectedJob].applierID;
//     }
//
//     final document = await FirebaseFirestore.instance
//         .collection('Location')
//         .where('User ID', isEqualTo: userID)
//         .get();
//     if (document.docs.isNotEmpty) {
//       setState(() {
//         locationDocID = document.docs.single.id;
//       });
//     }
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
//   double calculateDistance(LatLng start, LatLng end) {
//     final distance = Geolocator.distanceBetween(
//       start.latitude,
//       start.longitude,
//       end.latitude,
//       end.longitude,
//     );
//
//     return distance;
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
//                         title: widget.role,
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

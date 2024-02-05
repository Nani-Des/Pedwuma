import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';

class DrawerTile extends StatefulWidget {
  final Widget screen;
  final String title;
  final IconData icon;

  const DrawerTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.screen,
  }) : super(key: key);

  @override
  State<DrawerTile> createState() => _DrawerTileState();
}

class _DrawerTileState extends State<DrawerTile> {
  int jobOfferCount = 0; // Initialize the job offer count

  @override
  void initState() {
    super.initState();
    if (widget.title == "Bookings" || widget.title == "My Jobs") {
      // Check job offers only if the title is 'Bookings' or 'My Jobs'
      checkJobOffers();
    }
  }

  Future<void> checkJobOffers() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final serviceDocs = await FirebaseFirestore.instance
          .collection('Services')
          .where('User ID', isEqualTo: userId)
          .get();

      if (serviceDocs.docs.isNotEmpty) {
        // Assuming 'Job Offers' is a map field
        List<dynamic> jobOffers;
        if (widget.title == "Bookings") {
          jobOffers = serviceDocs.docs.first.data()!['Job Offers']['Customer'];
        } else {
          jobOffers = serviceDocs.docs.first.data()!['Job Offers']['Handyman'];
        }

        jobOfferCount = jobOffers.length;

        setState(() {}); // Update the UI after getting the job offer count
      }
    } catch (e) {
      print('Error checking job offers: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => widget.screen,
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(widget.icon, color: primary),
          SizedBox(width: 22 * screenWidth),
          Text(
            widget.title,
            style: TextStyle(
              color: black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          if ((widget.title == "Bookings" || widget.title == "My Jobs") &&
              jobOfferCount > 0) // Show notification count if there are job offers
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.red,
                child: Text(
                  jobOfferCount.toString(),
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

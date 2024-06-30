import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Components/grid_item.dart';
import 'Components/user_search_page.dart';
import 'New/job_service.dart';
import 'New/worker_profile_service.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  int userCount = 0;
  int serviceCount = 0;
  int jobCount = 0;
  int applicationCount = 0;
  int bookingCount = 0;
  int workerCount = 0;
  int activeJobCount = 0; // Track active job count separately
  int activeWorkerCount = 0; // Track active worker count separately
  bool showActiveJobs = false; // Flag to show active jobs count
  bool showActiveWorkers = false; // Flag to show active worker profiles count

  final JobService _jobService = JobService(); // Create an instance of JobService
  final WorkerProfileService _workerProfileService = WorkerProfileService(); // Create an instance of WorkerProfileService

  @override
  void initState() {
    super.initState();
    _fetchCounts();
  }

  Future<void> _fetchCounts() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot usersSnapshot = await firestore.collection('users').where('status', isEqualTo: true).get();
    QuerySnapshot servicesSnapshot = await firestore.collection('Services').get();
    QuerySnapshot jobsSnapshot = await firestore.collection('Jobs').get();
    QuerySnapshot applicationsSnapshot = await firestore.collection('Applications').get();
    QuerySnapshot bookingsSnapshot = await firestore.collection('Bookings').get();
    QuerySnapshot workersSnapshot = await firestore.collection('Booking Profile').get();

    setState(() {
      userCount = usersSnapshot.docs.length;
      serviceCount = servicesSnapshot.docs.length;
      jobCount = jobsSnapshot.docs.length; // Total jobs count
      applicationCount = applicationsSnapshot.docs.length;
      bookingCount = bookingsSnapshot.docs.length;
      workerCount = workersSnapshot.docs.length;
    });

    // Fetch active job count separately using JobService
    activeJobCount = await _jobService.getActiveJobCount();
    // Fetch active worker profile count separately using WorkerProfileService
    activeWorkerCount = await _workerProfileService.getActiveWorkerCount();
  }

  void _navigateToUserSearch(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserSearchPage()),
    );
  }

  void _onPressedJobs() {
    setState(() {
      showActiveJobs = !showActiveJobs; // Toggle between total and active job count
    });
  }

  void _onPressedWorkerProfiles() {
    setState(() {
      showActiveWorkers = !showActiveWorkers; // Toggle between total and active worker profile count
    });
  }

  @override
  Widget build(BuildContext context) {
    String jobsTitle = showActiveJobs ? 'Active Jobs' : 'Jobs';
    int jobsCount = showActiveJobs ? activeJobCount : jobCount;

    String workerProfilesTitle = showActiveWorkers ? 'Active Worker Profiles' : 'Worker Profiles';
    int workerProfilesCount = showActiveWorkers ? activeWorkerCount : workerCount;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Admin Panel',
            style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          children: <Widget>[
            GridItem(
              title: 'Users',
              count: userCount,
              onPressed: () => _navigateToUserSearch(context),
            ),
            GridItem(title: 'Services', count: serviceCount, onPressed: () {}),
            GridItem(
              title: jobsTitle,
              count: jobsCount,
              onPressed: _onPressedJobs,
            ),
            GridItem(
              title: workerProfilesTitle,
              count: workerProfilesCount,
              onPressed: _onPressedWorkerProfiles,
            ),
            GridItem(title: 'Applications', count: applicationCount, onPressed: () {}),
            GridItem(title: 'Bookings', count: bookingCount, onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String title;
  final int count;
  final VoidCallback onPressed;

  GridItem({required this.title, required this.count, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '$count',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


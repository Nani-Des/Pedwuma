import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class JobService {
  Future<int> getTotalJobCount() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot jobsSnapshot = await firestore.collection('Jobs').get();
    return jobsSnapshot.docs.length;
  }

  Future<int> getActiveJobCount() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot jobsSnapshot = await firestore.collection('Jobs').get();

    // Date comparison for active jobs
    DateTime today = DateTime.now();
    int activeJobsCount = 0;

    jobsSnapshot.docs.forEach((jobDoc) {
      // Extract deadline date from Firestore document
      String deadlineDateString = jobDoc['Deadline'];
      // Parse deadline date assuming format "dd-MM-yyyy"
      DateTime deadline = DateFormat('dd-MM-yyyy').parse(deadlineDateString, true);

      // Check if the deadline is after today's date
      if (deadline.isAfter(today)) {
        activeJobsCount++;
      }
    });

    return activeJobsCount;
  }
}

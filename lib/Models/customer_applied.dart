import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerAppliedData {
  final String jobID;
  final String name;
  final String addressType;
  final String street;
  final String town;
  final String houseNum;
  final String region;
  final String notes;
  final String date;
  final String time;
  final String pic;
  final String applierID;
  final String documentID;
  final String receiverID;
  final String jobStatus;
  final String note;
  Timestamp? acceptedDate;
  Timestamp? inProgressDate;
  Timestamp? completedDate;
  String? whoApplied;
  List? referenceLinks;
  List? portfolio;
  CustomerAppliedData({
    this.whoApplied,
    required this.note,
    required this.documentID,
    required this.jobStatus,
    required this.receiverID,
    required this.jobID,
    required this.applierID,
    required this.name,
    required this.addressType,
    required this.houseNum,
    required this.town,
    required this.street,
    required this.region,
    required this.notes,
    required this.time,
    required this.pic,
    required this.date,
    this.acceptedDate,
    this.inProgressDate,
    this.completedDate,
    this.referenceLinks,
    this.portfolio,
  });
}

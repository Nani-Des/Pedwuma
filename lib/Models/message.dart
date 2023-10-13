import 'package:cloud_firestore/cloud_firestore.dart';

class MessageData {
  final String senderID;
  final String receiverID;
  final String message;
  final Timestamp timeStamp;
  final String senderName;

  const MessageData({
    required this.senderID,
    required this.receiverID,
    required this.senderName,
    required this.message,
    required this.timeStamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'Sender ID': senderID,
      'Receiver ID': receiverID,
      'Message': message,
      'timeStamp': senderID,
      'Sender Name': senderName,
    };
  }
}

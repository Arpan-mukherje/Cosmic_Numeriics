import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceMessage {
  final String senderId;
  final String senderEmail;
  final String recieverId;
  final String recieverEmail;
  final String message;

  final Timestamp timestamp;
  final int messageType; //0 - normal text, 1 - banner, 2 - confirmed/payment

  ServiceMessage({
    required this.senderId,
    required this.senderEmail,
    required this.recieverId,
    required this.recieverEmail,
    required this.message,

    //
    required this.timestamp,
    this.messageType = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'recieverId': recieverId,
      'recieverEmail': recieverEmail,
      'message': message,

      //
      'timestamp': timestamp,
      'messageType': messageType,
    };
  }
}

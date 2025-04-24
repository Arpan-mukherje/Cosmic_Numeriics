import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmic_numeriics/services/sharedPrefarence/shared_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getMessagesService(String email) {
    log(FirebaseAuth.instance.currentUser!.email!);
    log(email);
    List<String> ids = [email, SharedServices.getUserData().email!];
    //log("currrent user mail ->>>>>." + SharedServices.getUserData().email!);
    ids.sort();
    String chatRoomId = ids.join("_");
    return _firestore
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Future<void> sendMessage(
      String email, String message, String username) async {
    log("username ->>>>" + email);
    log("demo");
    List<String> ids = [email, SharedServices.getUserData().email!];
    ids.sort();
    String chatRoomId = ids.join("_");
    await _firestore
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .add({
      'message': message,
      'senderEmail': FirebaseAuth.instance.currentUser!.email,
      'username': username,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}

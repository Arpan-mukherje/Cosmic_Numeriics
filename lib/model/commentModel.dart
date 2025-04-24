import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String comment;
  final String name;
  final String date;
  final String profilepic;
  final String userId;
  final String commentId;

  CommentModel({
    required this.comment,
    required this.name,
    required this.date,
    required this.profilepic,
    required this.userId,
    required this.commentId,
  });

  factory CommentModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return CommentModel(
      comment: data['comment'] ?? '',
      name: data['name'] ?? '',
      date: data['date'] ?? '',
      profilepic: data['profilepic'] ?? '',
      userId: data['userId'] ?? '',
      commentId: data['commentId'] ?? '',
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String profilePic;
  final String name;
  final String userId;
  final String desc;
  final List<String> imageuRL;
  final Timestamp time;
  final List<dynamic> likes;
  final String postId;
  final String uniqueId;
  final String numorologynumber;

  PostModel({
    required this.numorologynumber,
    required this.name,
    required this.profilePic,
    required this.userId,
    required this.desc,
    required this.imageuRL,
    required this.time,
    required this.uniqueId,
    required this.likes,
    required this.postId,
  });
}

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmic_numeriics/model/commentModel.dart';
import 'package:cosmic_numeriics/model/report_post_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cosmic_numeriics/services/sharedPrefarence/shared_services.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import '../../model/postModel.dart';

class StorageServices {
//for upload a post in feed screen..............................................
  static Future<bool> uploadPost({
    required List<Uint8List> files,
    required String description,
  }) async {
    var ret = false;
    try {
      final _auth = FirebaseAuth.instance.currentUser;
      final userId = _auth?.uid ?? "";
      final uniqueId = const Uuid().v1();
      final String name = SharedServices.getUserData().name.toString();
      final String profilePic =
          SharedServices.getUserData().profilePic.toString();
      final String numorologynumber =
          SharedServices.getUserData().numerologyNumber.toString();

      List<String> imageUrls = [];

      for (Uint8List file in files) {
        Reference ref = FirebaseStorage.instance
            .ref()
            .child("user-post")
            .child(userId)
            .child(Uuid().v1());
        UploadTask uploadTask = ref.putData(file);
        TaskSnapshot snap = await uploadTask;
        final downloadString = await snap.ref.getDownloadURL();
        imageUrls.add(downloadString);
      }

      final postId = FirebaseFirestore.instance.collection("posts").doc().id;
      await FirebaseFirestore.instance.collection("posts").doc(postId).set({
        'profilePic': profilePic,
        'numorologynumber': numorologynumber,
        'name': name,
        'userId': userId,
        'postId': postId,
        'description': description,
        'imageUrls': imageUrls,
        'uniqueId': uniqueId,
        'timestamp': FieldValue.serverTimestamp(),
        'likes': [],
      });

      log(postId);
      ret = true;
    } catch (e) {
      log('Error uploadPost: $e');
      ret = false;
    }
    return ret;
  }

//-----------------------------------------------------------------------------------------------------
// Upload only Text Post.....
  static Future<bool> uploadArticlePost({
    required String description,
  }) async {
    var ret = false;
    try {
      final _auth = FirebaseAuth.instance.currentUser;
      final userId = _auth?.uid ?? "";
      final uniqueId = const Uuid().v1();
      final String name = SharedServices.getUserData().name.toString();
      final String profilePic =
          SharedServices.getUserData().profilePic.toString();
      final String numorologynumber =
          SharedServices.getUserData().numerologyNumber.toString();
      // Reference ref =
      //     FirebaseStorage.instance.ref().child("user-post").child(userId);
      final postId = FirebaseFirestore.instance.collection("posts").doc().id;
      await FirebaseFirestore.instance.collection("posts").doc(postId).set({
        'profilePic': profilePic,
        'numorologynumber': numorologynumber,
        'name': name,
        'userId': userId,
        'postId': postId,
        'description': description,
        'uniqueId': uniqueId,
        'imageUrls': ["Text_post"],
        'timestamp': FieldValue.serverTimestamp(),
        'likes': [],
      });

      log(postId);
      ret = true;
    } catch (e) {
      log('Error uploadPost: $e');
      ret = false;
    }
    return ret;
  }

//------------------------------------------------------------------------------------------------
//for video
  static Future<bool> uploadVideoPost({
    required List<Uint8List> files,
    required String description,
  }) async {
    var ret = false;
    try {
      final _auth = FirebaseAuth.instance.currentUser;
      final userId = _auth?.uid ?? "";
      final uniqueId = const Uuid().v1();
      final String name = SharedServices.getUserData().name.toString();
      final String profilePic =
          SharedServices.getUserData().profilePic.toString();
      final String numorologynumber =
          SharedServices.getUserData().numerologyNumber.toString();

      List<String> videoUrls = [];

      for (Uint8List file in files) {
        Reference ref = FirebaseStorage.instance
            .ref()
            .child("user-post")
            .child(userId)
            .child(Uuid().v1());
        UploadTask uploadTask =
            ref.putData(file, SettableMetadata(contentType: 'video/mp4'));
        TaskSnapshot snap = await uploadTask;
        final downloadUrl = await snap.ref.getDownloadURL();
        videoUrls.add(downloadUrl);
      }

      final postId = FirebaseFirestore.instance.collection("posts").doc().id;
      await FirebaseFirestore.instance.collection("posts").doc(postId).set({
        'profilePic': profilePic,
        'numorologynumber': numorologynumber,
        'name': name,
        'userId': userId,
        'postId': postId,
        //'isVideo': true,
        'description': description,
        'videoUrls': videoUrls,
        'uniqueId': uniqueId,
        'timestamp': FieldValue.serverTimestamp(),
        'likes': [],
      });

      log(postId);
      ret = true;
    } catch (e) {
      log('Error uploadVideoPost: $e');
      ret = false;
    }
    return ret;
  }

//-----------------------------------------------------------------------------------------------------
//for like a post
  static Future<void> likePost(String postId, List<dynamic> likes) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final DocumentReference docRef =
            FirebaseFirestore.instance.collection('posts').doc(postId);

        if (likes.contains(user.uid)) {
          await docRef.update({
            'likes': FieldValue.arrayRemove([user.uid]),
          });
          log('Post unliked by user ${user.uid}');
        } else {
          await docRef.update({
            'likes': FieldValue.arrayUnion([user.uid]),
          });
          log('Post liked by user ${user.uid}');
        }
      }
    } catch (e) {
      log("Error from likePost: $e");
    }
  }

//-----------------------------------------------------------------------------------------------------
  // static Future<void> commentPost({
  //   required String comment,
  //   required String postId,
  // }) async {
  //   try {
  //     if (comment.isNotEmpty) {
  //       final name = SharedServices.getUserData().name.toString();
  //       final profilepic = SharedServices.getUserData().profilePic.toString();
  //       final userId = SharedServices.getUserData().userId.toString();
  //       final commentId = Uuid().v1();
  //       await FirebaseFirestore.instance
  //           .collection("posts")
  //           .doc(postId)
  //           .collection("comments")
  //           .doc(commentId)
  //           .set({
  //         'comment': comment,
  //         'name': name,
  //         'date': DateTime.now().toString(),
  //         'profilepic': profilepic,
  //         'userId': userId,
  //         'commentId': commentId,
  //       });
  //     }
  //   } catch (e) {
  //     log("Error from commentfun: $e");
  //   }
  // }
  static Future<void> commentPost({
    required String comment,
    required String postId,
    String? parentCommentId,
  }) async {
    try {
      if (comment.isNotEmpty) {
        final name = SharedServices.getUserData().name.toString();
        final profilepic = SharedServices.getUserData().profilePic.toString();
        final userId = SharedServices.getUserData().userId.toString();
        final commentId = Uuid().v1();
        final commentData = {
          'comment': comment,
          'name': name,
          'date': DateTime.now().toString(),
          'profilepic': profilepic,
          'userId': userId,
          'commentId': commentId,
        };

        if (parentCommentId == null) {
          // Posting a comment
          await FirebaseFirestore.instance
              .collection("posts")
              .doc(postId)
              .collection("comments")
              .doc(commentId)
              .set(commentData);
        } else {
          // Posting a reply
          await FirebaseFirestore.instance
              .collection("posts")
              .doc(postId)
              .collection("comments")
              .doc(parentCommentId)
              .collection("replies")
              .doc(commentId)
              .set(commentData);
        }
      }
    } catch (e) {
      log("Error from commentPost: $e");
    }
  }

//-----------------------------------------------------------------------------------------------
  static Stream<List<CommentModel>> getReplies(
      String postId, String commentId) {
    return FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("comments")
        .doc(commentId)
        .collection("replies")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CommentModel.fromFirestore(doc))
            .toList());
  }

//-----------------------------------------------------------------------------------------------------

  static Stream<List<PostModel>> getUploadPostData() {
    try {
      final Stream<QuerySnapshot> stream =
          FirebaseFirestore.instance.collection('posts').snapshots();

      return stream.map((querySnapshot) {
        final List<PostModel> posts = querySnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;

          final name = data['name'] as String? ?? "";
          final profilePic = data['profilePic'] as String? ?? "";
          final userId = data['userId'] as String? ?? '';
          final desc = data['description'] as String? ?? '';
          List<String> imageUrls = data['imageUrls'] != null
              ? List<String>.from(data['imageUrls'])
              : [];
          final time = data['timestamp'] as Timestamp? ?? Timestamp.now();
          final postId = data['postId'] as String? ?? '';
          final uniqueId = data['uniqueId'] as String? ?? '';
          final numorologynumber = data['numorologynumber'] as String? ?? '';
          final likes =
              data['likes'] != null ? List<String>.from(data['likes']) : [];

          return PostModel(
            name: name,
            userId: userId,
            desc: desc,
            imageuRL: imageUrls,
            time: time,
            postId: postId,
            likes: likes,
            profilePic: profilePic,
            uniqueId: uniqueId,
            numorologynumber: numorologynumber,
          );
        }).toList();
        posts.sort((a, b) => b.time.compareTo(a.time));

        return posts;
      });
    } catch (e) {
      log("Error from getPostData: $e");
      rethrow;
    }
  }

//-----------------------------------------------------------------------------------------------------
//for get all comment for a post
  static Stream<List<CommentModel>> getComments(String postId) {
    final stream = FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection('comments')
        .snapshots();

    return stream.map((qsnap) {
      return qsnap.docs.map((doc) {
        final data = doc.data();
        final name = data['name'] as String? ?? "";
        final comment = data['comment'] as String? ?? "";
        final commentId = data['commentId'] as String? ?? "";
        final userId = data['userId'] as String? ?? "";
        final profilepic = data['profilepic'] as String? ?? "";
        final date = data['date'] as String? ?? "";
        return CommentModel(
            comment: comment,
            name: name,
            date: date.toString(),
            profilepic: profilepic,
            userId: userId,
            commentId: commentId);
      }).toList();
    });
  }

//-----------------------------------------------------------------------------------------------------
//for get data from a user in her/his profile page
  static Stream<List<PostModel>> getDataForProfilePage(String userId) {
    try {
      final Stream<QuerySnapshot> stream = FirebaseFirestore.instance
          .collection('posts')
          .where('userId', isEqualTo: userId)
          .snapshots();

      return stream.map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;

          final name = data['name'] as String? ?? "";
          final desc = data['description'] as String? ?? "";
          final profilePic = data['profilePic'] as String? ?? "";
          List<String> imageUrls = data['imageUrls'] != null
              ? List<String>.from(data['imageUrls'])
              : [];
          final time = data['timestamp'] as Timestamp? ?? Timestamp.now();
          final postId = data['postId'] as String? ?? '';
          final uniqueId = data['uniqueId'] as String? ?? '';
          final numorologynumber = data['numorologynumber'] as String? ?? '';
          final likes =
              data['likes'] != null ? List<String>.from(data['likes']) : [];

          return PostModel(
            name: name,
            userId: userId,
            desc: desc,
            imageuRL: imageUrls,
            time: time,
            postId: postId,
            likes: likes,
            uniqueId: uniqueId,
            profilePic: profilePic,
            numorologynumber: numorologynumber,
          );
        }).toList();
      });
    } catch (e) {
      log("Error from getPostData: $e");
      rethrow;
    }
  }

//-----------------------------------------------------------------------------------------------------
//for delete a post
  static Future<void> deletePost(String postId, List<String> imageUrls) async {
    try {
      await FirebaseFirestore.instance.collection("posts").doc(postId).delete();
      for (String imageUrl in imageUrls) {
        final ref = FirebaseStorage.instance.refFromURL(imageUrl);
        await ref.delete();
      }
    } catch (e) {
      log("Error from deletePost function: $e");
    }
  }

  //-----------------------------------------------------------------------
  //report post
  static Future<void> reportPost(String uniqueId, String reason) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final reportPostId = const Uuid().v1();
      final reportData = ReportPost(
          uniqueId: uniqueId,
          userId: userId,
          reason: reason,
          reportId: reportPostId);
      await FirebaseFirestore.instance
          .collection('RepostPost')
          .doc(reportPostId)
          .set(reportData.toJson());
    } catch (e) {
      log("error from reportPost function $e");
    }
  }

  //------------------------------------------------------------------------
  static Future<void> followuser(String uid, String followid) async {
    try {
      DocumentSnapshot userSnap =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      // DocumentSnapshot followSnap = await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(followid)
      //     .get();

      List following = (userSnap.data()! as dynamic)['following'] ?? [];
      //  List followers = (followSnap.data()! as dynamic)['followers'] ?? [];

      if (following.contains(followid)) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(followid)
            .update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followid])
        });
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(followid)
            .update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followid])
        });
      }
    } catch (e) {
      log("Error in followuser function: $e");
    }
  }
}

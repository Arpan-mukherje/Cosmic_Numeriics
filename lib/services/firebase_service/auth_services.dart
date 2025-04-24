import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmic_numeriics/views/chat_section/user_controller.dart';
import 'package:cosmic_numeriics/model/task_model.dart';
import 'package:cosmic_numeriics/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cosmic_numeriics/services/sharedPrefarence/shared_services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AuthService {
//-----------------------------------------------------------------------------------------------------
//for register a user
  static Future<UserCredential> signup({
    required String email,
    required String password,
    required String name,
    required String dob,
    required Uint8List? file,
  }) async {
    try {
      final auth = FirebaseAuth.instance;
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userId = userCredential.user?.uid;
      log("register$userId");
      await storeUserDetails(
        name: name,
        dob: dob,
        // gender: gender,
        email: email,
        userId: userId!,
        file: file,
      );
      await getAndStoreUserDetails(userId);
      return userCredential;
    } catch (e) {
      log("Error from signup: $e");
      throw "from throw signup$e";
    }
  }

//-----------------------------------------------------------------------------------------------------

  static Future<UserCredential?> signIn(String email, String password) async {
    try {
      final auth = FirebaseAuth.instance;
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserController userController = Get.put(UserController());
      userController.email.value = email;
      userController.uid.value = userCredential.user?.uid ?? "";

      final userId = userCredential.user?.uid;
      if (userId != null) {
        log("login$userId");
        await getAndStoreUserDetails(userId);
      }

      return userCredential;
    } catch (e) {
      log("Error during signIn: $e");
      rethrow;
    }
  }

//-----------------------------------------------------------------------------------------------------
//for logout a user
  static Future<void> signOut() async {
    try {
      final auth = FirebaseAuth.instance;
      await auth.signOut();
    } catch (e) {
      log("Error from signOut: $e");
      rethrow;
    }
  }

//-----------------------------------------------------------------------------------------------------
//for delete a user
  static Future<void> deleteAccount() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.delete();
    } catch (e) {
      log("Error from deleteAccount: $e");
      rethrow;
    }
  }

//-----------------------------------------------------------------------------------------------------

  static Future<void> storeUserDetails(
      {required String name,
      required String dob,
      // required String gender,
      required String email,
      required Uint8List? file,
      required String userId}) async {
    try {
      int numoNumber = calculateSingleDigitSum(dob);
      log(numoNumber.toString());
      const profilepic =
          "https://img.freepik.com/free-vector/blue-circle-with-white-user_78370-4707.jpg";
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'name': name,
        'userId': userId,
        'dob': dob,
        "searchName": name.toLowerCase(),
        'email': email,
        'profile-pic': profilepic,
        'numerologyNumber': numoNumber,
        'created_AT': DateTime.now().millisecondsSinceEpoch,
        'followers': [],
        'following': [],
        'completedTask': []
      });
    } catch (e) {
      log("Error from storeUserDetails: $e");
    }
  }

//-----------------------------------------------------------------------------------------------------
//for get the details from firebae and store in shared pref
  static Future<void> getAndStoreUserDetails(String userId) async {
    try {
      final docSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .get();

      if (docSnap.exists) {
        log("User Data From DataBase : " + jsonEncode(docSnap.data()));
        SharedServices.setUserData(
            userModelFromJson(jsonEncode(docSnap.data())));
      }
    } catch (e) {
      log("Error from getAndStoreUserDetails: $e");
    }
  }

//-----------------------------------------------------------------------------------------------------
//for search a user    %%%%     NOT WORKING        %%%%
  static Future<List<Map<String, dynamic>>> searchUser(String username) async {
    try {
      final response = await FirebaseFirestore.instance
          .collection('user')
          .where('name', arrayContains: username.toLowerCase())
          .get();
      final resultList = response.docs.map((doc) => doc.data()).toList();
      log("Search Query: $username");
      log("Search Result: $resultList");
      return resultList;
    } catch (e) {
      log("Error during search: $e");
      return [];
    }
  }

//-----------------------------------------for update a user details------------------------------------------------------------
//for update a user details
  static Future<void> updateUserInfo({
    String? name,
    String? dob,
    String? gender,
    String? email,
    Uint8List? file,
  }) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId != null) {
        String? profilePic;
        if (file != null) {
          profilePic = await uploadProfilePicture(userId, file);
          log(profilePic.toString());
        }

        Map<String, dynamic> updateData = {};
        if (name != null) updateData['name'] = name;
        if (dob != null) updateData['dob'] = dob;
        if (gender != null) updateData['gender'] = gender;
        if (email != null) updateData['email'] = email;
        if (profilePic != null) updateData['profile-pic'] = profilePic;

        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        log('Fetched user document: ${userDoc.data().toString()} and userId $userId');
        if (userDoc.exists) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .update(updateData);

          SharedServices.updateUserData(
            name: name,
            dob: dob != null ? DateTime.parse(dob) : null,
            gender: gender,
            email: email,
            profilePic: profilePic,
          );
        } else {
          log("User document not found for userId: $userId");
        }
      } else {
        log("User not authenticated");
      }
    } catch (e) {
      log("Error from updateUserInfo: $e");
    }
  }

//-------------------
  static Future<String?> uploadProfilePicture(
      String userId, Uint8List file) async {
    try {
      // Create a unique filename for the profile picture
      final fileName =
          'profile_pictures/$userId/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final storageRef = FirebaseStorage.instance.ref().child(fileName);

      // Upload the file
      final uploadTask =
          storageRef.putData(file, SettableMetadata(contentType: 'image/jpeg'));
      final snapshot = await uploadTask;

      // Get the download URL
      final downloadUrl = await snapshot.ref.getDownloadURL();
      log('Download URL: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      log('Error uploading profile picture: $e');
      return null;
    }
  }

//-----------------------------------------------------------------------------------------------------
//for calculate numo number
  static int calculateSingleDigitSum(String date) {
    date = date.replaceAll('-', '');
    int sum = 0;
    for (int i = 0; i < date.length; i++) {
      sum += int.parse(date[i]);
    }
    while (sum >= 10) {
      int tempSum = 0;
      while (sum > 0) {
        tempSum += sum % 10;
        sum ~/= 10;
      }
      sum = tempSum;
    }
    log(sum.toString());
    return sum;
  }

  //.............................................................................
  // Remedy section GET all remedy
  static Future<TaskResponseModel> getTodaysRemedy() async {
    int index = 1;
    if (SharedServices.getUserData().completedTask!.isNotEmpty) {
      if (DateFormat.yMd().format(DateTime.fromMillisecondsSinceEpoch(
              SharedServices.getUserData().completedTask!.last.completedAt!)) !=
          DateFormat.yMd().format(DateTime.now())) {
        index = SharedServices.getUserData().completedTask!.length + 1;
      } else {
        index = SharedServices.getUserData().completedTask!.length;
      }
    }

    var data = await FirebaseFirestore.instance
        .collection('AllTask')
        .where("index", isEqualTo: index)
        .where("numerologyNumber",
            isEqualTo: SharedServices.getUserData().numerologyNumber)
        .get();

    return taskResponseModelFromJson(jsonEncode(data.docs[0].data()));
  }

  //.............................................................................
  //Remedy section Submit task
  static Future<void> submitTodaysRemedy(TaskResponseModel model) async {
    List<TaskResponseModel> taskList =
        SharedServices.getUserData().completedTask!.toList();
    taskList.add(model);
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(SharedServices.getUserData().userId)
        .update({
      "completedTask": jsonDecode(taskResponseModelListToJson(taskList))
    });
  }
}

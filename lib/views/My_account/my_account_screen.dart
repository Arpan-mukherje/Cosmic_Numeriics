import 'dart:developer';
import 'package:cosmic_numeriics/views/Authentication/new_login_screen.dart';
import 'package:cosmic_numeriics/views/chat_section/user_controller.dart';
import 'package:cosmic_numeriics/constant/sharedpref.dart';
import 'package:cosmic_numeriics/services/url_launcher/url_launcher.dart';
import 'package:cosmic_numeriics/views/Authentication/choose_login_signup_page.dart';
import 'package:cosmic_numeriics/views/Authentication/login_check.dart';
import 'package:cosmic_numeriics/services/firebase_service/auth_services.dart';
import 'package:cosmic_numeriics/services/sharedPrefarence/shared_services.dart';
import 'package:cosmic_numeriics/views/My_account/update_user_details.dart';
import 'package:cosmic_numeriics/widget/appbar_widgets/decorative_appbar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

// ignore: must_be_immutable
class Myaccount extends StatelessWidget {
  Myaccount({super.key});

  final User? id = FirebaseAuth.instance.currentUser;

  var dob;

  int calculateSingleDigitSum(String date) {
    String digitsOnly = date.replaceAll(RegExp(r'\D'), '');
    int sum = 0;
    for (int i = 0; i < digitsOnly.length; i++) {
      sum += int.parse(digitsOnly[i]);
    }

    if (sum >= 10) {
      return calculateSingleDigitSum(sum.toString());
    } else {
      return sum;
    }
  }

  UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    // var width = MediaQuery.of(context).size.width;

    String name = SharedServices.getUserData().name.toString();
    String deathOfBirth = SharedServices.getUserData().dob.toString();
    String gender = SharedServices.getUserData().gender.toString();
    String email = SharedServices.getUserData().email.toString();
    String profilepic = SharedServices.getUserData().profilePic.toString();

    log("Profile pic---->> " + profilepic);
    // String numorologyNumber =
    //     SharedServices.getUserData().numerologyNumber.toString();
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(children: [
          Stack(clipBehavior: Clip.none, children: [
            DecorativeAppBar(
              barHeight: MediaQuery.of(context).size.height * 0.21,
              barPad: MediaQuery.of(context).size.height * 0.16,
              radii: 20,
              background: Colors.white,
              gradient1: const Color.fromARGB(255, 192, 40, 114),
              gradient2: const Color.fromARGB(255, 255, 154, 111),
              extra: Container(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.07, left: height * 0.04),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.03, left: height * 0.02),
                    child: const Row(
                      children: [],
                    ),
                  ),
                ]),
              ),
            ),
            Positioned(
              top: 0.11.sh,
              left: 130.w,
              right: 130.w,
              child: Container(
                height: 90.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromRGBO(225, 100, 113, 0.5),
                          offset: Offset(-1, 2),
                          spreadRadius: 1,
                          blurRadius: 2)
                    ]),
                child: Image.network(
                  //color: const Color.fromARGB(255, 192, 40, 114),
                  profilepic,
                  fit: BoxFit.contain,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
          ]),
          Padding(
            padding: EdgeInsets.only(left: 10.0.w, right: 10.w, top: 50.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UpdateUserDetails(
                            name: name,
                            email: email,
                            dob: deathOfBirth,
                            image: profilepic,
                            gender: gender)));
                  },
                  child: Container(
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(225, 100, 113, 0.5),
                          offset: Offset(-1, 2),
                          spreadRadius: 1,
                          blurRadius: 2)
                    ]),
                    child: const ListTile(
                      tileColor: Colors.white,
                      leading: Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 192, 40, 114),
                      ),
                      title: Text(
                        "Personal Info",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: Text(
                        ">",
                        style: TextStyle(fontSize: 25, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                // GestureDetector(
                //   onTap: () {
                //     //  log(dob);
                //     int finalSum = calculateSingleDigitSum(deathOfBirth);
                //     log(finalSum.toString());

                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) =>
                //                 MyLuckyThingsScreen(dobSum: finalSum)));
                //   },
                //   child: Container(
                //     decoration:
                //         const BoxDecoration(color: Colors.white, boxShadow: [
                //       BoxShadow(
                //           color: Color.fromRGBO(225, 100, 113, 0.5),
                //           offset: Offset(-1, 2),
                //           spreadRadius: 1,
                //           blurRadius: 2)
                //     ]),
                //     child: const ListTile(
                //       tileColor: Colors.white,
                //       leading: Icon(
                //         Icons.badge,
                //         color: Color.fromARGB(255, 192, 40, 114),
                //       ),
                //       title: Text(
                //         "My Lucky Things",
                //         style: TextStyle(fontWeight: FontWeight.w600),
                //       ),
                //       trailing: Text(
                //         ">",
                //         style: TextStyle(fontSize: 25, color: Colors.black),
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 15.h,
                // ),
                GestureDetector(
                  onTap: () async {
                    await AuthService.signOut();
                    preferences!.clear();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ChooseLoginSignupScreen()));
                  },
                  child: Container(
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(225, 100, 113, 0.5),
                          offset: Offset(-1, 2),
                          spreadRadius: 1,
                          blurRadius: 2)
                    ]),
                    child: const ListTile(
                      tileColor: Colors.white,
                      leading: Icon(
                        Icons.pages,
                        color: Color.fromARGB(255, 192, 40, 114),
                      ),
                      title: Text(
                        "Terms & Conditions",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: Text(
                        ">",
                        style: TextStyle(fontSize: 25, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                GestureDetector(
                  onTap: () async {
                    UrlLauncher.email();
                  },
                  child: Container(
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(225, 100, 113, 0.5),
                          offset: Offset(-1, 2),
                          spreadRadius: 1,
                          blurRadius: 2)
                    ]),
                    child: const ListTile(
                      tileColor: Colors.white,
                      leading: Icon(
                        Icons.email,
                        color: Color.fromARGB(255, 192, 40, 114),
                      ),
                      title: Text(
                        "Support",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: Text(
                        ">",
                        style: TextStyle(fontSize: 25, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                GestureDetector(
                  onTap: () async {
                    await AuthService.deleteAccount();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginCheck()));
                    preferences!.clear();
                  },
                  child: Container(
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(225, 100, 113, 0.5),
                          offset: Offset(-1, 2),
                          spreadRadius: 1,
                          blurRadius: 2)
                    ]),
                    child: const ListTile(
                      tileColor: Colors.white,
                      leading: Icon(
                        Icons.delete,
                        color: Color.fromARGB(255, 192, 40, 114),
                      ),
                      title: Text(
                        "Delete Account",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: Text(
                        ">",
                        style: TextStyle(fontSize: 25, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                GestureDetector(
                  onTap: () async {
                    await AuthService.signOut();
                    preferences!.clear();
                    userController.email.value = "";
                    userController.uid.value = "";
                    userController.username.value = "";
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => NewLoginScreen()));
                  },
                  child: Container(
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(225, 100, 113, 0.5),
                          offset: Offset(-1, 2),
                          spreadRadius: 1,
                          blurRadius: 2)
                    ]),
                    child: const ListTile(
                      tileColor: Colors.white,
                      leading: Icon(
                        Icons.logout,
                        color: Color.fromARGB(255, 192, 40, 114),
                      ),
                      title: Text(
                        "Log out",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: Text(
                        ">",
                        style: TextStyle(fontSize: 25, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ])));
  }
}

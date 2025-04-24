// import 'package:cosmic_numeriics/home_page.dart';
// import 'package:cosmic_numeriics/views/Authentication/forget_password.dart';
// import 'package:cosmic_numeriics/views/Authentication/register_page.dart';
// import 'package:cosmic_numeriics/services/firebase_service/auth_services.dart';
// import 'package:cosmic_numeriics/widget/Button/rectangle_elevated_button.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class NewLoginScreen extends StatefulWidget {
//   const NewLoginScreen({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _NewLoginScreenState createState() => _NewLoginScreenState();
// }

// class _NewLoginScreenState extends State<NewLoginScreen> {
//   bool passwordVisible = false;

//   TextEditingController lemail = TextEditingController();
//   TextEditingController lpass = TextEditingController();

//   @override
//   void dispose() {
//     lemail.dispose();
//     lpass.dispose();
//     super.dispose();
//   }

//   void showSnackBarMessage(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//         backgroundColor: const Color.fromARGB(255, 192, 40, 114),
//         body: Column(children: [
//           SizedBox(
//             height: height * 0.25,
//             child: Stack(children: [
//               Container(
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Color.fromARGB(255, 192, 40, 114), // gradient1
//                       Color.fromARGB(255, 255, 154, 111), // gradient2
//                     ],
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Login',
//                             style: TextStyle(
//                               fontSize: 30.sp,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             'Welcome back',
//                             style: TextStyle(
//                               fontSize: 19.sp,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       width: width * 0.13,
//                     ),
//                   ],
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: Image.asset(
//                   "assets/appbar.png",

//                   fit: BoxFit.cover,
//                   // Adjust height as needed
//                 ),
//               ),
//             ]),
//           ),
//           Expanded(
//             child: Stack(children: [
//               Container(
//                 decoration: const BoxDecoration(
//                   color: Color.fromARGB(255, 255, 242, 222),
//                   borderRadius:
//                       BorderRadius.only(topLeft: Radius.circular(100)),
//                 ),
//               ),
//               Center(
//                 child: SingleChildScrollView(
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       color: Color.fromARGB(255, 255, 242, 222),
//                       borderRadius:
//                           BorderRadius.only(topLeft: Radius.circular(100)),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 30.0, top: 30),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           const Text("Email"),
//                           Container(
//                             height: MediaQuery.of(context).size.height * 0.06,
//                             width: MediaQuery.of(context).size.width * 0.88,
//                             decoration: BoxDecoration(
//                                 border: Border.all(
//                                     color: const Color.fromARGB(
//                                         255, 221, 221, 221))),
//                             child: TextField(
//                               controller: lemail,
//                               decoration: InputDecoration(
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(1),
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 contentPadding:
//                                     const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                                 hintText: 'Enter email here',
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(2),
//                                   borderSide: const BorderSide(
//                                     color: Colors
//                                         .grey, // Custom border color when focused
//                                   ),
//                                 ),
//                                 fillColor:
//                                     const Color.fromARGB(255, 250, 250, 252),
//                                 filled: true,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 30),
//                           Text("Password"),
//                           Container(
//                             height: MediaQuery.of(context).size.height * 0.06,
//                             width: MediaQuery.of(context).size.width * 0.88,
//                             decoration: BoxDecoration(
//                                 border: Border.all(
//                                     color: const Color.fromARGB(
//                                         255, 221, 221, 221))),
//                             child: TextField(
//                               controller: lpass,
//                               obscureText: passwordVisible,
//                               decoration: InputDecoration(
//                                 contentPadding:
//                                     const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                                 fillColor:
//                                     const Color.fromARGB(255, 250, 250, 252),
//                                 filled: true,
//                                 border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(2),
//                                     borderSide: BorderSide.none),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(2),
//                                   borderSide: const BorderSide(
//                                     color: Colors
//                                         .grey, // Custom border color when focused
//                                   ),
//                                 ),
//                                 hintText: "Enter password here",
//                                 suffixIcon: IconButton(
//                                   icon: Icon(
//                                       color: const Color.fromARGB(
//                                           255, 111, 53, 165),
//                                       passwordVisible
//                                           ? Icons.visibility
//                                           : Icons.visibility_off),
//                                   onPressed: () {
//                                     setState(
//                                       () {
//                                         passwordVisible = !passwordVisible;
//                                       },
//                                     );
//                                   },
//                                 ),
//                                 alignLabelWithHint: false,
//                               ),
//                               keyboardType: TextInputType.visiblePassword,
//                               textInputAction: TextInputAction.done,
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context).push(MaterialPageRoute(
//                                       builder: (context) =>
//                                           const ForgotPassword()));
//                                 },
//                                 child: const Text(
//                                   'Forget Password ?',
//                                   style: TextStyle(
//                                     fontSize: 15,
//                                     color: Color.fromARGB(255, 111, 53, 165),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 10),
//                           LoginRectangleElevatedButton(
//                               text: 'LOGIN',
//                               height: 40.h,
//                               width: MediaQuery.of(context).size.width * 0.88,
//                               color: const Color.fromARGB(255, 158, 18, 86),
//                               onPressed: () async {
//                                 try {
//                                   final luser = await AuthService.signin(
//                                       lemail.text, lpass.text);

//                                   // Check if the login is successful
//                                   // ignore: unnecessary_null_comparison
//                                   if (luser != null) {
//                                     // ignore: use_build_context_synchronously
//                                     showSnackBarMessage(
//                                         context, 'Login successful');

//                                     // ignore: use_build_context_synchronously
//                                     Navigator.of(context).pushReplacement(
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 const HomeScreen()));
//                                   } else {
//                                     // ignore: use_build_context_synchronously
//                                     showSnackBarMessage(
//                                         context, 'Incorrect email or password');
//                                   }
//                                 } on FirebaseAuthException catch (e) {
//                                   if (e.code == 'wrong-password') {
//                                     showSnackBarMessage(
//                                         context, 'Incorrect password');
//                                   } else if (e.code == 'user-not-found') {
//                                     showSnackBarMessage(
//                                         context, 'User not found');
//                                   } else {
//                                     showSnackBarMessage(
//                                         context, 'An error occurred');
//                                   }
//                                 } catch (e) {
//                                   showSnackBarMessage(
//                                       context, 'An error occurred $e');
//                                   throw e;
//                                 }
//                               }),
//                           const SizedBox(height: 30),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context).push(MaterialPageRoute(
//                                       builder: (context) => const RegScreen()));
//                                 },
//                                 child: const Row(
//                                   children: [
//                                     Text(
//                                       "Don't have an account ? ",
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                     Text(
//                                       'Sign Up',
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color:
//                                             Color.fromARGB(255, 111, 53, 165),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ]),
//           )
//         ]));
//   }
// }

//.... Above one is OLD UI with appbar..........................................

import 'dart:developer';

import 'package:cosmic_numeriics/home_page.dart';
import 'package:cosmic_numeriics/services/firebase_service/auth_services.dart';
import 'package:cosmic_numeriics/views/Authentication/forget_password.dart';
import 'package:cosmic_numeriics/views/Authentication/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewLoginScreen extends StatefulWidget {
  const NewLoginScreen({super.key});

  @override
  State<NewLoginScreen> createState() => _NewLoginScreenState();
}

class _NewLoginScreenState extends State<NewLoginScreen> {
  bool passwordVisible = false;

  TextEditingController lemail = TextEditingController();
  TextEditingController lpass = TextEditingController();

  @override
  void dispose() {
    lemail.dispose();
    lpass.dispose();
    super.dispose();
  }

  void showSnackBarMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 242, 222),
      body: Center(
        child: Container(
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 242, 222),
            image: DecorationImage(
              image: const AssetImage("assets/login_signup_choose_bg.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3), // Dim the background
                BlendMode.darken,
              ),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Welcome back',
                      style: TextStyle(
                        fontSize: 33.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 0.12.sh),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Text(
                    'User ID',
                    style: TextStyle(fontSize: 15.sp, color: Colors.white),
                  ),
                ),
                SizedBox(height: 8.h),
                TextField(
                  controller: lemail,
                  decoration: InputDecoration(
                    hintText: 'Enter your username',
                    filled: true,
                    fillColor: Colors.white, // Set background to white
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Text(
                    'Password',
                    style: TextStyle(fontSize: 15.sp, color: Colors.white),
                  ),
                ),
                SizedBox(height: 8.h),
                TextField(
                  controller: lpass,
                  obscureText: !passwordVisible,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    fillColor: const Color.fromARGB(255, 250, 250, 252),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    hintText: "Enter password here",
                    suffixIcon: IconButton(
                      icon: Icon(
                          color: const Color.fromARGB(255, 111, 53, 165),
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                      onPressed: () {
                        setState(
                          () {
                            passwordVisible = !passwordVisible;
                          },
                        );
                      },
                    ),
                    alignLabelWithHint: false,
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ForgotPassword()));
                        },
                        child: const Text(
                          'Forget Password ?',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 45.h),
                ElevatedButton(
                  onPressed: () async {
                    // Show loading or disable the button while waiting
                    try {
                      final userCredential = await AuthService.signIn(
                        lemail.text.trim(),
                        lpass.text.trim(),
                      );

                      // If userCredential is valid, proceed to the Home screen
                      if (userCredential?.user != null) {
                        showSnackBarMessage(context, 'Login successful');
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      } else {
                        showSnackBarMessage(
                            context, 'Incorrect email or password');
                      }
                    } on FirebaseAuthException catch (e) {
                      // Handle specific Firebase errors
                      switch (e.code) {
                        case 'wrong-password':
                          showSnackBarMessage(context, 'Incorrect password');
                          break;
                        case 'user-not-found':
                          showSnackBarMessage(context, 'User not found');
                          break;
                        default:
                          showSnackBarMessage(
                              context, 'Login failed: ${e.message}');
                      }
                    } catch (e) {
                      // Handle any other unexpected errors
                      log("Unexpected error: $e");
                      showSnackBarMessage(
                          context, 'An unexpected error occurred');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 158, 18, 86),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(Icons.arrow_forward_ios,
                          color: Colors.white, size: 18.sp),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'OR',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RegScreen()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ?  ",
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.yellow,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        " Sign Up",
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

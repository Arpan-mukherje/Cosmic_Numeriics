// import 'dart:ui';
// import 'package:cosmic_numeriics/widget/appbar_widgets/appbar_widget.dart';
// import 'package:cosmic_numeriics/widget/appbar_widgets/decorative_appbar_widget.dart';
// import 'package:cosmic_numeriics/widget/rectangle_elevated_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';

// class CompatibilityWithPhoneNumber extends StatefulWidget {
//   const CompatibilityWithPhoneNumber({Key? key}) : super(key: key);

//   @override
//   State<CompatibilityWithPhoneNumber> createState() =>
//       _CompatibilityWithPhoneNumberState();
// }

// class _CompatibilityWithPhoneNumberState
//     extends State<CompatibilityWithPhoneNumber> {
//   bool passwordVisible = false;
//   TextEditingController lemail = TextEditingController();
//   TextEditingController lpass = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController dobc = TextEditingController();
//   TextEditingController genderc = TextEditingController();

//   @override
//   void dispose() {
//     lemail.dispose();
//     lpass.dispose();
//     phoneController.dispose();
//     dobc.dispose();
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
//     return Scaffold(
//         body: SingleChildScrollView(
//       child: Column(
//         //mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Stack(
//             clipBehavior: Clip.none,
//             children: [
//               DecorativeAppBar(
//                 barHeight: MediaQuery.of(context).size.height * 0.24,
//                 barPad: MediaQuery.of(context).size.height * 0.21,
//                 radii: 30.r,
//                 background: Colors.white,
//                 gradient1: const Color.fromARGB(255, 192, 40, 114),
//                 gradient2: const Color.fromARGB(255, 255, 154, 111),
//                 extra: appbar(
//                     "assets/man_4202843.png", "Compatibility", context, () {
//                   Navigator.pop(context);
//                 }),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 0.05.sh,
//           ),
//           Center(
//             child: Container(
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//               ),
//               child: Padding(
//                 padding: EdgeInsets.only(
//                   left: 30.w,
//                   right: 30.w,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       textAlign: TextAlign.center,
//                       "Check compatibility with your phone number",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18.sp,
//                         color: Colors.black,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 30.h,
//                     ),
//                     Text(
//                       "Phone number",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14.sp,
//                           color: Colors.black54),
//                     ),
//                     TextField(
//                       controller: phoneController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: Colors.grey),
//                         ),
//                         contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                         hintText: 'Enter your number here',
//                         hintStyle:
//                             TextStyle(color: Colors.grey.withOpacity(0.8)),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: const BorderSide(
//                             color: Color.fromARGB(255, 192, 40,
//                                 114), // Custom border color when focused
//                           ),
//                         ),
//                         fillColor: const Color.fromARGB(255, 250, 250, 252),
//                         filled: true,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     LoginRectangleElevatedButton(
//                         borderRadius: 10,
//                         text: 'CHECK',
//                         height: 45,
//                         width: MediaQuery.of(context).size.width * 0.88,
//                         color: const Color.fromARGB(255, 158, 18, 86),
//                         onPressed: () async {}),
//                     const SizedBox(height: 30),
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     ));
//   }
// }

//....... Above one is another UI.........................................

import 'dart:developer';

import 'package:cosmic_numeriics/services/provider/chech_fundamentals_provider.dart';
import 'package:cosmic_numeriics/services/sharedPrefarence/shared_services.dart';
import 'package:cosmic_numeriics/views/Check%20Fundamentals/result_compatibility.dart';
import 'package:cosmic_numeriics/widget/Button/gradient_elevated_button.dart';
import 'package:cosmic_numeriics/widget/appbar_widgets/appbar_widget.dart';
import 'package:cosmic_numeriics/widget/appbar_widgets/decorative_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CompatibilityWithPhoneNumber extends StatefulWidget {
  const CompatibilityWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<CompatibilityWithPhoneNumber> createState() =>
      _CompatibilityWithPhoneNumberState();
}

class _CompatibilityWithPhoneNumberState
    extends State<CompatibilityWithPhoneNumber> {
  TextEditingController phoneController = TextEditingController();

  String result = "";
  final int? numerologyNumber = SharedServices.getUserData().numerologyNumber;
  @override
  void dispose() {
    phoneController.dispose();

    super.dispose();
  }

  void showSnackBarMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          content: Text(message)),
    );
  }

  int getSingleDigitFromPhoneNumber(String phoneNumber, BuildContext context) {
    try {
      if (phoneNumber.length != 10) {
        throw Exception(
            'Invalid phone number. Please enter a 10-digit number.');
      }
      int sum = 0;
      // Iterate through each character in the phone number
      for (int i = 0; i < phoneNumber.length; i++) {
        String char = phoneNumber[i];
        // Ensure each character is a digit
        if (!RegExp(r'^[0-9]$').hasMatch(char)) {
          throw Exception('Invalid phone number. Please enter digits only.');
        }
        sum += int.parse(char);
      }
      // Reduce the sum to a single digit
      while (sum > 9) {
        sum = sum.toString().split('').map(int.parse).reduce((a, b) => a + b);
      }
      log(sum.toString());
      return sum;
    } catch (e) {
      showSnackBarMessage(context, "Please enter 10 digit phone number only");
      return -1;
    }
  }

  phoneNumberCompatibilityCheck(int phoneNumber) {
    if (numerologyNumber == phoneNumber ||
        phoneNumber == 3 ||
        phoneNumber == 6 ||
        phoneNumber == 9 ||
        phoneNumber == 1) {
      Provider.of<CheckFundamentalsProvider>(context, listen: false)
          .setResult("Friendly");
    } else {
      Provider.of<CheckFundamentalsProvider>(context, listen: false)
          .setResult("Not Friendly");
    }
  }

  @override
  Widget build(BuildContext context) {
    //var height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              DecorativeAppBar(
                barHeight: MediaQuery.of(context).size.height * 0.24,
                barPad: MediaQuery.of(context).size.height * 0.21,
                radii: 30.r,
                background: Colors.white,
                gradient1: const Color.fromARGB(255, 192, 40, 114),
                gradient2: const Color.fromARGB(255, 255, 154, 111),
                extra: appbar("assets/phone.png", "Compatibility", context, () {
                  Navigator.pop(context);
                }),
              ),
            ],
          ),
          SizedBox(
            height: 0.05.sh,
          ),
          Center(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 30.w,
                  right: 30.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      "Check compatibility with your phone number",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        hintText: 'Enter your number here',
                        hintStyle:
                            TextStyle(color: Colors.grey.withOpacity(0.8)),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 192, 40,
                                114), // Custom border color when focused
                          ),
                        ),
                        fillColor: Colors.transparent,
                        filled: true,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Center(
                      child: GradientElevatedButton(
                        borderRadius: 30,
                        text: 'CHECK',
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.7,
                        gradientColors: [
                          const Color.fromARGB(255, 192, 40, 114),
                          const Color.fromARGB(255, 255, 154, 111),
                        ],
                        onPressed: () async {
                          int phoneNumber = getSingleDigitFromPhoneNumber(
                              phoneController.text, context);
                          if (phoneNumber != -1) {
                            phoneNumberCompatibilityCheck(phoneNumber);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CompatibilityResultScreen(
                                  result:
                                      Provider.of<CheckFundamentalsProvider>(
                                              context,
                                              listen: false)
                                          .result,
                                  title: 'Phone Number',
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}

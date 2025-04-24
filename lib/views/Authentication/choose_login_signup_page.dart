import 'package:cosmic_numeriics/views/Authentication/new_login_screen.dart';
import 'package:cosmic_numeriics/views/Authentication/register_page.dart';
import 'package:cosmic_numeriics/widget/Button/rectangle_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseLoginSignupScreen extends StatelessWidget {
  const ChooseLoginSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.55,
                child: Image.asset(
                  "assets/login_signup_choose_bg.jpg",
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Welcome to Cosmic Numerate ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24.sp, fontWeight: FontWeight.w600),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Cosmic numerology is a belief system that attributes mystical and symbolic meanings to numbers, drawing from various ancient and esoteric traditions such as numerology, astrology, and spirituality.",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    LoginRectangleElevatedButton(
                      text: 'LOGIN',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NewLoginScreen()));
                      },
                      width: 350.w,
                      height: 40.h,
                      color: const Color.fromARGB(255, 158, 18, 86),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    LoginRectangleElevatedButton(
                      text: 'SIGNUP',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegScreen()));
                      },
                      width: 350.w,
                      height: 40.h,
                      color: Colors.deepOrange.withOpacity(0.8),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

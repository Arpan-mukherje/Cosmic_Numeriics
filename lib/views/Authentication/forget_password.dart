import 'package:cosmic_numeriics/views/Authentication/new_login_screen.dart';
import 'package:cosmic_numeriics/widget/reusable_widget/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController forgetPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            child: SizedBox(
              width: double.infinity,
              child: Image.asset('assets/Forgot_password.png'),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.3,
                right: MediaQuery.of(context).size.width * 0.2,
                top: MediaQuery.of(context).size.height * 0.02),
            child: const Text(
              'FORGET PASSWORD',
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.5,
                left: MediaQuery.of(context).size.height * 0.08,
                right: MediaQuery.of(context).size.height * 0.08),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.68,
                    child: TextField(
                      controller: forgetPassword,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        hintText: 'Enter registered email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: const Color.fromARGB(255, 245, 223, 249),
                        filled: true,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyButton(
                      message: 'Forget Password',
                      onTap: () async {
                        var forgotEmail = forgetPassword.text.trim();
                        try {
                          FirebaseAuth.instance
                              .sendPasswordResetEmail(email: forgotEmail)
                              .then((value) => {
                                    print('Email Sent'),
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NewLoginScreen()))
                                  });
                        } on FirebaseAuthException catch (e) {
                          print('Error $e');
                        }
                      })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

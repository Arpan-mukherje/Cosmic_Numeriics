import 'package:cosmic_numeriics/widget/reusable_widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCard extends StatelessWidget {
  final String title;
  final String secTitle;
  final Function ontap;
  final String message;

  const MyCard({
    Key? key,
    required this.title,
    required this.ontap,
    required this.secTitle,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.22,
      width: MediaQuery.of(context).size.width * 0.44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 1,
            offset: Offset(1, 2),
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.057,
          top: MediaQuery.of(context).size.width * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 0.35.sw,
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: title,
                      style: GoogleFonts.poppins(
                        fontSize: 0.051.sw,
                        color: const Color.fromARGB(255, 1, 35, 1),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    TextSpan(
                      text: secTitle,
                      style: GoogleFonts.poppins(
                        fontSize: 0.051.sw,
                        color: const Color.fromARGB(255, 1, 35, 1),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            MyButton(
              onTap: () {
                ontap();
              },
              message: message,
            ),
          ],
        ),
      ),
    );
  }
}

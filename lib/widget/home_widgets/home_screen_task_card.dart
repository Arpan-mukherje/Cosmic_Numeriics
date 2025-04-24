import 'dart:developer';

import 'package:cosmic_numeriics/views/Remedy/remedy_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreenTaskCard extends StatelessWidget {
  const HomeScreenTaskCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 0.18.sh,
          width: 0.93.sw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(255, 255, 255, 1),
                Color.fromRGBO(255, 215, 153, 1),
              ],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(225, 100, 113, 0.5),
                blurRadius: 9,
                offset: Offset(-1, 1),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 26.0, top: 25),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 0.11.sh,
                    width: 0.22.sw,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(192, 40, 114, 1),
                          Color.fromRGBO(255, 154, 111, 1),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    "assets/jhuliry.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  "assets/troffy.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: -1,
                child: Container(
                  height: 0.14.sh,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 0.052.sw, top: 0.025.sh),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Let’s Complete Your",
                style: GoogleFonts.poppins(
                  fontSize: 0.052.sw,
                  color: const Color.fromRGBO(71, 1, 35, 1),
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                "Daily Task! ",
                style: GoogleFonts.poppins(
                  fontSize: 0.052.sw,
                  color: const Color.fromRGBO(71, 1, 35, 1),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 0.01.sh,
              ),
              GestureDetector(
                onTap: () {
                  log("message");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RemedySection(),
                      ));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 102, 36),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "complete now",
                        style: GoogleFonts.poppins(
                          fontSize: 0.035.sw,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 0.02.sw),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

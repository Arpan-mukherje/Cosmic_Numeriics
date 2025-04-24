import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DCard extends StatelessWidget {
  final String? no;
  final String? no1destinycharh;
  final String? no1destinylifepartnerh;
  final String? no1destinyfutureh;
  final String? color;
  final String? character;
  final String? gemStone;
  final String? luckyDates;
  const DCard(
      {Key? key,
      required this.no,
      required this.no1destinycharh,
      required this.no1destinylifepartnerh,
      required this.no1destinyfutureh,
      required this.color,
      required this.character,
      required this.gemStone,
      required this.luckyDates})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.02, right: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 0.08.sh,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(colors: [
                  Color.fromARGB(255, 192, 40, 114),
                  Color.fromARGB(255, 255, 154, 111),
                ])),
            child: Center(
                child: Text(
              "Destiny Number - $no",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: Colors.white),
            )),
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.02,
            ),
            child: Text(
              "Lucky Colors",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: const Color.fromRGBO(71, 1, 35, 1)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.02,
            ),
            child: Text(
              "Based Upon your Date of Birth (DOB)",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: const Color.fromRGBO(71, 1, 35, 1)),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
                height: 0.08.sh,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 3,
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(3, 5),
                        spreadRadius: 2)
                  ],
                ),
                child: Center(
                    child: Text(
                  color!,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 19.sp,
                      color: const Color.fromRGBO(71, 1, 35, 1)),
                ))),
          ),
          SizedBox(
            height: 10.h,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.02,
            ),
            child: Text(
              "Character",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: const Color.fromRGBO(71, 1, 35, 1)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.02,
            ),
            child: Text(
              "Based Upon your Date of Birth (DOB)",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: const Color.fromRGBO(71, 1, 35, 1)),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 3,
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(3, 5),
                      spreadRadius: 2)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .center, // Align children horizontally at the center
                children: [
                  Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.028),
                    child: Text(
                      no1destinyfutureh!,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.02,
            ),
            child: Text(
              "Marriage / Life Partner",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: const Color.fromRGBO(71, 1, 35, 1)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              "Based Upon your Date of Birth (DOB)",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: const Color.fromRGBO(71, 1, 35, 1)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(3, 5),
                    spreadRadius: 2)
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .center, // Align children horizontally at the center
              children: [
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.028),
                  child: Text(
                    no1destinylifepartnerh!,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 10.0,
              top: 10.h,
            ),
            child: Text(
              "Future",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: const Color.fromRGBO(71, 1, 35, 1)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 10),
            child: Text(
              "Based Upon your Date of Birth (DOB)",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: const Color.fromRGBO(71, 1, 35, 1)),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(3, 5),
                    spreadRadius: 2)
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .center, // Align children horizontally at the center
              children: [
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.028),
                  child: Text(
                    no1destinyfutureh!,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.02,
            ),
            child: Text(
              "Lucky Dates",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: const Color.fromRGBO(71, 1, 35, 1)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              "Based Upon your Date of Birth (DOB)",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: const Color.fromRGBO(71, 1, 35, 1)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(3, 5),
                    spreadRadius: 2)
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .center, // Align children horizontally at the center
              children: [
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.028),
                  child: Text(
                    luckyDates!,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 10.0,
              top: 10.h,
            ),
            child: Text(
              "Gem Stone",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: const Color.fromRGBO(71, 1, 35, 1)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 10),
            child: Text(
              "Based Upon your Date of Birth (DOB)",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: const Color.fromRGBO(71, 1, 35, 1)),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(3, 5),
                    spreadRadius: 2)
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .center, // Align children horizontally at the center
              children: [
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.028),
                  child: Text(
                    gemStone!,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
        ]),
      ),
    );
  }
}

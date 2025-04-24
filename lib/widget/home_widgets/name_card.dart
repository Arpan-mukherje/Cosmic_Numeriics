import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NameCard extends StatelessWidget {
  final String? no;

  final String? lifePartner;
  final String? future;
  final String character;
  final String gemStone;
  final String luckyDates;
  final String luckyColor;
  const NameCard({
    super.key,
    required this.no,
    required this.lifePartner,
    required this.future,
    required this.character,
    required this.gemStone,
    required this.luckyDates,
    required this.luckyColor,
  });
  @override
  Widget build(BuildContext context) {
    // final showText = Provider.of<ShowText>(context).showContainer;
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.04,
          top: MediaQuery.of(context).size.width * 0.04,
          right: MediaQuery.of(context).size.width * 0.04),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Container(
                  // color: Colors.amber,
                  height: 0.067.sh,
                  width: 0.25.sw,
                  child: Center(
                    child: Text(
                      " Name\nNumber",
                      style: GoogleFonts.poppins(
                          fontSize: 17,
                          color: const Color.fromRGBO(71, 1, 35, 1)),
                    ),
                  ),
                ),
                Container(
                    height: 0.12.sh,
                    width: 0.23.sw,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 192, 40, 114),
                        Color.fromARGB(255, 255, 154, 111),
                      ]),
                    ),
                    child: Center(
                      child: Container(
                        height: 0.092.sh,
                        width: 0.18.sw,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Center(
                            child: Text(
                          no!,
                          style: GoogleFonts.poppins(
                              fontSize: 27,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromRGBO(71, 1, 35, 1)),
                        )),
                      ),
                    )),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 25.h,
        ),
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
            "Name Number - $no",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, fontSize: 22, color: Colors.white),
          )),
        ),
        SizedBox(
          height: 25.h,
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
                luckyColor,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 19.sp,
                    color: const Color.fromRGBO(71, 1, 35, 1)),
              ))),
        ),
        SizedBox(
          height: 10.h,
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
        Container(
          //  elevation: 0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
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
                  character,
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
        const SizedBox(
          height: 10,
        ),
        Container(
          //  elevation: 0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
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
                  lifePartner!,
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
          height: 10.h,
        ),
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.02, top: 5),
          child: Text(
            "Future",
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
        const SizedBox(
          height: 10,
        ),
        Container(
          //  elevation: 0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
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
                  future!,
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
        const SizedBox(
          height: 10,
        ),

        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.02, top: 5),
          child: Text(
            "Lucky Dates",
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
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Colors.white,
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
                  luckyDates,
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
          height: 10.h,
        ),

        Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.02,
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
        Container(
          //  elevation: 0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
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
                  gemStone,
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
          height: 30.h,
        ),
        // Visibility(
        //   visible: showText,
        //   child: TextButton(
        //       onPressed: () {
        //         Navigator.of(context).push(MaterialPageRoute(
        //             builder: (context) => const NameSuggtionSection()));
        //       },
        //       child: Text(
        //         "Do you want name suggision according to Numerology? Click here",
        //         style: GoogleFonts.poppins(
        //             fontSize: 17,
        //             fontWeight: FontWeight.w600,
        //             color: const Color.fromARGB(255, 6, 37, 62)),
        //   )
      ]),
    ));
  }
}

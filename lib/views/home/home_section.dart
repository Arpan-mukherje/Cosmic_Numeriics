import 'dart:developer';

import 'package:cosmic_numeriics/views/Check%20Fundamentals/compatibility_with_email.dart';
import 'package:cosmic_numeriics/views/Check%20Fundamentals/compatibility_with_phone.dart';
import 'package:cosmic_numeriics/views/Check%20Fundamentals/compatibility_with_vehicle_number.dart';
import 'package:cosmic_numeriics/views/Check%20Fundamentals/your_lucky_color_screen.dart';
import 'package:cosmic_numeriics/views/Check%20Fundamentals/Relationship/relationship_with_partner.dart';
import 'package:cosmic_numeriics/views/Check%20Fundamentals/your_lucky_numbers.dart';
import 'package:cosmic_numeriics/views/home/about_numuro.dart';
import 'package:cosmic_numeriics/views/home/dob_section.dart';
import 'package:cosmic_numeriics/views/home/name_section.dart';
import 'package:cosmic_numeriics/services/sharedPrefarence/shared_services.dart';
import 'package:cosmic_numeriics/views/name_suggest/name_suggest_screen.dart';
import 'package:cosmic_numeriics/widget/appbar_widgets/decorative_appbar_widget.dart';
import 'package:cosmic_numeriics/widget/home_widgets/home_screen_task_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widget/home_widgets/home_card.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _HomeSectionState createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection>
    with SingleTickerProviderStateMixin {
  // late AnimationController _controller;
  // late Animation<double> _rotationAnimation;
  @override
  void initState() {
    super.initState();
    var data = SharedServices.getUserData();
    log(data.name.toString());
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    String name;

    name = SharedServices.getUserData().name.toString();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 242, 222),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                DecorativeAppBar(
                  barHeight: MediaQuery.of(context).size.height * 0.26,
                  barPad: MediaQuery.of(context).size.height * 0.20,
                  radii: 30,
                  background: const Color.fromARGB(255, 255, 242, 222),
                  gradient1: const Color.fromARGB(255, 192, 40, 114),
                  gradient2: const Color.fromARGB(255, 255, 154, 111),
                  extra: Padding(
                    padding:
                        EdgeInsets.only(top: height * 0.02, left: width * 0.03),
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.height * 0.47,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Text(
                                  "Hey, $name ",
                                  softWrap: true,
                                  maxLines: 25,
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.inter(
                                      color: Colors.white,
                                      letterSpacing: 2.0,
                                      fontSize: height * 0.03,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.height * 0.47,
                                child: Text(
                                  "We hope you are having a great Day!",
                                  // softWrap: true,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: height * 0.024,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0.14.sh,
                  left: 15.w,
                  right: 0,
                  child: const HomeScreenTaskCard(),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.035,
                  right: MediaQuery.of(context).size.width * 0.035,
                  top: 0.088.sh),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      "Check Your Numerology!",
                      style: GoogleFonts.poppins(
                        fontSize: 0.045.sw,
                        color: const Color.fromARGB(255, 1, 35, 1),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyCard(
                        title: "Check by your ",
                        ontap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const DobSection()));
                        },
                        secTitle: 'Date Of Birth',
                        message: 'check now',
                      ),
                      MyCard(
                        ontap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const NameSection()));
                        },
                        title: "Check by your ",
                        secTitle: 'Birth Name',
                        message: 'check now',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 0.03.sh,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const NameGeneratorScreen()));
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 0.14.sh,
                          width: 0.92.sw,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(colors: [
                              Color.fromARGB(255, 229, 74, 74),
                              Color.fromARGB(255, 255, 146, 100),
                              Color.fromRGBO(255, 198, 173, 1),
                            ]),
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
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w, top: 0.03.sh),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 0.7.sw,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Find Baby's Name",
                                      style: GoogleFonts.poppins(
                                        fontSize: 20.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "By Numerology",
                                      style: GoogleFonts.poppins(
                                        fontSize: 18.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 30,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AboutNumo()));
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 0.14.sh,
                          width: 0.92.sw,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(colors: [
                              Color.fromRGBO(125, 35, 74, 1),
                              Color.fromRGBO(255, 0, 0, 0.13),
                            ]),
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
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 0.05.sw, top: 0.03.sh),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 0.7.sw,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "What is",
                                      style: GoogleFonts.poppins(
                                        fontSize: 0.052.sw,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Text(
                                      "Numerology ?",
                                      style: GoogleFonts.poppins(
                                        fontSize: 0.052.sw,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 30,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15, top: 10),
                    child: Text(
                      "Check Your Fundamentals!!",
                      style: GoogleFonts.poppins(
                        fontSize: 0.045.sw,
                        color: const Color.fromARGB(255, 1, 35, 1),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        fundamentalsContainer("Relationship with partner", () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RelationshipWithPartnerScreen()));
                        }),
                        fundamentalsContainer("Compatibility with things", () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 0.2.sh, // Adjust the height as needed
                                child: CompatibleGrid(),
                              );
                            },
                          );
                        }),
                        // fundamentalsContainer("Your Lucky Stone", () {}),
                        fundamentalsContainer("Your Lucky Color", () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const YourLuckyColorScreen()));
                        }),
                        fundamentalsContainer("Your Lucky Number", () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const YourLuckyNumberScreen()));
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget fundamentalsContainer(String message, VoidCallback onPress) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: onPress,
      child: Container(
        height: 0.17.sh,
        width: 0.34.sw,
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
          padding: const EdgeInsets.only(left: 10.0, top: 5),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 22.r,
                  child: Container(
                    // height: 0.055.sh,
                    // width: 0.113.sw,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(colors: [
                          Color.fromRGBO(192, 40, 114, 1),
                          Color.fromRGBO(255, 154, 111, 1),
                        ])),
                  ),
                ),
                Text(
                  "$message ",
                  style: GoogleFonts.poppins(
                    fontSize: 0.04.sw,
                    color: const Color.fromRGBO(71, 1, 35, 1),
                    fontWeight: FontWeight.w500,
                  ),
                )
              ]),
        ),
      ),
    ),
  );
}

class CompatibleGrid extends StatelessWidget {
  final List<String> gridNames = ["Phone", "Email", "Vehicle"];
  final List<String> imagePaths = [
    "assets/compatibility_mobile.png",
    "assets/compatibility_email.png",
    "assets/compatibility_vehicle.png"
  ];

  CompatibleGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(gridNames.length, (index) {
          return GestureDetector(
            onTap: () {
              if (index == 0) {
                log("Phone tapped");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const CompatibilityWithPhoneNumber()));
              } else if (index == 1) {
                log("Email tapped");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CompatibilityWithEmail()));
              } else if (index == 2) {
                log("Vehicle tapped");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const CompatibilityWithVehicleNumber()));
              }
              log('Avatar $index tapped');
              // You can perform specific actions based on the tapped avatar here
            },
            child: Column(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage(imagePaths[index]),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Text(gridNames[index]),
              ],
            ),
          );
        }),
      ),
    );
  }
}

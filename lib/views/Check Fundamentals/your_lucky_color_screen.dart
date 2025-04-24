import 'package:cosmic_numeriics/constant/constants.dart';
import 'package:cosmic_numeriics/services/sharedPrefarence/shared_services.dart';
import 'package:cosmic_numeriics/widget/appbar_widgets/appbar_widget.dart';
import 'package:cosmic_numeriics/widget/appbar_widgets/decorative_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class YourLuckyColorScreen extends StatefulWidget {
  const YourLuckyColorScreen({super.key});

  @override
  State<YourLuckyColorScreen> createState() => _YourLuckyColorScreenState();
}

class _YourLuckyColorScreenState extends State<YourLuckyColorScreen> {
  void showSnackBarMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int? numerologyNumber = SharedServices.getUserData().numerologyNumber;
    String luckyColor;
    String? luckyColorShort;

    switch (numerologyNumber) {
      case 1:
        luckyColor = no1LuckyColor;
        luckyColorShort = no1LuckyColorShort;
        break;
      case 2:
        luckyColor = no2LuckyColor;
        luckyColorShort = no2LuckyColorShort;
        break;
      case 3:
        luckyColor = no3LuckyColor;
        luckyColorShort = no3LuckyColorShort;
        break;
      case 4:
        luckyColor = no4LuckyColor;
        luckyColorShort = no4LuckyColorShort;
        break;
      case 5:
        luckyColor = no5LuckyColor;
        luckyColorShort = no5LuckyColorShort;
        break;
      case 6:
        luckyColor = no6LuckyColor;
        luckyColorShort = no6LuckyColorShort;
        break;
      case 7:
        luckyColor = no7LuckyColor;
        luckyColorShort = no7LuckyColorShort;
        break;
      case 8:
        luckyColor = no8LuckyColor;
        luckyColorShort = no8LuckyColorShort;
        break;
      case 9:
        luckyColor = no9LuckyColor;
        luckyColorShort = no9LuckyColorShort;
        break;
      default:
        luckyColor = "Unknown";
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                DecorativeAppBar(
                  barHeight: MediaQuery.of(context).size.height * 0.27,
                  barPad: MediaQuery.of(context).size.height * 0.24,
                  radii: 20,
                  background: Colors.white,
                  gradient1: const Color.fromARGB(255, 192, 40, 114),
                  gradient2: const Color.fromARGB(255, 255, 154, 111),
                  extra: appbar(
                      "assets/paint-brush.png", "Your Lucky Color", context,
                      () {
                    Navigator.pop(context);
                  }),
                ),
                Positioned(
                  top: 0.165.sh,
                  left: 0.2.sw,
                  right: 0.2.sw,
                  child: CircleAvatar(
                    radius: 50.r,
                    child: Image.asset("assets/color-wheel.png"),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 0.1.sh,
            ),
            Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: Text(
                    "Your Lucky Colors Based on Your numerology Number ${SharedServices.getUserData().numerologyNumber} : ",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Column(
                  children: [
                    Container(
                      //  height: 0.09.sh,
                      width: 0.9.sw,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(3, 3),
                            blurRadius: 5,
                            color: Colors.grey,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.justify,
                            luckyColorShort!,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 192, 40, 114),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                      //  height: 0.09.sh,
                      width: 0.9.sw,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(3, 3),
                            blurRadius: 5,
                            color: Colors.grey,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.justify,
                            luckyColor,
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromARGB(255, 192, 40, 114)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

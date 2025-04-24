import 'package:cosmic_numeriics/constant/constants.dart';
import 'package:cosmic_numeriics/services/sharedPrefarence/shared_services.dart';
import 'package:cosmic_numeriics/widget/appbar_widgets/appbar_widget.dart';
import 'package:cosmic_numeriics/widget/appbar_widgets/decorative_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class YourLuckyNumberScreen extends StatefulWidget {
  const YourLuckyNumberScreen({super.key});

  @override
  State<YourLuckyNumberScreen> createState() => _YourLuckyNumberScreenState();
}

class _YourLuckyNumberScreenState extends State<YourLuckyNumberScreen> {
  void showSnackBarMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int? numerologyNumber = SharedServices.getUserData().numerologyNumber;
    String luckyNumbers;
    String? luckyDates;

    switch (numerologyNumber) {
      case 1:
        luckyNumbers = no1LuckyNumbers;
        luckyDates = no1LuckyDates;
        break;
      case 2:
        luckyNumbers = no2LuckyNumbers;
        luckyDates = no2LuckyDates;
        break;
      case 3:
        luckyNumbers = no3LuckyNumbers;
        luckyDates = no3LuckyDates;
        break;
      case 4:
        luckyNumbers = no4LuckyNumbers;
        luckyDates = no4LuckyDates;
        break;
      case 5:
        luckyNumbers = no5LuckyNumbers;
        luckyDates = no5LuckyDates;
        break;
      case 6:
        luckyNumbers = no6LuckyNumbers;
        luckyDates = no6LuckyDates;
        break;
      case 7:
        luckyNumbers = no7LuckyNumbers;
        luckyDates = no7LuckyDates;
        break;
      case 8:
        luckyNumbers = no8LuckyNumbers;
        luckyDates = no8LuckyDates;
        break;
      case 9:
        luckyNumbers = no9LuckyNumbers;
        luckyDates = no9LuckyDates;
        break;
      default:
        luckyNumbers = "Unknown";
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
                  extra: appbar("assets/lucky-numbers_appbar.png",
                      "Lucky Numbers", context, () {
                    Navigator.pop(context);
                  }),
                ),
                Positioned(
                  top: 0.165.sh,
                  left: 0.2.sw,
                  right: 0.2.sw,
                  child: CircleAvatar(
                    radius: 50.r,
                    child: Image.asset(
                      "assets/lucky_number.png",
                    ),
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
                    "Your Lucky Numbers Based on Your numerology Number ${SharedServices.getUserData().numerologyNumber} : ",
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
                            luckyNumbers,
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
                            luckyDates!,
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

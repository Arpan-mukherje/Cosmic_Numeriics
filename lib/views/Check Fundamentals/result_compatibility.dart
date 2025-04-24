import 'package:cosmic_numeriics/widget/appbar_widgets/appbar_widget.dart';
import 'package:cosmic_numeriics/widget/appbar_widgets/decorative_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompatibilityResultScreen extends StatefulWidget {
  final String? result;
  final String title;

  const CompatibilityResultScreen(
      {super.key, this.result, required this.title});

  @override
  State<CompatibilityResultScreen> createState() =>
      _CompatibilityResultScreenState();
}

class _CompatibilityResultScreenState extends State<CompatibilityResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                extra: appbar("assets/compatibility_result_appbar.png",
                    "Compatibility", context, () {
                  Navigator.pop(context);
                }),
              ),
              Positioned(
                top: 0.16.sh,
                left: 0.2.sw,
                right: 0.2.sw,
                child: CircleAvatar(
                  radius: 60.r,
                  child: Image.asset("assets/esoteric.png"),
                ),
              )
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
                  textAlign: TextAlign.start,
                  "Compatibility of your ${widget.title} with your psychis number : ",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Container(
                height: 0.09.sh,
                width: 0.9.sw,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(3, 3),
                          blurRadius: 5,
                          color: Colors.grey,
                          spreadRadius: 2)
                    ]),
                child: Center(
                  child: Text(
                    widget.result!,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 192, 40, 114),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }
}

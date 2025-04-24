import 'package:cosmic_numeriics/services/provider/chech_fundamentals_provider.dart';
import 'package:cosmic_numeriics/services/sharedPrefarence/shared_services.dart';
import 'package:cosmic_numeriics/views/Check%20Fundamentals/result_compatibility.dart';
import 'package:cosmic_numeriics/widget/Button/gradient_elevated_button.dart';
import 'package:cosmic_numeriics/widget/appbar_widgets/decorative_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RelationshipWithPartnerScreen extends StatefulWidget {
  const RelationshipWithPartnerScreen({Key? key}) : super(key: key);

  @override
  State<RelationshipWithPartnerScreen> createState() =>
      _RelationshipWithPartnerScreenState();
}

class _RelationshipWithPartnerScreenState
    extends State<RelationshipWithPartnerScreen> {
  TextEditingController namec = TextEditingController();
  TextEditingController dobc = TextEditingController();

  @override
  void dispose() {
    namec.dispose();
    dobc.dispose();
    super.dispose();
  }

  final int? numerologyNumber = SharedServices.getUserData().numerologyNumber;
  // String result = "";

  void relationshipCheck() {
    String dateString = dobc.text;
    List<String> dateParts = dateString.split('-');
    if (dateParts.length != 3) {
      print('Invalid date format. Please use "yyyy-mm-dd".');
      return;
    }

    int? year = int.tryParse(dateParts[0]);
    int? month = int.tryParse(dateParts[1]);
    int? day = int.tryParse(dateParts[2]);

    if (year == null || month == null || day == null) {
      return;
    }

    int? total = (day + month + year);
    while (total! > 9) {
      total = total.toString().split('').map(int.parse).reduce((a, b) => a + b);
    }
    int? partnerDestinyNumber = total;

    int primaryNumber = day;
    while (primaryNumber > 9) {
      primaryNumber = primaryNumber
          .toString()
          .split('')
          .map(int.parse)
          .reduce((a, b) => a + b);
    }

    if (numerologyNumber == partnerDestinyNumber ||
        partnerDestinyNumber == 6 ||
        partnerDestinyNumber == 3 ||
        partnerDestinyNumber == 9 ||
        partnerDestinyNumber == 1) {
      Provider.of<CheckFundamentalsProvider>(context, listen: false)
          .setResult("Friendly");
    } else {
      Provider.of<CheckFundamentalsProvider>(context, listen: false)
          .setResult("Not Friendly");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      Stack(
        clipBehavior: Clip.none,
        children: [
          DecorativeAppBar(
            barHeight: MediaQuery.of(context).size.height * 0.21,
            barPad: MediaQuery.of(context).size.height * 0.16,
            radii: 20,
            background: Colors.white,
            gradient1: const Color.fromARGB(255, 192, 40, 114),
            gradient2: const Color.fromARGB(255, 255, 154, 111),
          ),
          Positioned(
            top: 0.1.sh,
            left: 0.2.sw,
            right: 0.2.sw,
            child: CircleAvatar(
              radius: 50.r,
              child: Image.asset("assets/relationship.png"),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 0.1.sh,
      ),
      Column(
        children: [
          Text(
            "Compatibility with life partner ",
            style: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.h),
            child: const Text(
                textAlign: TextAlign.center,
                "Please provide the following details to assess compatibility with your life partner"),
          ),
        ],
      ),
      Center(
          child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 30.h),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Full Name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              color: Colors.black54),
                        ),
                        TextField(
                          controller: namec,
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            hintText: 'Enter your number here',
                            hintStyle:
                                TextStyle(color: Colors.grey.withOpacity(0.8)),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 192, 40,
                                    114), // Custom border color when focused
                              ),
                            ),
                            fillColor: Colors.transparent,
                            filled: true,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          "Date of Birth",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              color: Colors.black54),
                        ),
                        GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              dobc.text = formattedDate;
                            }
                          },
                          child: AbsorbPointer(
                            child: TextField(
                              controller: dobc,
                              decoration: InputDecoration(
                                border: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                hintText: 'Select DOB from here',
                                hintStyle: TextStyle(
                                    color: Colors.grey.withOpacity(0.8)),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 192, 40,
                                        114), // Custom border color when focused
                                  ),
                                ),
                                fillColor: Colors.transparent,
                                filled: true,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 30),
                        const SizedBox(height: 10),
                        Center(
                            child: GradientElevatedButton(
                          borderRadius: 30.r,
                          text: 'CHECK',
                          height: 40.h,
                          width: MediaQuery.of(context).size.width * 0.88,
                          gradientColors: const [
                            Color.fromARGB(255, 192, 40, 114),
                            Color.fromARGB(255, 255, 154, 111),
                          ],
                          onPressed: () async {
                            if (namec.text.isEmpty || dobc.text.isEmpty) {
                              // Show Snackbar for selecting both fields
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Please enter both Name and Date of Birth.'),
                                ),
                              );
                              return;
                            }

                            relationshipCheck();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CompatibilityResultScreen(
                                  result:
                                      Provider.of<CheckFundamentalsProvider>(
                                              context,
                                              listen: false)
                                          .result,
                                  title: 'Partner',
                                ),
                              ),
                            );
                          },
                        ))
                      ]))))
    ])));
  }
}

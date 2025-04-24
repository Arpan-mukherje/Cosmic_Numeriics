import 'package:cosmic_numeriics/services/provider/chech_fundamentals_provider.dart';
import 'package:cosmic_numeriics/services/sharedPrefarence/shared_services.dart';
import 'package:cosmic_numeriics/views/Check%20Fundamentals/result_compatibility.dart';
import 'package:cosmic_numeriics/widget/Button/gradient_elevated_button.dart';
import 'package:cosmic_numeriics/widget/appbar_widgets/appbar_widget.dart';
import 'package:cosmic_numeriics/widget/appbar_widgets/decorative_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CompatibilityWithVehicleNumber extends StatefulWidget {
  const CompatibilityWithVehicleNumber({Key? key}) : super(key: key);

  @override
  State<CompatibilityWithVehicleNumber> createState() =>
      _CompatibilityWithVehicleNumberState();
}

class _CompatibilityWithVehicleNumberState
    extends State<CompatibilityWithVehicleNumber> {
  TextEditingController vehicleNumberController = TextEditingController();

  @override
  void dispose() {
    vehicleNumberController.dispose();
    super.dispose();
  }

  void showSnackBarMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          content: Text(message)),
    );
  }

  int getSingleDigitFromVehicleNumber(String vehicleNumber) {
    final Map<String, int> customValues = {
      'a': 1,
      'b': 2,
      'c': 3,
      'd': 4,
      'e': 5,
      'f': 8,
      'g': 3,
      'h': 5,
      'i': 1,
      'j': 1,
      'k': 2,
      'l': 3,
      'm': 4,
      'n': 5,
      'o': 7,
      'p': 8,
      'q': 1,
      'r': 2,
      's': 3,
      't': 4,
      'u': 6,
      'v': 6,
      'w': 6,
      'x': 5,
      'y': 1,
      'z': 7,
      '0': 0,
      '1': 1,
      '2': 2,
      '3': 3,
      '4': 4,
      '5': 5,
      '6': 6,
      '7': 7,
      '8': 8,
      '9': 9,
    };

    String cleanVehicleNumber =
        vehicleNumber.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
    int sum = 0;

    for (int i = 0; i < cleanVehicleNumber.length; i++) {
      String char = cleanVehicleNumber[i].toLowerCase();
      if (customValues.containsKey(char)) {
        sum += customValues[char]!;
      } else {
        return -1; // invalid character
      }
    }

    while (sum > 9) {
      sum = sum.toString().split('').map(int.parse).reduce((a, b) => a + b);
    }

    return sum;
  }

  void checkVehicleNumberCompatibility() {
    if (vehicleNumberController.text.isEmpty) {
      showSnackBarMessage(context, 'Please enter a vehicle number.');
      return;
    }

    int vehicleNumberDigit =
        getSingleDigitFromVehicleNumber(vehicleNumberController.text);
    if (vehicleNumberDigit == -1) {
      showSnackBarMessage(context, 'Invalid vehicle number.');
      return;
    }

    //String result = '';
    final int? numerologyNumber = SharedServices.getUserData().numerologyNumber;
    if (numerologyNumber == vehicleNumberDigit ||
        vehicleNumberDigit == 3 ||
        vehicleNumberDigit == 6 ||
        vehicleNumberDigit == 9 ||
        vehicleNumberDigit == 1) {
      Provider.of<CheckFundamentalsProvider>(context, listen: false)
          .setResult("Friendly");
    } else {
      Provider.of<CheckFundamentalsProvider>(context, listen: false)
          .setResult("Not Friendly");
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CompatibilityResultScreen(
          result: Provider.of<CheckFundamentalsProvider>(context, listen: false)
              .result,
          title: 'Vehicle Number',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //   var height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              DecorativeAppBar(
                barHeight: MediaQuery.of(context).size.height * 0.24,
                barPad: MediaQuery.of(context).size.height * 0.21,
                radii: 30.r,
                background: Colors.white,
                gradient1: const Color.fromARGB(255, 192, 40, 114),
                gradient2: const Color.fromARGB(255, 255, 154, 111),
                extra: appbar(
                    "assets/vehicle_appbar.png", "Compatibility", context, () {
                  Navigator.pop(context);
                }),
              ),
            ],
          ),
          SizedBox(
            height: 0.05.sh,
          ),
          Center(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 30.w,
                  right: 30.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      "Check Compatibility With Your Vehicle Number",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    TextField(
                      controller: vehicleNumberController,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        hintText: 'Enter your vehicle number here',
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
                    SizedBox(height: 30.h),
                    Center(
                      child: GradientElevatedButton(
                          borderRadius: 30,
                          text: 'CHECK',
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.7,
                          // ignore: prefer_const_literals_to_create_immutables
                          gradientColors: [
                            const Color.fromARGB(255, 192, 40, 114),
                            const Color.fromARGB(255, 255, 154, 111),
                          ],
                          onPressed: () async {
                            checkVehicleNumberCompatibility();
                          }),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}

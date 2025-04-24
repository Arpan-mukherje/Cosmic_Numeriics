import 'package:cosmic_numeriics/services/provider/name_suggest_controller.dart';
import 'package:cosmic_numeriics/widget/Button/rectangle_elevated_button.dart';
import 'package:cosmic_numeriics/widget/appbar_widgets/appbar_widget.dart';
import 'package:cosmic_numeriics/widget/appbar_widgets/decorative_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NameGeneratorScreen extends StatefulWidget {
  const NameGeneratorScreen({Key? key}) : super(key: key);

  @override
  _NameGeneratorScreenState createState() => _NameGeneratorScreenState();
}

class _NameGeneratorScreenState extends State<NameGeneratorScreen> {
  final TextEditingController dobController = TextEditingController();

  @override
  void dispose() {
    dobController.dispose();
    // Provider.of<NameGeneratorController>(context, listen: false).resetValues();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NameGeneratorController>(context, listen: false)
          .resetValues();
    });
  }

  Future<void> getDate(BuildContext context) async {
    final pickDate = await showDatePicker(
      initialDate: DateTime.now(),
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickDate != null && pickDate != DateTime.now()) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickDate);
      dobController.text = formattedDate;
    }
  }

  bool _validateInput(String dob, String gender) {
    final dobRegExp = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    final genderRegExp = RegExp(r'^(Male|Female)$', caseSensitive: false);
    return dobRegExp.hasMatch(dob) && genderRegExp.hasMatch(gender);
  }

  List<String> genders = ["Male", "Female"];
  List<String> namesFirstLetters = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  extra: appbar("assets/remedy.png", "Name Suggestion", context,
                      () {
                    Navigator.pop(context);
                  }),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
              child: const Text(
                "Find a name that aligns with your child's numerology ",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: const Text(
                "Date of birth",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 19),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.88,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 221, 221, 221),
                  ),
                ),
                child: GestureDetector(
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
                      dobController.text =
                          formattedDate; // Use your date format here
                    }
                  },
                  child: AbsorbPointer(
                    child: TextField(
                      controller: dobController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        hintText: 'Enter DOB here',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: const Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: const Text(
                "Date of birth",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 19),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Consumer<NameGeneratorController>(
                  builder: (context, value, child) {
                    return SizedBox(
                      width: double.infinity,
                      child: InputDecorator(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 2.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 206, 206, 206),
                              width: 0.5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 198, 198, 198),
                              width: 0.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 229, 229, 229),
                              width: 0.5,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            alignment: Alignment.centerLeft,
                            elevation: 4,
                            value: value.gender.isEmpty ? null : value.gender,
                            hint: const Text("Select Gender"),
                            isExpanded: true,
                            dropdownColor: Colors.white,
                            items: genders.map((String g) {
                              return DropdownMenuItem<String>(
                                alignment: Alignment.centerLeft,
                                value: g,
                                child: Text(
                                  g,
                                  style: const TextStyle(
                                    color: const Color.fromRGBO(71, 1, 35, 1),
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? val) {
                              if (val != null) {
                                value.setGender(val);
                              }
                            },
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )),
            SizedBox(height: 20.h),
            Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: const Text("(optional)",
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 19))),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
              child: SizedBox(
                width: double.infinity,
                child: Consumer<NameGeneratorController>(
                  builder: (context, value, child) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 2.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 206, 206, 206),
                            width: 0.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 198, 198, 198),
                            width: 0.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 229, 229, 229),
                            width: 0.5,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          alignment: Alignment.centerLeft,
                          elevation: 4,
                          isExpanded: true,
                          value: value.fLetter.isEmpty ? null : value.fLetter,
                          hint: const Text("Select First Letter"),
                          items: namesFirstLetters.map((String g) {
                            return DropdownMenuItem<String>(
                              alignment: Alignment.centerLeft,
                              value: g,
                              child: Text(
                                g,
                                style: const TextStyle(
                                    color: Color.fromRGBO(71, 1, 35, 1)),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? val) {
                            if (val != null) {
                              value.setFirstLetter(val);
                            }
                          },
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Consumer<NameGeneratorController>(
              builder: (context, provider, child) {
                return provider.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 192, 40, 114),
                      ))
                    : Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20.w, right: 20.w),
                            child: LoginRectangleElevatedButton(
                                width: double.infinity,
                                height: 40.h,
                                color: const Color.fromARGB(255, 192, 40, 114),
                                onPressed: () {
                                  if (_validateInput(
                                      dobController.text, provider.gender)) {
                                    provider.generateNames(
                                      dobController.text,
                                      provider.gender,
                                      firstLetter: provider.fLetter,
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Please enter a valid date of birth and gender')),
                                    );
                                  }
                                },
                                text: 'Generate Names'),
                          ),
                          SizedBox(height: 16.h),
                          const SizedBox(height: 16),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: provider.generatedNames.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromRGBO(
                                                225, 100, 113, 0.5),
                                            offset: Offset(-1, 2),
                                            spreadRadius: 1,
                                            blurRadius: 2)
                                      ]),
                                  child: ListTile(
                                    title: Padding(
                                      padding: EdgeInsets.only(left: 0.0.w),
                                      child: Center(
                                        child: Text(
                                          provider.generatedNames[index],
                                          style: const TextStyle(
                                              color:
                                                  Color.fromRGBO(71, 1, 35, 1),
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          if (provider.hasGeneratedNames)
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20.w, right: 20.w, bottom: 20.h),
                              child: LoginRectangleElevatedButton(
                                width: double.infinity,
                                height: 40.h,
                                color: const Color.fromARGB(255, 192, 40, 114),
                                onPressed: () {
                                  if (_validateInput(
                                      dobController.text, provider.gender)) {
                                    provider.generateNames(
                                        dobController.text, provider.gender,
                                        append: true,
                                        firstLetter: provider.fLetter);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Please enter a valid date of birth and gender')),
                                    );
                                  }
                                },
                                text: 'More',
                              ),
                            ),
                        ],
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}

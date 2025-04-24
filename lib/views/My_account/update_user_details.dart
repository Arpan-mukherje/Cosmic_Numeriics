import 'dart:developer';

import 'package:cosmic_numeriics/home_page.dart';
import 'package:cosmic_numeriics/services/firebase_service/auth_services.dart';
import 'package:cosmic_numeriics/widget/Button/rectangle_elevated_button.dart';
import 'package:cosmic_numeriics/widget/appbar_widgets/appbar_widget.dart';
import 'package:cosmic_numeriics/widget/appbar_widgets/decorative_appbar_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UpdateUserDetails extends StatefulWidget {
  final String name;
  final String email;
  final String dob;
  final String? gender;
  final String image;

  const UpdateUserDetails({
    super.key,
    required this.name,
    required this.email,
    required this.dob,
    required this.gender,
    required this.image,
  });

  @override
  State<UpdateUserDetails> createState() => _UpdateUserDetails();
}

class _UpdateUserDetails extends State<UpdateUserDetails> {
  late TextEditingController nameController = TextEditingController();
  late TextEditingController dobController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController genderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    dobController.text =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.dob));
    emailController.text = widget.email;
    genderController.text = widget.gender ?? "Male";
  }

  Uint8List? _file;

  Future<Uint8List?> pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      return await pickedFile.readAsBytes();
    } else {
      return null;
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Select Image"),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Camera'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List? file = await pickImage(ImageSource.camera);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Gallery'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List? file = await pickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.tryParse(widget.dob) ?? DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        dobController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 242, 222),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    DecorativeAppBar(
                      barHeight: MediaQuery.of(context).size.height * 0.24,
                      barPad: MediaQuery.of(context).size.height * 0.21,
                      radii: 30.r,
                      background: const Color.fromARGB(255, 255, 242, 222),
                      gradient1: const Color.fromARGB(255, 192, 40, 114),
                      gradient2: const Color.fromARGB(255, 255, 154, 111),
                      extra: appbar("assets/My_account/avatar.png",
                          "Update Details", context, () {
                        Navigator.pop(context);
                      }),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _file != null
                          ? Padding(
                              padding: EdgeInsets.only(left: 110.0.w),
                              child: Image.memory(
                                _file!,
                                height: 200.h,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(left: 110.0.w),
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 50.w,
                                    backgroundImage: NetworkImage(widget.image),
                                  ),
                                  Positioned(
                                    right: 0,
                                    left: 72.w,
                                    top: 0.08.sh,
                                    child: IconButton(
                                      onPressed: () {
                                        _selectImage(context);
                                      },
                                      icon: const Icon(
                                        Icons.camera_alt_outlined,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      SizedBox(
                        height: 20.h,
                      ),
                      const Text(
                        "Name",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(hintText: "Name"),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      const Text(
                        "Email",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(hintText: "Email"),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      const Text(
                        "DOB",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextField(
                        controller: dobController,
                        decoration: const InputDecoration(hintText: "DOB"),
                        readOnly: true,
                        onTap: () {
                          _selectDate(context);
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      const Text(
                        "Gender",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextField(
                        controller: genderController,
                        decoration: const InputDecoration(hintText: "Gender"),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: LoginRectangleElevatedButton(
                          width: double.infinity,
                          onPressed: () async {
                            log(dobController.text);
                            await AuthService.updateUserInfo(
                              name: nameController.text,
                              dob: dobController.text,
                              gender: genderController.text,
                              email: emailController.text,
                              file: _file,
                            );

                            // SharedServices.setDetails(name, dob, gender, profilepic)
                            Future.delayed(Duration.zero, () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            });
                          },
                          text: "Save",
                          color: const Color.fromARGB(255, 158, 18, 86),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

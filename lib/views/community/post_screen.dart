// ignore: file_names

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cosmic_numeriics/services/firebase_service/firestore_services.dart';
import 'package:cosmic_numeriics/views/community/edit_image.dart';
import 'package:cosmic_numeriics/widget/Button/rectangle_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PostScreen extends StatefulWidget {
  final String typeofpage;

  const PostScreen({super.key, required this.typeofpage});
  @override
  // ignore: library_private_types_in_public_api
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  List<Uint8List> _files = [];

  Future<void> _selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Create a post"),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Camera'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List? file = await pickImage(ImageSource.camera);
                if (file != null) {
                  setState(() {
                    _files.add(file);
                  });
                }
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Gallery'),
              onPressed: () async {
                Navigator.of(context).pop();
                List<Uint8List>? files = await pickImagesFromGallery();
                if (files != null) {
                  setState(() {
                    _files.addAll(files);
                  });
                }
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

  Future<Uint8List?> pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      return await pickedFile.readAsBytes();
    } else {
      return null;
    }
  }

  Future<List<Uint8List>?> pickImagesFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedFiles = await imagePicker.pickMultiImage();

    if (pickedFiles != null) {
      List<Uint8List> files = [];
      for (var pickedFile in pickedFiles) {
        files.add(await pickedFile.readAsBytes());
      }
      return files;
    } else {
      return null;
    }
  }

  Future<void> _editImage(Uint8List image, int index) async {
    final editedImage = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageEditScreen(image: image),
      ),
    );

    if (editedImage != null) {
      setState(() {
        _files[index] = editedImage;
      });
    }
  }

  int _current = 0;

  final CarouselSliderController _carouselController =
      CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 0.11.sh,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25)),
                    color: Color.fromARGB(255, 158, 18, 86)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30.sp,
                      ),
                    ),
                    const Text(
                      "Add Post",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await _handlePostNow();
                      },
                      child: Container(
                        height: 35.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: const Center(
                          child: Text(
                            "Post Now",
                            style: TextStyle(
                                color: Color.fromARGB(255, 158, 18, 86),
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 560,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
                      child: TextFormField(
                        controller: _descriptionController,
                        maxLines: 6,
                        decoration: InputDecoration(
                            hintText: 'Write something about your post...',
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(5)),
                            filled: true,
                            fillColor:
                                const Color.fromARGB(255, 222, 222, 222)),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _selectImage(context);
                          },
                          child: Container(
                            width: 160.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 225, 224, 224))),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image,
                                  color: Color.fromARGB(255, 158, 18, 86),
                                ),
                                Text(
                                  "   Image",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Feature available soon")));
                          },
                          child: Container(
                            width: 160.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 225, 224, 224))),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.video_camera_back,
                                  color: Color.fromARGB(255, 158, 18, 86),
                                ),
                                Text(
                                  "   Video",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    _files.isNotEmpty
                        ? Container(
                            height: 0.3.sh,
                            width: 0.9.sw,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.red),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: _files.length == 1
                                ? Stack(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.memory(
                                        _files[0],
                                        height: 0.3.sh,
                                        width: 0.9.sw,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 4.h,
                                      right: 9.w,
                                      child: Container(
                                        height: 28.h,
                                        width: 40.w,
                                        color: Colors.white,
                                        child: Center(
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.crop,
                                              color: Colors.black,
                                              size: 22,
                                            ),
                                            onPressed: () {
                                              _editImage(_files[0], 0);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ])
                                : Column(
                                    children: [
                                      CarouselSlider.builder(
                                        carouselController: _carouselController,
                                        options: CarouselOptions(
                                          height: height * 0.27,
                                          enlargeCenterPage: true,
                                          enableInfiniteScroll: false,
                                          viewportFraction: 1.0,
                                          onPageChanged: (index, reason) {
                                            setState(() {
                                              _current = index;
                                            });
                                          },
                                        ),
                                        itemCount: _files.length,
                                        itemBuilder: (context, index, realIdx) {
                                          return Stack(
                                            children: [
                                              Image.memory(
                                                _files[index],
                                                height: 0.4.sh,
                                                width: 0.5.sw,
                                                fit: BoxFit.cover,
                                              ),
                                              Positioned(
                                                top: 4.h,
                                                right: 9.w,
                                                child: Container(
                                                  height: 28.h,
                                                  width: 40.w,
                                                  color: Colors.white,
                                                  child: Center(
                                                    child: IconButton(
                                                      icon: const Icon(
                                                        Icons.crop,
                                                        color: Colors.black,
                                                        size: 22,
                                                      ),
                                                      onPressed: () {
                                                        _editImage(
                                                            _files[index],
                                                            index);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                      SizedBox(height: 10.h),
                                      AnimatedSmoothIndicator(
                                        activeIndex: _current,
                                        count: _files.length,
                                        effect: const WormEffect(
                                          dotWidth: 10.0,
                                          dotHeight: 10.0,
                                          activeDotColor:
                                              Color.fromARGB(255, 158, 18, 86),
                                          dotColor: Colors.grey,
                                        ),
                                        onDotClicked: (index) {
                                          _carouselController
                                              .animateToPage(index);
                                        },
                                      ),
                                    ],
                                  ),
                          )
                        : Container(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: LoginRectangleElevatedButton(
                    color: const Color.fromARGB(255, 158, 18, 86),
                    text: "Post Now",
                    onPressed: () async {
                      await _handlePostNow();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handlePostNow() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Color.fromARGB(255, 158, 18, 86),
        content: Text("Posting..."),
      ),
    );
    Navigator.pop(context);
    await _uploadPost();
  }

  Future<void> _uploadPost() async {
    bool resultFile = false;
    bool resultArticle = false;

    if (_files.isNotEmpty) {
      resultFile = await StorageServices.uploadPost(
        files: _files,
        description: _descriptionController.text,
      );
    } else if (_descriptionController.text.isNotEmpty && _files.isEmpty) {
      resultArticle = await StorageServices.uploadArticlePost(
        description: _descriptionController.text,
      );
    }
    String message;
    Color backgroundColor;

    if (resultFile == true) {
      message = 'Post added successfully!';
      backgroundColor = Colors.green;
    } else if (resultArticle == true) {
      message = 'Article added successfully!';
      backgroundColor = Colors.green;
    } else {
      message = 'Please choose image and add description';
      backgroundColor = Colors.red;
    }

    if (mounted) {
      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: backgroundColor,
            content: Text(message),
          ),
        );
      });

      _descriptionController.clear();
      setState(() {
        _files = [];
      });
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}

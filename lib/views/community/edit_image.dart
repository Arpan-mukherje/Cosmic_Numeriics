import 'dart:typed_data';
import 'package:cosmic_numeriics/widget/Button/rectangle_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';

class ImageEditScreen extends StatefulWidget {
  final Uint8List image;

  const ImageEditScreen({Key? key, required this.image}) : super(key: key);

  @override
  _ImageEditScreenState createState() => _ImageEditScreenState();
}

class _ImageEditScreenState extends State<ImageEditScreen> {
  Uint8List? _editedImage;

  @override
  void initState() {
    super.initState();
    _editedImage = widget.image;
  }

  Future<void> _cropImage() async {
    final tempFile = await _saveImageToTempFile(widget.image);
    if (tempFile != null) {
      try {
        CroppedFile? croppedImg = await ImageCropper().cropImage(
          sourcePath: tempFile.path,
          compressQuality: 100,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop',
              cropGridColor: Colors.black,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
            ),
            IOSUiSettings(title: 'Crop'),
          ],
        );
        if (croppedImg != null) {
          final croppedImage = await croppedImg.readAsBytes();
          setState(() {
            _editedImage = croppedImage;
          });
        }
      } catch (e) {
        print(e);
      } finally {
        await tempFile.delete();
      }
    }
  }

  Future<File?> _saveImageToTempFile(Uint8List image) async {
    final tempDir = Directory.systemTemp;
    final tempFile = File('${tempDir.path}/temp_image.png');
    await tempFile.writeAsBytes(image);
    return tempFile;
  }

  void _saveAndReturn() {
    Navigator.pop(context, _editedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 158, 18, 86),
        title: const Text(
          'Edit Image',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LoginRectangleElevatedButton(
              text: "Done",
              color: Colors.white,
              onPressed: _saveAndReturn,
              textColor: Colors.black,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          if (_editedImage != null)
            SizedBox(height: 300, child: Image.memory(_editedImage!)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              LoginRectangleElevatedButton(
                color: const Color.fromARGB(255, 158, 18, 86),
                onPressed: _cropImage,
                text: "Edit",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

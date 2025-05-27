import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_repo/ditch_text.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});
  final void Function(File image) onPickImage;
  @override
  State<ImageInput> createState() {
    return _ImageInput();
  }
}

class _ImageInput extends State<ImageInput> {
  File? _pickedImage;
  void _takePicture() async {
    final imagePicker = ImagePicker();
    final takenImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (takenImage == null) {
      return;
    }
    setState(() {
      _pickedImage = File(takenImage.path);
    });
    widget.onPickImage(_pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      height: 200,
      width: double.infinity * 0.8,
      alignment: Alignment.center,
      child:
          _pickedImage != null
              ? GestureDetector(
                onTap: _takePicture,
                child: Image.file(
                  _pickedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              )
              : TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 57, 55, 55),
                ),
                onPressed: _takePicture,
                label: DitchText(text: 'Take Picture', fontSize: 18),
                icon: Icon(Icons.camera),
              ),
    );
  }
}

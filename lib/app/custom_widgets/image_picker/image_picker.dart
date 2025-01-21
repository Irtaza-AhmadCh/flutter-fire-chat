

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ReusableImagePicker extends StatefulWidget {
  final double containerSize;
  final IconData personIcon;
  final IconData cameraIcon;
  final Color containerColor;
  final Color iconColor;
  final Function(String?) onImageSelected;

  const ReusableImagePicker({
    Key? key,
    required this.containerSize,
    this.personIcon = Icons.person,
    this.cameraIcon = Icons.camera_alt,
    this.containerColor = Colors.grey,
    this.iconColor = Colors.white,
    required this.onImageSelected,
  }) : super(key: key);

  @override
  State<ReusableImagePicker> createState() => _ReusableImagePickerState();
}

class _ReusableImagePickerState extends State<ReusableImagePicker> {
  String? _imagePath;

  Future<void> _pickImage(ImageSource pickerSource) async {
    final picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
      source: pickerSource,
    );
    if (pickedImage != null) {
      setState(() {
        _imagePath = pickedImage.path;
      });
      widget.onImageSelected(_imagePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showPickImageOptionsDialog(context, onCameraTap: (){
          _pickImage(ImageSource.camera);
        }, onGalleryTap: (){
          _pickImage(ImageSource.camera);
        },);
      },
      child: Stack(
        children: [
          Container(
            height: widget.containerSize,
            width: widget.containerSize,
            decoration: BoxDecoration(
              color: widget.containerColor,
              shape: BoxShape.circle,
              image: _imagePath != null
                  ? DecorationImage(
                image: FileImage(File(_imagePath!)),
                fit: BoxFit.cover,
              )
                  : null,
            ),
            child: _imagePath == null
                ? Icon(
              widget.personIcon,
              color: widget.iconColor,
              size: widget.containerSize / 2,
            )
                : null,
          ),
          Positioned(
            bottom: 0,
            right: widget.containerSize * 0.05,
            child: Container(
              height: widget.containerSize * 0.25,
              width: widget.containerSize * 0.25,
              decoration: BoxDecoration(
                color: widget.iconColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.containerColor,
                  width: 2.0,
                ),
              ),
              child: Icon(
                widget.cameraIcon,
                size: widget.containerSize * 0.15,
                color: widget.containerColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static showPickImageOptionsDialog(
      BuildContext context, {
        required VoidCallback onCameraTap,
        required VoidCallback onGalleryTap,
      }) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: onCameraTap,
            child: const Text("Camera"),
          ),
          CupertinoActionSheetAction(
            onPressed: onGalleryTap,
            child: const Text("Gallery"),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
      ),
    );
  }
}



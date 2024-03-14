import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:urban_culture/utils/urban_culture_colors.dart';

extension EmptySizedBox on num {
  SizedBox get height => SizedBox(height: toDouble());
  SizedBox get width => SizedBox(width: toDouble());
}

Future getImage() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
  if (pickedFile == null) return;

  final croppedImage = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0));
  if (croppedImage == null) return;

  return File(croppedImage.path);
}

enum MessageType { error, warning, success }

String getTitle(MessageType type) {
  switch (type) {
    case MessageType.error:
      return "Error";
    case MessageType.success:
      return "Success";
    case MessageType.warning:
      return "Warning";
  }
}

getColor(MessageType type) {
  switch (type) {
    case MessageType.error:
      return UrbanCultureColors.alertRed;
    case MessageType.success:
      return UrbanCultureColors.greenColor;
    case MessageType.warning:
      return UrbanCultureColors.warningColor;
  }
}

Icon getIcon(MessageType type) {
  switch (type) {
    case MessageType.error:
      return const Icon(
        Icons.cancel,
        color: Colors.white,
      );
    case MessageType.success:
      return const Icon(
        Icons.check_circle_outline_outlined,
        color: Colors.white,
      );
    case MessageType.warning:
      return const Icon(
        Icons.warning_amber,
        color: Colors.white,
      );
  }
}

showSnackbar(MessageType type, {message, context}) {
  var snackBar = SnackBar(
    content: Text(
      message,
      maxLines: 3,
    ),
    backgroundColor: getColor(type),
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.up,
    elevation: 0,
    duration: Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

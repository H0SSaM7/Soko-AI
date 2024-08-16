import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> getImage() async {
  final imagpicker = ImagePicker();
  final image = await imagpicker.pickImage(source: ImageSource.gallery);
  if (image == null) {
    return null;
  }
  return File(image.path);
}

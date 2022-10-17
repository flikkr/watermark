import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

Future<PlatformFile?> uploadImage() async {
  try {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return null;
    final platformFile = result.files.first;
    return platformFile;
  } on StateError catch (_) {
    return null;
  }
}

Future<Uint8List?> getImageBytes(String path) async {
  final file = File(path);
  final bytes = await file.readAsBytes();
  return bytes;
}

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

 class ImageCubit extends Cubit<Uint8List?> {
  ImageCubit([Uint8List? initialState]) : super(initialState);

  void updateImage(Uint8List imageBytes) => emit(imageBytes);

  Future<void> uploadImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return;
    final path = result.files.first.path;
    if (path == null) return;
    final file = File(path);
    emit(file.readAsBytesSync());
  }

  void removeImage() => emit(null);
}


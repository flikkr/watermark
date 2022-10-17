import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ImageCubit extends Cubit<Uint8List?> {
  ImageCubit({Uint8List? initialState}) : super(initialState);

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

class EditedImageCubit extends ImageCubit {}

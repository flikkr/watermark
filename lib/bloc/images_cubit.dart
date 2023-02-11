// ignore_for_file: use_build_context_synchronously
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yawt/bloc/watermark_cubit.dart';
import 'package:yawt/model/watermark_settings.dart';
import 'package:yawt/model/image_settings.dart';

class ImagesCubit extends Cubit<List<ImageSettings>> {
  ImagesCubit() : super([]);

  Future<void> uploadImages(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
      withData: true,
    );
    if (result == null) return;
    final watermark = BlocProvider.of<WatermarkCubit>(context).state;
    final images = result.files.map(
      (file) => ImageSettings(
        imageFile: file,
        watermarkSettings: watermark != null
            ? WatermarkSettings(
                height: watermark.initialHeight,
                width: watermark.initialWidth,
              )
            : null,
      ),
    );

    emit([...super.state, ...images]);
  }

  void setState(List<ImageSettings> images) => emit(images);

  void clearImages() => emit([]);

  void updateWatermarkXyPosition(int index, Offset newOffset) {
    final allSettings = List<ImageSettings>.from(super.state);
    final settings = allSettings[index];
    WatermarkSettings? watermark = settings.watermarkSettings;
    if (watermark == null) return;
    Offset offset = watermark.offset;
    offset += newOffset;
    watermark = watermark.copyWith(offset: offset);
    allSettings[index] = settings.copyWith(watermarkSettings: watermark);
    emit(allSettings);
  }
}

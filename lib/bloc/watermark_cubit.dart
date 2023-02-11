// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yawt/bloc/images_cubit.dart';
import 'package:yawt/model/image_settings.dart';
import 'package:yawt/model/watermark.dart';
import 'package:yawt/model/watermark_settings.dart';
import 'package:yawt/utils/file_service.dart';

class WatermarkCubit extends Cubit<Watermark?> {
  WatermarkCubit([super.initialState]);

  Future<void> uploadWatermark(BuildContext context) async {
    final file = await uploadImage();
    if (file == null) return;

    final bytes = file.path != null ? await getImageBytes(file.path!) : null;
    if (bytes == null) return;

    final img = await decodeImageFromList(bytes);
    final watermark = Watermark(
      bytes: bytes,
      initialHeight: img.height.toDouble(),
      initialWidth: img.width.toDouble(),
    );
    emit(watermark);

    final images = BlocProvider.of<ImagesCubit>(context).state;
    if (images.isNotEmpty) {
      List<ImageSettings> temp = List.from(images);
      for (int i = 0; i < images.length; i++) {
        temp[i] = images[i].copyWith(
          watermarkSettings: WatermarkSettings(
            height: watermark.initialHeight,
            width: watermark.initialWidth,
          ),
        );
      }
      BlocProvider.of<ImagesCubit>(context).setState(temp);
    }
  }
}

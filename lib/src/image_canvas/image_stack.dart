// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yawt/bloc/images_cubit.dart';
import 'package:yawt/bloc/selected_image_cubit.dart';
import 'package:yawt/bloc/watermark_cubit.dart';
import 'package:yawt/model/watermark.dart';
import 'package:yawt/model/watermark_settings.dart';
import 'package:yawt/model/image_settings.dart';
import 'package:yawt/src/widgets/adjustable_widget/adjustable_widget.dart';

class ImageStack extends StatelessWidget {
  final ImageSettings imageSettings;

  const ImageStack({
    Key? key,
    required this.imageSettings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<WatermarkCubit, Watermark?>(
        builder: (context, watermark) {
          return Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.hardEdge,
            children: [
              // the main image
              Image.memory(imageSettings.imageFile.bytes!),
              ...displayWatermark(context, watermark, imageSettings.watermarkSettings),
            ],
          );
        },
      ),
    );
  }

  List<Widget> displayWatermark(BuildContext context, Watermark? watermark, WatermarkSettings? settings) {
    if (watermark == null || settings == null) {
      return [];
    }
    return [
      AdjustableWidget(
        opacity: settings.opacity,
        rotation: settings.rotation,
        height: settings.height,
        width: settings.width,
        x: settings.offset.dx,
        y: settings.offset.dy,
        child: Image.memory(watermark.bytes),
        onDragEnd: (offset) {
          final index = BlocProvider.of<SelectedImageCubit>(context).state;
          BlocProvider.of<ImagesCubit>(context).updateWatermarkXyPosition(index, offset);
        },
      )
    ];
  }
}

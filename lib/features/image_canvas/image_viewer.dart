import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watermark/features/adjustable_widget/adjustable_widget.dart';
import 'package:watermark/features/image_edit_panel/image_settings.dart';
import 'package:watermark/features/image_edit_panel/image_settings_cubit.dart';

class ImageViewer extends StatelessWidget {
  final Uint8List image;

  const ImageViewer({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      maxScale: 5,
      child: BlocBuilder<ImageSettingsCubit, ImageSettings>(
        builder: (context, settings) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // the main image
              Image.memory(image),
              ...displayWatermark(settings),
            ],
          );
        },
      ),
    );
  }

  List<Widget> displayWatermark(ImageSettings settings) {
    final bytes = settings.watermarkBytes;
    if (bytes == null) return [];
    // if (settings.repeated) {}

    // RotationTransition(
    //                         turns: AlwaysStoppedAnimation(imageSettings.rotation),
    //                         child: Image.memory(data),
    //                       );

    return [
      AdjustableWidget(
        opacity: settings.opacity,
        rotation: settings.rotation,
        height: 300, //TODO: fix height/width
        width: 300,
        child: Image.memory(bytes, fit: BoxFit.fill),
      )
    ];
  }
}

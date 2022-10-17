import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      child: BlocBuilder<ImageSettingsCubit, ImageSettings>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Image.memory(image),
              ...displayWatermark(state),
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
      Positioned(
        child: SizedBox(
          child: RotationTransition(
            turns: AlwaysStoppedAnimation(settings.rotation ?? 0),
            child: Image.memory(bytes),
          ),
        ),
      ),
    ];
  }
}

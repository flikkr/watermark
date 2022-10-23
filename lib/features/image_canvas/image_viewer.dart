import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watermark/features/adjustable_widget/adjustable_widget.dart';
import 'package:watermark/features/image_canvas/image_viewer_interaction_cubit.dart';
import 'package:watermark/features/image_edit_panel/image_settings.dart';
import 'package:watermark/features/image_edit_panel/image_settings_cubit.dart';

class ImageViewer extends StatelessWidget {
  final Uint8List image;
  final TransformationController _transformationController = TransformationController(Matrix4.identity());

  ImageViewer({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return InteractiveViewer(
        constrained: true,
        maxScale: 5,
        transformationController: _transformationController,
        onInteractionUpdate: (scaleUpdateDetails) {
          BlocProvider.of<ImageViewerInteractionCubit>(context).updateInteraction(ImageViewerInteraction(
            scale: _transformationController.value.getMaxScaleOnAxis(),
            rotation: scaleUpdateDetails.rotation,
            focalPoint: scaleUpdateDetails.focalPoint,
            focalPointDelta: scaleUpdateDetails.focalPointDelta,
            localFocalPoint: scaleUpdateDetails.localFocalPoint,
          ));
        },
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
    });
  }

  List<Widget> displayWatermark(ImageSettings settings) {
    final bytes = settings.watermarkBytes;
    if (bytes == null) return [];

    return [
      AdjustableWidget(
        opacity: settings.opacity,
        rotation: settings.rotation,
        height: 300!, //TODO: fix
        width: 300!,
        child: Image.memory(bytes),
      )
    ];
  }
}

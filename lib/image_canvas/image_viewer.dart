import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watermark/image_canvas/image_cubit.dart';

class ImageViewer extends StatelessWidget {
  final Uint8List image;

  const ImageViewer({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      child: BlocBuilder<WatermarkImageCubit, Uint8List?>(
        builder: (context, state) {
          if (state == null) {
            return Container();
          } else {
            return Stack(
              children: [
                Image.memory(image),
                // ...displayWatermark(state),
              ],
            );
          }
        },
      ),
    );
  }

  // List<Widget> displayWatermark(Uint8List watermark) {}
}

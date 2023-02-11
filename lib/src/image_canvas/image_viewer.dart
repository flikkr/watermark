import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yawt/src/widgets/adjustable_widget/adjustable_widget.dart';
import 'package:yawt/model/watermark_settings.dart';
import 'package:yawt/model/image_settings.dart';

import 'image_stack.dart';

class ImageViewer extends StatelessWidget {
  final ImageSettings imageSettings;

  const ImageViewer({
    super.key,
    required this.imageSettings,
  });

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      constrained: true,
      maxScale: 5,
      child: ImageStack(imageSettings: imageSettings),
    );
  }
}

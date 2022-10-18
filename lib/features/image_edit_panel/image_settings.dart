import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class ImageSettings {
  PlatformFile? watermark;
  Uint8List? watermarkBytes;
  bool repeated;
  double? height;
  double? width;
  double? initialHeight;
  double? initialWidth;
  double rotation;
  double opacity;
  double? xSpacing;
  double? ySpacing;
  double? xOffset;
  double? yOffset;

  ImageSettings({
    this.watermark,
    this.watermarkBytes,
    this.repeated = false,
    this.height,
    this.width,
    this.initialHeight,
    this.initialWidth,
    this.rotation = 0,
    this.opacity = 1.0,
    this.xSpacing,
    this.ySpacing,
    this.xOffset,
    this.yOffset,
  });

  ImageSettings copyWith({
    PlatformFile? watermark,
    Uint8List? watermarkBytes,
    bool? repeated,
    double? height,
    double? width,
    double? initialHeight,
    double? initialWidth,
    double? rotation,
    double? xSpacing,
    double? ySpacing,
    double? xOffset,
    double? yOffset,
    double? opacity,
  }) {
    return ImageSettings(
      watermark: watermark ?? this.watermark,
      watermarkBytes: watermarkBytes ?? this.watermarkBytes,
      repeated: repeated ?? this.repeated,
      height: height ?? this.height,
      width: width ?? this.width,
      initialHeight: initialHeight ?? this.initialHeight,
      initialWidth: initialWidth ?? this.initialWidth,
      rotation: rotation ?? this.rotation,
      xSpacing: xSpacing ?? this.xSpacing,
      ySpacing: ySpacing ?? this.ySpacing,
      xOffset: xOffset ?? this.xOffset,
      yOffset: yOffset ?? this.yOffset,
      opacity: opacity ?? this.opacity,
    );
  }
}

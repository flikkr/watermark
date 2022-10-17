import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class ImageSettings {
  PlatformFile? watermark;
  Uint8List? watermarkBytes;
  bool repeated;
  double? height;
  double? width;
  double? rotation;
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
    this.rotation,
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
    double? rotation,
    double? xSpacing,
    double? ySpacing,
    double? xOffset,
    double? yOffset,
  }) {
    return ImageSettings(
      watermark: watermark ?? this.watermark,
      watermarkBytes: watermarkBytes ?? this.watermarkBytes,
      repeated: repeated ?? this.repeated,
      height: height ?? this.height,
      width: width ?? this.width,
      rotation: rotation ?? this.rotation,
      xSpacing: xSpacing ?? this.xSpacing,
      ySpacing: ySpacing ?? this.ySpacing,
      xOffset: xOffset ?? this.xOffset,
      yOffset: yOffset ?? this.yOffset,
    );
  }
}

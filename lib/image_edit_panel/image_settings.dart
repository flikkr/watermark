// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ImageSettings {
  Uint8List? watermark;
  bool repeated;
  double rotation;
  double xSpacing;
  double ySpacing;
  double xOffset;
  double yOffset;

  ImageSettings({
    this.watermark,
    this.repeated = false,
    this.rotation = 0,
    this.xSpacing = 0,
    this.ySpacing = 0,
    this.xOffset = 0,
    this.yOffset = 0,
  });

  ImageSettings copyWith({
    Uint8List? watermark,
    bool? repeated,
    double? rotation,
    double? xSpacing,
    double? ySpacing,
    double? xOffset,
    double? yOffset,
  }) {
    return ImageSettings(
      watermark: watermark ?? this.watermark,
      repeated: repeated ?? this.repeated,
      rotation: rotation ?? this.rotation,
      xSpacing: xSpacing ?? this.xSpacing,
      ySpacing: ySpacing ?? this.ySpacing,
      xOffset: xOffset ?? this.xOffset,
      yOffset: yOffset ?? this.yOffset,
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WatermarkSettings {
  final double height;
  final double width;
  final bool repeated;
  final double rotation;
  final double opacity;
  final double xSpacing;
  final double ySpacing;
  final Offset offset;

  WatermarkSettings({
    required this.height,
    required this.width,
    this.repeated = false,
    this.rotation = 0,
    this.opacity = 1.0,
    this.xSpacing = 0,
    this.ySpacing = 0,
    Offset? offset,
  }) : offset = offset ?? const Offset(0, 0);

  WatermarkSettings copyWith({
    double? height,
    double? width,
    bool? repeated,
    double? rotation,
    double? opacity,
    double? xSpacing,
    double? ySpacing,
    Offset? offset,
  }) {
    return WatermarkSettings(
      height: height ?? this.height,
      width: width ?? this.width,
      repeated: repeated ?? this.repeated,
      rotation: rotation ?? this.rotation,
      opacity: opacity ?? this.opacity,
      xSpacing: xSpacing ?? this.xSpacing,
      ySpacing: ySpacing ?? this.ySpacing,
      offset: offset ?? this.offset,
    );
  }
}

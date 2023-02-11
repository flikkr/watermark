// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

class Watermark {
  final Uint8List bytes;
  final double initialHeight;
  final double initialWidth;

  Watermark({
    required this.bytes,
    required this.initialHeight,
    required this.initialWidth,
  });

  Watermark copyWith({
    Uint8List? bytes,
    double? initialHeight,
    double? initialWidth,
  }) {
    return Watermark(
      bytes: bytes ?? this.bytes,
      initialHeight: initialHeight ?? this.initialHeight,
      initialWidth: initialWidth ?? this.initialWidth,
    );
  }
}

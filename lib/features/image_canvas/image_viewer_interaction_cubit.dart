// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageViewerInteractionCubit extends Cubit<ImageViewerInteraction> {
  ImageViewerInteractionCubit() : super(ImageViewerInteraction());

  void updateInteraction(ImageViewerInteraction interaction) => emit(interaction);
}

class ImageViewerInteraction {
  final double scale;
  final double rotation;
  final Offset focalPoint;
  final Offset focalPointDelta;
  final Offset localFocalPoint;

  ImageViewerInteraction({
    this.scale = 0,
    this.rotation = 0,
    Offset? focalPoint,
    Offset? focalPointDelta,
    Offset? localFocalPoint,
  })  : focalPoint = focalPoint ?? const Offset(0, 0),
        focalPointDelta = focalPointDelta ?? const Offset(0, 0),
        localFocalPoint = localFocalPoint ?? const Offset(0, 0);

  @override
  bool operator ==(covariant ImageViewerInteraction other) {
    if (identical(this, other) && runtimeType == other.runtimeType) return true;

    return other.scale == scale &&
        other.rotation == rotation &&
        other.focalPoint == focalPoint &&
        other.focalPointDelta == focalPointDelta &&
        other.localFocalPoint == localFocalPoint;
  }

  @override
  int get hashCode {
    return scale.hashCode ^
        rotation.hashCode ^
        focalPoint.hashCode ^
        focalPointDelta.hashCode ^
        localFocalPoint.hashCode;
  }
}

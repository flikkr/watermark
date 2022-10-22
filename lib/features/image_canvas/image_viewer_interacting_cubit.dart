import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageViewerInteractingCubit extends Cubit<double?> {
  ImageViewerInteractingCubit({double? initialState}) : super(initialState);

  void updateIsInteracting(double scale) => emit(scale);
}

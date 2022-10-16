import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watermark/image_edit_panel/image_settings.dart';

class ImageSettingsCubit extends Cubit<ImageSettings> {
  ImageSettingsCubit([ImageSettings? initialState]) : super(initialState ?? ImageSettings());

  void updateSettings(ImageSettings settings) => emit(settings);
}

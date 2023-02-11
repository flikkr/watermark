import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

import 'watermark_settings.dart';

class ImageSettings extends Equatable {
  final PlatformFile imageFile;
  final WatermarkSettings? watermarkSettings;

  const ImageSettings({
    required this.imageFile,
    this.watermarkSettings,
  });

  ImageSettings copyWith({
    PlatformFile? imageFile,
    WatermarkSettings? watermarkSettings,
  }) {
    return ImageSettings(
      imageFile: imageFile ?? this.imageFile,
      watermarkSettings: watermarkSettings ?? this.watermarkSettings,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [imageFile, watermarkSettings];
}

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ImageEditPanelItem extends StatelessWidget {
  final PlatformFile file;
  final bool isFocused;
  final Function()? onTap;

  const ImageEditPanelItem({
    super.key,
    required this.file,
    this.isFocused = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final previewWidget = file.bytes == null
        ? const Icon(Icons.broken_image)
        : SizedBox(
            width: 40,
            child: Image.memory(file.bytes!),
          );

    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      leading: previewWidget,
      title: Text(file.name),
      selectedTileColor: Colors.blue,
      selectedColor: Colors.black,
      selected: isFocused,
    );
  }
}

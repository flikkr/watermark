import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yawt/src/widgets/image_side_panel/add_images_section.dart';
import 'package:yawt/src/widgets/image_side_panel/add_watermark_section.dart';

class ImagePanel extends StatefulWidget {
  const ImagePanel({super.key});

  @override
  State<ImagePanel> createState() => _ImagePanelState();
}

class _ImagePanelState extends State<ImagePanel> {
  final heightController = TextEditingController();
  final widthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: const [
          AddImagesSection(),
          Divider(height: 0),
          AddWatermarkSection(),
        ],
      ),
    );
  }

  Widget displayNumericalField({
    bool isHeight = true,
    void Function(String val)? onChanged,
  }) {
    return Expanded(
      child: TextField(
        decoration: InputDecoration(
          suffix: Text(isHeight ? "Height" : "Width", style: const TextStyle(color: Colors.black45)),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: isHeight ? heightController : widthController,
        onChanged: onChanged,
      ),
    );
  }
}

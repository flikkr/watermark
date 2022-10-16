import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:watermark/image_canvas/image_cubit.dart';
import 'package:watermark/image_edit_panel/image_edit_panel_item.dart';
import 'package:watermark/image_edit_panel/image_settings.dart';

class ImageEditPanel extends StatefulWidget {
  final void Function(ImageSettings imageSettings)? onUpdateSettings;

  const ImageEditPanel({
    super.key,
    this.onUpdateSettings,
  });

  @override
  State<ImageEditPanel> createState() => _ImageEditPanelState();
}

class _ImageEditPanelState extends State<ImageEditPanel> {
  // final GlobalKey _formKey = GlobalKey<FormBuilderState>();
  late ImageSettings imageSettings;

  @override
  void initState() {
    super.initState();
    imageSettings = ImageSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ImageEditPanelItem(
              label: 'Rotation',
              child: Slider(
                value: imageSettings.rotation * 360,
                min: 0,
                max: 360,
                label: "Rotation",
                onChanged: (value) {
                  setState(() {
                    imageSettings = imageSettings.copyWith(rotation: value / 360);
                    widget.onUpdateSettings?.call(imageSettings);
                  });
                },
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.upload),
                        label: const Text('Upload watermark'),
                        onPressed: () {
                          BlocProvider.of<WatermarkImageCubit>(context).uploadImage();
                        },
                      ),
                      BlocBuilder<WatermarkImageCubit, Uint8List?>(
                        builder: (context, state) {
                          if (state == null) {
                            return Container();
                          } else {
                            return ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: 100),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Image.memory(state),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

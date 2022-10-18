import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:watermark/features/image_canvas/image_cubit.dart';
import 'package:watermark/features/image_edit_panel/image_edit_panel_item.dart';
import 'package:watermark/features/image_edit_panel/image_settings.dart';
import 'package:watermark/features/image_edit_panel/image_settings_cubit.dart';
import 'package:watermark/utils/file_service.dart';

class ImageEditPanel extends StatefulWidget {
  const ImageEditPanel({super.key});

  @override
  State<ImageEditPanel> createState() => _ImageEditPanelState();
}

class _ImageEditPanelState extends State<ImageEditPanel> {
  final heightController = TextEditingController();
  final widthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<ImageSettingsCubit, ImageSettings>(
          builder: (context, settings) {
            return Column(
              children: [
                ImageEditPanelItem(
                  label: 'Rotation',
                  child: Slider(
                    value: settings.rotation * 360,
                    min: 0,
                    max: 360,
                    onChanged: (value) {
                      setState(() {
                        final newSettings = settings.copyWith(rotation: value / 360);
                        BlocProvider.of<ImageSettingsCubit>(context).updateSettings(newSettings);
                      });
                    },
                  ),
                ),
                ImageEditPanelItem(
                  label: 'Opacity',
                  child: Slider(
                    value: settings.opacity,
                    min: 0,
                    max: 1.0,
                    onChanged: (value) {
                      setState(() {
                        final newSettings = settings.copyWith(opacity: value);
                        BlocProvider.of<ImageSettingsCubit>(context).updateSettings(newSettings);
                      });
                    },
                  ),
                ),
                ImageEditPanelItem(
                  label: 'Size',
                  gap: 10,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          settings = settings.copyWith(
                            height: settings.initialHeight,
                            width: settings.initialWidth,
                          );
                          BlocProvider.of<ImageSettingsCubit>(context).updateSettings(settings);
                        },
                        icon: const Icon(Icons.aspect_ratio),
                      ),
                      const SizedBox(width: 10),
                      displayNumericalField(
                        onChanged: (val) {
                          settings = settings.copyWith(height: double.tryParse(val) ?? 0);
                          BlocProvider.of<ImageSettingsCubit>(context).updateSettings(settings);
                        },
                      ),
                      const SizedBox(width: 10),
                      displayNumericalField(
                        isHeight: false,
                        onChanged: (val) {
                          settings = settings.copyWith(width: double.tryParse(val) ?? 0);
                          BlocProvider.of<ImageSettingsCubit>(context).updateSettings(settings);
                        },
                      ),
                    ],
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
                              BlocProvider.of<ImageSettingsCubit>(context).uploadWatermark(context);
                            },
                          ),
                          BlocBuilder<ImageSettingsCubit, ImageSettings>(
                            builder: (context, state) {
                              final bytes = state.watermarkBytes;
                              if (bytes == null) {
                                return Container();
                              } else {
                                return ConstrainedBox(
                                  constraints: const BoxConstraints(maxHeight: 100),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Image.memory(bytes),
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
            );
          },
        ),
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

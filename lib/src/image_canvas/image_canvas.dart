import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yawt/bloc/images_cubit.dart';
import 'package:yawt/bloc/selected_image_cubit.dart';
import 'package:yawt/src/image_canvas/image_viewer.dart';
import 'package:yawt/model/image_settings.dart';

class ImageCanvas extends StatefulWidget {
  const ImageCanvas({super.key});

  @override
  State<ImageCanvas> createState() => _ImageCanvasState();
}

class _ImageCanvasState extends State<ImageCanvas> {
  final PageController _pageController = PageController(keepPage: true);

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final double? percentage = _pageController.page;
      if (percentage == null) {
        return;
      }
      // check if whole number
      if ((percentage % 1) == 0) {
        BlocProvider.of<SelectedImageCubit>(context).selectImage(percentage.toInt());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagesCubit, List<ImageSettings>>(
      builder: (context, files) {
        if (files.isEmpty) {
          return Container();
        } else {
          return BlocListener<SelectedImageCubit, int?>(
            listener: (context, state) {
              if (state != null) {
                _pageController.jumpToPage(
                  state,
                );
              }
            },
            child: PageView.builder(
              itemCount: files.length,
              controller: _pageController,
              itemBuilder: (context, index) {
                final settings = files[index];
                if (settings.imageFile.bytes == null) {
                  return const Icon(Icons.broken_image);
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey[300]!, width: 2),
                      ),
                      width: double.maxFinite,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ImageViewer(
                          key: ValueKey(index),
                          imageSettings: settings,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watermark/features/image_canvas/image_canvas.dart';
import 'package:watermark/features/image_canvas/image_cubit.dart';
import 'package:watermark/features/image_edit_panel/image_edit_panel.dart';

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Upload image'),
        onPressed: () {
          BlocProvider.of<ImageCubit>(context).uploadImage();
        },
      ),
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: const [
          ImageEditPanel(),
          Expanded(child: ImageCanvas()),
        ],
      ),
    );
  }
}

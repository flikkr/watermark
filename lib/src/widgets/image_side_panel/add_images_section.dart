import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yawt/bloc/images_cubit.dart';
import 'package:yawt/bloc/selected_image_cubit.dart';
import 'package:yawt/src/widgets/image_side_panel/image_side_panel_item.dart';
import 'package:yawt/model/image_settings.dart';
import 'package:yawt/src/widgets/common/styled_button.dart';

class AddImagesSection extends StatelessWidget {
  const AddImagesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Images', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Expanded(
              child: BlocBuilder<ImagesCubit, List<ImageSettings>>(
                builder: (context, files) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: files.length,
                    itemBuilder: (context, index) {
                      return BlocBuilder<SelectedImageCubit, int?>(
                        builder: (context, state) {
                          return ImageEditPanelItem(
                            file: files[index].imageFile,
                            isFocused: index == state,
                            onTap: () {
                              BlocProvider.of<SelectedImageCubit>(context).selectImage(index);
                            },
                          );
                        },
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 4),
                  );
                },
              ),
            ),
            const SizedBox(height: 4),
            StyledButton(
              icon: const Icon(Icons.upload),
              onTap: () => BlocProvider.of<ImagesCubit>(context).uploadImages(context),
            ),
          ],
        ),
      ),
    );
  }
}

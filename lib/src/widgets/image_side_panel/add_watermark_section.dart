import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yawt/bloc/watermark_cubit.dart';
import 'package:yawt/model/watermark.dart';
import 'package:yawt/src/widgets/common/styled_button.dart';

class AddWatermarkSection extends StatelessWidget {
  const AddWatermarkSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 100,
            child: BlocBuilder<WatermarkCubit, Watermark?>(
              builder: (context, state) {
                if (state == null) {
                  return Container();
                } else {
                  return Image.memory(state.bytes);
                }
              },
            ),
          ),
          const SizedBox(height: 10),
          StyledButton(
            icon: const Icon(Icons.upload),
            onTap: () => BlocProvider.of<WatermarkCubit>(context).uploadWatermark(context),
          ),
        ],
      ),
    );
  }
}

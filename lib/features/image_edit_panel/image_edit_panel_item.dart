import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ImageEditPanelItem extends StatelessWidget {
  final String? label;
  final Widget? child;

  const ImageEditPanelItem({
    super.key,
    this.label,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label ?? ''),
        SizedBox(
          height: 40,
          child: child,
        )
      ],
    );
  }
}

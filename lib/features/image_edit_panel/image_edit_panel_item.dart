import 'package:flutter/material.dart';

class ImageEditPanelItem extends StatelessWidget {
  final String? label;
  final double? gap;
  final Widget? child;

  const ImageEditPanelItem({
    super.key,
    this.label,
    this.gap,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label ?? ''),
        if (child != null && label != null) SizedBox(height: gap),
        child ?? Container(),
      ],
    );
  }
}

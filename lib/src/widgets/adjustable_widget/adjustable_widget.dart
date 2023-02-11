import 'package:flutter/material.dart';

class AdjustableWidget extends StatefulWidget {
  final Widget? child;
  final double height;
  final double width;
  final double rotation;
  final double opacity;
  final double? x;
  final double? y;
  final Function(Offset offset)? onDragEnd;

  const AdjustableWidget({
    super.key,
    required this.height,
    required this.width,
    this.child,
    this.rotation = 0,
    this.opacity = 1.0,
    this.y,
    this.x,
    this.onDragEnd,
  });

  @override
  State<AdjustableWidget> createState() => _AdjustableWidgetState();
}

class _AdjustableWidgetState extends State<AdjustableWidget> {
  final GlobalKey key = GlobalKey();
  bool isFocused = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final watermark = RotationTransition(
      turns: AlwaysStoppedAnimation(widget.rotation),
      child: Opacity(
        opacity: widget.opacity,
        child: SizedBox(
          height: widget.height,
          width: widget.width,
          child: widget.child,
        ),
      ),
    );

    return Positioned(
      key: key,
      left: widget.x,
      top: widget.y,
      child: Draggable(
        feedback: watermark,
        childWhenDragging: Container(),
        child: watermark,
        onDragEnd: (drag) {
          RenderBox renderBox = context.findRenderObject() as RenderBox;
          final dragDetails = renderBox.globalToLocal(drag.offset);
          widget.onDragEnd?.call(dragDetails);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:watermark/features/adjustable_widget/drag_handle.dart';
import 'package:watermark/features/image_edit_panel/image_settings.dart';

class AdjustableWidget extends StatefulWidget {
  final Widget? child;
  final double height;
  final double width;
  final double rotation;
  final double opacity;
  final double? bottom;
  final double? top;
  final double? left;
  final double? right;

  const AdjustableWidget({
    super.key,
    this.child,
    required this.height,
    required this.width,
    this.rotation = 0,
    this.opacity = 1.0,
    this.bottom,
    this.top,
    this.left,
    this.right,
  });

  @override
  State<AdjustableWidget> createState() => _AdjustableWidgetState();
}

class _AdjustableWidgetState extends State<AdjustableWidget> {
  final GlobalKey key = GlobalKey();
  static const double handleSize = 10;
  bool isFocused = true;
  double top = 0;
  double left = 0;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      addOverlay(context);
    });
  }

  Future<void> addOverlay(BuildContext context) async {
    RenderBox? renderBox = key.currentContext!.findRenderObject() as RenderBox?;
    Offset offset = renderBox!.localToGlobal(Offset.zero);
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // Container(
            //   height: widget.height,
            //   width: widget.width,
            //   decoration: BoxDecoration(
            //     border: Border.all(
            //       color: Colors.blue,
            //       width: 2,
            //       strokeAlign: StrokeAlign.outside,
            //     ),
            //   ),
            // ),
            Positioned(
              // left: -(handleSize / 2) - 1,
              // left: -20,
              left: offset.dx,
              top: offset.dy,
              child: DragHandle(
                height: widget.height - handleSize,
                width: handleSize,
                debugColor: Colors.red.withOpacity(0.5),
                hoverCursor: SystemMouseCursors.resizeLeftRight,
                onDrag: (dx, dy) {
                  print('$dx, $dy');
                },
              ),
            ),
          ],
        );
      },
    );
    overlay?.insert(overlayEntry);
  }

  // BoxDecoration(
  //         border: Border.all(
  //           color: Colors.blue,
  //           width: 2,
  //           strokeAlign: StrokeAlign.outside,
  //         ),
  //       ),

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: AlwaysStoppedAnimation(widget.rotation),
      child: Opacity(
        key: key,
        opacity: widget.opacity,
        child: widget.child,
      ),
    );
  }
}

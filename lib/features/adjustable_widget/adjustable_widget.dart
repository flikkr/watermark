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
  final LayerLink layerLink = LayerLink();
  static const double handleSize = 10;
  bool isFocused = true;
  double top = 0;
  double left = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<void> addOverlay(BuildContext context) async {
    RenderBox? renderBox = key.currentContext!.findRenderObject() as RenderBox?;
    Offset offset = renderBox!.localToGlobal(Offset.zero);
    final overlay = Overlay.of(context);
    // overlay.
    final overlayEntry = OverlayEntry(
      builder: (context) {
        return CompositedTransformFollower(
          link: layerLink,
          child: Flow(
            delegate: DragHandleDelegate(),
            children: [
              Container(
                height: widget.height, //TODO: Change values
                width: 30,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 5,
                    // strokeAlign: StrokeAlign.outside,
                  ),
                ),
              ),
              // DragHandle(
              //   height: widget.height - handleSize,
              //   width: handleSize,
              //   debugColor: Colors.red.withOpacity(0.5),
              //   hoverCursor: SystemMouseCursors.resizeLeftRight,
              //   onDrag: (dx, dy) {
              //     print('$dx, $dy');
              //   },
              // ),
            ],
          ),
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
    SchedulerBinding.instance.addPostFrameCallback((_) {
      addOverlay(context);
    });

    return RotationTransition(
      turns: AlwaysStoppedAnimation(widget.rotation),
      child: CompositedTransformTarget(
        link: layerLink,
        child: Opacity(
          key: key,
          opacity: widget.opacity,
          child: SizedBox(
            height: widget.height,
            width: widget.width,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class DragHandleDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
    context.paintChild(0);
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return false;
  }
}

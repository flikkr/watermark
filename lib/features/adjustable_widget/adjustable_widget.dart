import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:watermark/features/adjustable_widget/drag_handle.dart';
import 'package:watermark/features/image_canvas/image_viewer_interacting_cubit.dart';
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
  static const double handleSize = 2;
  bool isFocused = true;
  double top = 0;
  double left = 0;
  OverlayEntry? overlayEntry;

  @override
  void initState() {
    super.initState();
  }

  void addOverlay(BuildContext context, double scale) {
    RenderBox? renderBox = key.currentContext!.findRenderObject() as RenderBox?;
    Offset offset = renderBox!.localToGlobal(Offset.zero);
    final overlay = Overlay.of(context);
    overlayEntry?.remove();
    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: offset.dy,
          left: offset.dx,
          child: IgnorePointer(
            child: Container(
              height: widget.height * scale,
              width: widget.width * scale,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                  width: handleSize,
                  // strokeAlign: StrokeAlign.outside,
                ),
              ),
            ),
          ),
          // child: Flow(
          //   delegate: DragHandleDelegate(offset),
          //   children: [
          //     IgnorePointer(
          //       child: ConstrainedBox(
          //         constraints: BoxConstraints(maxHeight: 30, maxWidth: 30),
          //         child: Container(
          //           height: 30, //TODO: Change values
          //           width: 30,
          //           decoration: BoxDecoration(
          //             border: Border.all(
          //               color: Colors.blue,
          //               width: 5,
          //               // strokeAlign: StrokeAlign.outside,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //     // DragHandle(
          //     //   height: widget.height - handleSize,
          //     //   width: handleSize,
          //     //   debugColor: Colors.red.withOpacity(0.5),
          //     //   hoverCursor: SystemMouseCursors.resizeLeftRight,
          //     //   onDrag: (dx, dy) {
          //     //     print('$dx, $dy');
          //     //   },
          //     // ),
          //   ],
          // ),
        );
      },
    );
    overlay?.insert(overlayEntry!);
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
    return BlocBuilder<ImageViewerInteractingCubit, double?>(
      builder: (context, state) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          addOverlay(context, state ?? 0);
        });
        return RotationTransition(
          turns: AlwaysStoppedAnimation(widget.rotation),
          child: Opacity(
            key: key,
            opacity: widget.opacity,
            child: SizedBox(
              height: widget.height,
              width: widget.width,
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}

class DragHandleDelegate extends FlowDelegate {
  final Offset parentOffset;

  const DragHandleDelegate(this.parentOffset);

  @override
  void paintChildren(FlowPaintingContext context) {
    context.paintChild(
      0,
      transform: Matrix4.translation(
        // vector.Vector3(parentOffset.dx, parentOffset.dy, 0),
        vector.Vector3(0, 0, 0),
      ),
    );
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return false;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:watermark/features/image_canvas/image_viewer_interaction_cubit.dart';
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

  void addOverlay(
    BuildContext context, {
    required ImageViewerInteraction interaction,
    double rotation = 0,
  }) {
    RenderBox? renderBox = key.currentContext!.findRenderObject() as RenderBox?;
    Offset offset = renderBox!.localToGlobal(Offset.zero);
    final overlay = Overlay.of(context);
    overlayEntry?.remove();
    overlayEntry = OverlayEntry(
      builder: (context) {
        double scale = interaction.scale;

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
    return BlocBuilder<ImageViewerInteractionCubit, ImageViewerInteraction>(
      builder: (context, interaction) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          addOverlay(
            context,
            interaction: interaction,
            rotation: widget.rotation,
          );
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

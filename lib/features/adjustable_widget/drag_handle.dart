import 'package:flutter/material.dart';
import 'package:watermark/features/adjustable_widget/adjustable_widget.dart';

class DragHandle extends StatefulWidget {
  final void Function(double dx, double dy) onDrag;
  final Color? debugColor;
  final double? height;
  final double? width;
  final MouseCursor? hoverCursor;

  DragHandle({
    super.key,
    required this.onDrag,
    this.height,
    this.width,
    this.hoverCursor,
    this.debugColor,
  });

  @override
  State<DragHandle> createState() => DragHandleState();
}

class DragHandleState extends State<DragHandle> {
  double initX = 0;
  double initY = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _handleDrag,
      onPanUpdate: _handleUpdate,
      child: MouseRegion(
        hitTestBehavior: HitTestBehavior.translucent,
        cursor: widget.hoverCursor ?? MouseCursor.defer,
        child: IgnorePointer(
          child: Container(
            height: widget.height,
            width: widget.width,
            color: widget.debugColor ?? Colors.transparent,
          ),
        ),
      ),
    );
  }

  void _handleDrag(DragStartDetails details) {
    setState(() {
      initX = details.globalPosition.dx;
      initY = details.globalPosition.dy;
    });
  }

  void _handleUpdate(DragUpdateDetails details) {
    var dx = details.globalPosition.dx - initX;
    var dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    widget.onDrag(dx, dy);
  }
}

class OverlayWidget extends StatefulWidget {
  const OverlayWidget(
      {Key? key,
      required this.parentWidget,
      required this.horizontalOffset,
      required this.verticalOffset,
      required this.mediaQuery})
      : super(key: key);
  final GlobalKey<DragHandleState> parentWidget;
  final double horizontalOffset;
  final double verticalOffset;
  final MediaQueryData mediaQuery;

  @override
  State<OverlayWidget> createState() => _OverlayWidgetState();
}

class _OverlayWidgetState extends State<OverlayWidget> {
  OverlayEntry? overlay;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    removeOverlay();
  }

  @override
  Widget build(BuildContext context) {
    Future(addOverlay);
    return Container();
  }

  void addOverlay() {
    removeOverlay();
    RenderBox? renderBox = context.findAncestorRenderObjectOfType<RenderBox>();

    var parentSize = renderBox!.size;
    var parentPosition = renderBox.localToGlobal(Offset.zero);

    overlay = _overlayEntryBuilder(parentPosition, parentSize);
    Overlay.of(context)!.insert(overlay!);
  }

  void removeOverlay() {
    overlay?.remove();
  }

  OverlayEntry _overlayEntryBuilder(Offset parentPosition, Size parentSize) {
    const clickableArea = 10.0;

    return OverlayEntry(
      maintainState: true,
      builder: (context) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: parentPosition.dx + parentSize.width - clickableArea - widget.horizontalOffset,
              top: parentPosition.dy + parentSize.height - clickableArea - widget.verticalOffset,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    color: Colors.blue.withAlpha(200),
                    width: clickableArea,
                    height: clickableArea,
                    child: Text(
                      'InkWell (Overlay)',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: parentPosition.dx + parentSize.width - clickableArea - widget.horizontalOffset,
              top: parentPosition.dy + widget.verticalOffset,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  color: Colors.purple.withAlpha(200),
                  width: clickableArea,
                  height: clickableArea,
                  child: Text(
                    'Gesture (Overlay)',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

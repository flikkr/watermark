import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watermark/features/adjustable_widget/adjustable_widget.dart';
import 'package:watermark/features/image_canvas/image_canvas.dart';
import 'package:watermark/features/image_canvas/image_cubit.dart';
import 'package:watermark/features/image_edit_panel/image_settings.dart';
import 'package:watermark/features/image_edit_panel/image_settings_cubit.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ImageCubit()),
          BlocProvider(create: (_) => ImageSettingsCubit()),
        ],
        child: TestCanvas(),
      ),
    );
  }
}

class TestCanvas extends StatefulWidget {
  const TestCanvas({super.key});

  @override
  State<TestCanvas> createState() => _TestCanvasState();
}

class _TestCanvasState extends State<TestCanvas> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setup();
    });
  }

  void setup() async {
    final asset = await rootBundle.load("assets/sea.jpg");
    final bytes = asset.buffer.asUint8List();
    final image = await decodeImageFromList(bytes);
    final imgHeight = image.height;
    final imgWidth = image.width;
    setState(() {
      BlocProvider.of<ImageCubit>(context).updateImage(bytes);
      BlocProvider.of<ImageSettingsCubit>(context).updateSettings(ImageSettings(
        watermarkBytes: bytes,
        height: imgHeight.toDouble(),
        width: imgWidth.toDouble(),
        initialHeight: imgHeight.toDouble(),
        initialWidth: imgWidth.toDouble(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

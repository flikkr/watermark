import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as ui;
import 'package:watermark/image_canvas/image_canvas.dart';
import 'package:watermark/image_canvas/image_cubit.dart';
import 'package:watermark/image_edit_panel/image_edit_panel.dart';
import 'package:watermark/image_edit_panel/image_settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey globalKey = GlobalKey();
  Future<Uint8List?>? imageData;
  late ImageSettings imageSettings;

  @override
  void initState() {
    super.initState();
    imageSettings = ImageSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => EditedImageCubit()),
          BlocProvider(create: (_) => WatermarkImageCubit()),
        ],
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ImageEditPanel(
              onUpdateSettings: (value) {
                setState(() {
                  imageSettings = value;
                });
              },
            ),
            ImageCanvas(),
            // Expanded(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     mainAxisAlignment: MainAxisAlignment.center,
            // children: <Widget>[
            // RepaintBoundary(
            //   key: globalKey,
            //   child: const Card(
            //     elevation: 3,
            //     color: Colors.red,
            //     child: Padding(
            //       padding: EdgeInsets.all(8.0),
            //       child: Text('Hello world'),
            //     ),
            //   ),
            // ),
            // if (imageData != null)
            //   FutureBuilder<Uint8List?>(
            //     future: imageData,
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.done) {
            //         final data = snapshot.data;
            //         if (data == null) {
            //           return const Text('Could not generate image');
            //         } else {
            //           return RotationTransition(
            //             turns: AlwaysStoppedAnimation(imageSettings.rotation),
            //             child: Image.memory(data),
            //           );
            //           // return Container();
            //         }
            //       }
            //       return const CircularProgressIndicator();
            //     },
            //   ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: generateImage,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> generateImage() async {
    // final sea = await rootBundle.load("assets/sea.jpg");

    if (!mounted) return;
    RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 2);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final byteList = byteData?.buffer.asUint8List();
    setState(() {
      imageData = Future.value(byteList);
    });
  }
}

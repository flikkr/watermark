import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as ui;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Drawer(
            child: Column(
              children: [
                Slider
              ],
            ),,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RepaintBoundary(
                  key: globalKey,
                  child: const Card(
                    elevation: 3,
                    color: Colors.red,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Hello world'),
                    ),
                  ),
                ),
                if (imageData != null)
                  FutureBuilder<Uint8List?>(
                    future: imageData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        final data = snapshot.data;
                        if (data == null) {
                          return const Text('Could not generate image');
                        } else {
                          return Image.memory(
                            data,
                          );
                        }
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
              ],
            ),
          ),
        ],
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

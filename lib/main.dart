import 'dart:ui';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watermark/features/dummy_canvas.dart';
import 'package:watermark/features/image_canvas/image_canvas.dart';
import 'package:watermark/features/image_canvas/image_cubit.dart';
import 'package:watermark/features/image_edit_panel/image_edit_panel.dart';
import 'package:watermark/features/image_edit_panel/image_settings.dart';
import 'package:watermark/features/image_edit_panel/image_settings_cubit.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          isDense: true,
        ),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ImageCubit()),
          BlocProvider(create: (_) => ImageSettingsCubit()),
        ],
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: const [
            ImageEditPanel(),
            Expanded(child: ImageCanvas()),
          ],
        ),
      ),
    );
    return TestPage();
  }
}

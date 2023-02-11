import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yawt/bloc/selected_image_cubit.dart';
import 'package:yawt/bloc/watermark_cubit.dart';
import 'package:yawt/src/image_canvas/image_canvas.dart';
import 'package:yawt/bloc/images_cubit.dart';
import 'package:yawt/src/widgets/image_side_panel/image_side_panel.dart';

import 'src/widgets/image_bottom_panel/watermark_tools.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ImagesCubit()),
        BlocProvider(create: (_) => WatermarkCubit()),
        BlocProvider(create: (_) => SelectedImageCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
            isDense: true,
          ),
        ),
        home: const App(),
      ),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          const ImagePanel(),
          Expanded(
            child: Column(
              children: const [
                Expanded(
                  child: ImageCanvas(),
                ),
                WatermarkTools(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

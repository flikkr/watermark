import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class WatermarkTools extends StatelessWidget {
  const WatermarkTools({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 150,
        width: double.infinity,
        child: Text("hello"),
      ),
    );
  }
}

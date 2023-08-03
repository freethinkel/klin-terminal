import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class ShaderWrapper extends StatefulWidget {
  const ShaderWrapper({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  State<ShaderWrapper> createState() => _ShaderWrapperState();
}

class _ShaderWrapperState extends State<ShaderWrapper> {
  int count = 0;
  double time = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        time += 0.016;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderBuilder(
      (context, shader, child) {
        return AnimatedSampler(
          (image, size, canvas) {
            final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
            shader
              ..setFloat(0, image.width.toDouble() / devicePixelRatio)
              ..setFloat(1, image.height.toDouble() / devicePixelRatio)
              ..setFloat(2, time)
              ..setImageSampler(0, image);

            canvas
              ..save()
              ..drawRect(
                Offset.zero & size,
                Paint()..shader = shader,
              )
              ..restore();
          },
          child: child!,
        );
      },
      assetKey: "shaders/glitch.glsl",
      child: widget.child,
    );
  }
}

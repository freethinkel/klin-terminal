import 'dart:ui';

import 'package:flutter/material.dart';

class GlowEffect extends StatefulWidget {
  const GlowEffect({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  State<GlowEffect> createState() => _GlowEffectState();
}

class _GlowEffectState extends State<GlowEffect> {
  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(
        sigmaX: 5,
        sigmaY: 5,
      ),
      child: widget.child,
    );
  }
}

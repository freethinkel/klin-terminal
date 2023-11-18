import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:klin/shared/models/color.dart';

class TabbarFilers extends StatelessWidget {
  const TabbarFilers({
    required this.child,
    this.isActive = false,
    super.key,
  });
  final bool isActive;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!isActive) {
      return child;
    }

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.compose(
          outer: ColorFilter.matrix(ColorFilterGenerator.saturationAdjustMatrix(
            value: 0.1,
          )),
          inner: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        ),
        blendMode: BlendMode.src,
        child: child,
      ),
    );
  }
}

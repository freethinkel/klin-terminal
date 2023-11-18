import 'package:flutter/material.dart';
import 'package:klin/modules/theme/controllers/theme.controller.dart';
import 'package:rx_flow/rx_flow.dart';

class BackgroundConnector extends RxConsumer {
  const BackgroundConnector({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context, watcher) {
    final themeController = watcher.controller<ThemeController>();
    final backgroundImage = watcher.watch(themeController.backgroundImage$);

    Widget child = this.child;

    child = Stack(
      children: [
        if (backgroundImage != null)
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            bottom: 0,
            child: Image.file(
              backgroundImage,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(),
            ),
          ),
        child,
      ],
    );

    return child;
  }
}

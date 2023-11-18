import 'package:flutter/material.dart';
import 'package:gesture_x_detector/gesture_x_detector.dart';
import 'package:klin/shared/controller/window_manager.controller.dart';
import 'package:rx_flow/rx_flow.dart';

class DraggableWindow extends RxConsumer {
  const DraggableWindow({
    required this.child,
    this.disabled = false,
    super.key,
  });
  final Widget child;
  final bool disabled;

  @override
  Widget build(BuildContext context, watcher) {
    final windowManagerController =
        watcher.controller<WindowManagerController>();

    return XGestureDetector(
      onMoveStart: disabled
          ? null
          : (details) {
              windowManagerController.startDragging();
            },
      onDoubleTap: disabled
          ? null
          : (_) async {
              bool isMaximized = await windowManagerController.isMaximized();
              if (!isMaximized) {
                windowManagerController.maximize();
              } else {
                windowManagerController.unmaximize();
              }
            },
      child: child,
    );
  }
}

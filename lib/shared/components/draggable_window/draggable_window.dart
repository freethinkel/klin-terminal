import 'package:klin/modules/channel/controllers/channel.controller.dart';
import 'package:flutter/material.dart';
import 'package:gesture_x_detector/gesture_x_detector.dart';
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
    final channelController = watcher.controller<ChannelController>();

    return XGestureDetector(
      onMoveStart: disabled
          ? null
          : (details) {
              channelController.startDragging();
            },
      onDoubleTap: disabled
          ? null
          : (_) async {
              bool isMaximized = await channelController.isMaximized();
              if (!isMaximized) {
                channelController.maximize();
              } else {
                channelController.unmaximize();
              }
            },
      child: child,
    );
  }
}

import 'package:klin/core/widgets/controller_connector.dart';
import 'package:klin/modules/channel/controllers/channel.controller.dart';
import 'package:flutter/material.dart';
import 'package:gesture_x_detector/gesture_x_detector.dart';

class DraggableWindow extends StatelessWidget {
  const DraggableWindow({
    required this.child,
    this.disabled = false,
    super.key,
  });
  final Widget child;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return ControllerConnector<ChannelController>(
      builder: (context, controller) => XGestureDetector(
        onMoveStart: disabled
            ? null
            : (details) {
                controller.startDragging();
              },
        onDoubleTap: disabled
            ? null
            : (_) async {
                bool isMaximized = await controller.isMaximized();
                if (!isMaximized) {
                  controller.maximize();
                } else {
                  controller.unmaximize();
                }
              },
        child: child,
      ),
    );
  }
}

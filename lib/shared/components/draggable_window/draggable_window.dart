import 'package:cheber_terminal/core/widgets/controller_connector.dart';
import 'package:cheber_terminal/modules/channel/controllers/channel.controller.dart';
import 'package:flutter/material.dart';

class DraggableWindow extends StatelessWidget {
  const DraggableWindow({
    required this.child,
    this.ignoreDoubleTap = false,
    this.disabled = false,
    super.key,
  });
  final Widget child;
  final bool ignoreDoubleTap;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return ControllerConnector<ChannelController>(
      builder: (context, controller) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanStart: disabled
            ? null
            : (details) {
                controller.startDragging();
              },
        onDoubleTap: ignoreDoubleTap || disabled
            ? null
            : () async {
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

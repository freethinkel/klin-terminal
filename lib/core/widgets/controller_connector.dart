import 'package:oshmes_terminal/core/di/locator.dart';
import 'package:oshmes_terminal/core/models/controller.dart';
import 'package:flutter/widgets.dart';

class ControllerConnector<C extends IController> extends StatefulWidget {
  const ControllerConnector({
    required this.builder,
    this.useWidgetGate = false,
    super.key,
  });

  final Widget Function(BuildContext, C controller) builder;
  final bool useWidgetGate;

  @override
  State<ControllerConnector<C>> createState() => _ControllerConnectorState<C>();

  static C of<C extends IController>() {
    return locator.get<C>();
  }
}

class _ControllerConnectorState<C extends IController>
    extends State<ControllerConnector<C>> {
  final C controller = locator.get();

  @override
  void initState() {
    if (widget.useWidgetGate) {
      controller.init();
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.useWidgetGate) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, controller);
  }
}

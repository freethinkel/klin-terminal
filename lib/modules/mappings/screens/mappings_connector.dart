import 'package:klin/core/widgets/controller_connector.dart';
import 'package:klin/core/widgets/rx_consumer.dart';
import 'package:flutter/cupertino.dart';
import 'package:klin/modules/mappings/controllers/mappings.controller.dart';

class MappingsConnector extends RxConsumer {
  const MappingsConnector({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  void onInit() {
    ControllerConnector.of<MappingController>().init();
  }

  @override
  Widget build(BuildContext context, watcher) {
    final mappingController = watcher.controller<MappingController>();

    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: mappingController.onKey,
      child: Focus(
        onKey: (node, event) => mappingController.handled
            ? KeyEventResult.handled
            : KeyEventResult.ignored,
        child: child,
      ),
    );
  }
}

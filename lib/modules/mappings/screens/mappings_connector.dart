import 'package:cheber_terminal/core/widgets/controller_connector.dart';
import 'package:cheber_terminal/modules/mappings/controllers/mappings.controller.dart';
import 'package:flutter/cupertino.dart';

class MappingsConnector extends StatefulWidget {
  const MappingsConnector({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  State<MappingsConnector> createState() => _MappingsConnectorState();
}

class _MappingsConnectorState extends State<MappingsConnector> {
  @override
  Widget build(BuildContext context) {
    return ControllerConnector<MappingsController>(
      builder: (context, mappingsController) => Shortcuts(
        // manager: LoggingShortcutManager(),
        shortcuts: Map.fromEntries(
          mappingsController.mappings.map(
            (item) => MapEntry(
              item.activator,
              item.intent,
            ),
          ),
        ),
        child: widget.child,
      ),
    );
  }
}

class LoggingShortcutManager extends ShortcutManager {
  @override
  KeyEventResult handleKeypress(BuildContext context, RawKeyEvent event) {
    final KeyEventResult result = super.handleKeypress(context, event);
    print("${result} ${event}");
    if (result == KeyEventResult.handled) {
      print('Handled shortcut $event in $context');
    }
    return result;
  }
}

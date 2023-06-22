import 'package:cheber_terminal/core/widgets/rx_consumer.dart';
import 'package:cheber_terminal/modules/mappings/controllers/mappings.controller.dart';
import 'package:cheber_terminal/modules/mappings/screens/actions_connector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class MappingsConnector extends RxConsumer {
  const MappingsConnector({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context, watcher) {
    final mappingsController = watcher.controller<MappingsController>();
    final shortcuts = Map.fromEntries(
      mappingsController.mappings.map(
        (item) => MapEntry(
          item.activator,
          item.intent,
        ),
      ),
    );

    return Shortcuts(
      shortcuts: shortcuts,
      child: Focus(
        onKey: (node, event) {
          // print(RawKeyboard.instance.keysPressed);
          return KeyEventResult.ignored;
        },
        child: ActionsConnector(
          child: child,
        ),
      ),
    );
  }
}

class LogManager extends ShortcutManager {
  @override
  KeyEventResult handleKeypress(BuildContext context, RawKeyEvent event) {
    print(event);
    return super.handleKeypress(context, event);
  }
}

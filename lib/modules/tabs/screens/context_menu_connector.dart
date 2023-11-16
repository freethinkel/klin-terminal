import 'package:collection/collection.dart';
import 'package:klin/core/widgets/rx_consumer.dart';
import 'package:klin/modules/mappings/controllers/mappings.controller.dart';
import 'package:klin/modules/mappings/models/intents.dart';
import 'package:klin/modules/mappings/models/shortcuts.dart';
import 'package:klin/modules/terminal/models/terminal_node.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:super_context_menu/super_context_menu.dart';
import 'package:xterm/xterm.dart';

class ContextMenuConnector extends RxConsumer {
  const ContextMenuConnector({
    required this.child,
    required this.terminalNode,
    this.onSplit,
    super.key,
  });
  final TerminalNode terminalNode;
  final Widget child;

  final Function(Axis axis)? onSplit;

  CustomShortcut? getMappingByAction(
      List<CustomShortcut> mappings, AppMappingActions action) {
    return mappings.firstWhereOrNull((element) => element.action == action);
  }

  @override
  Widget build(BuildContext context, watcher) {
    final mappingController = watcher.controller<MappingController>();
    final mappings = watcher.watch(mappingController.mappings) ?? [];

    final splitDownMapping =
        getMappingByAction(mappings, AppMappingActions.splitDown);
    final splitRightMapping =
        getMappingByAction(mappings, AppMappingActions.splitRight);
    final closeTerminalMapping =
        getMappingByAction(mappings, AppMappingActions.closeTerminal);

    return ContextMenuWidget(
      child: child,
      menuProvider: (_) {
        return Menu(
          children: [
            MenuAction(
              callback: () async {
                final data = await Clipboard.getData("text/plain");
                if (data?.text == null) {
                  return;
                }
                terminalNode.terminal.paste(data!.text!);
              },
              activator:
                  const SingleActivator(LogicalKeyboardKey.keyV, meta: true),
              title: "Paste",
            ),
            MenuAction(
              callback: () {
                terminalNode.terminalController.setSelection(
                  terminalNode.terminal.buffer.createAnchor(
                    0,
                    0,
                  ),
                  terminalNode.terminal.buffer.createAnchor(
                    terminalNode.terminal.viewWidth,
                    terminalNode.terminal.buffer.height - 1,
                  ),
                  mode: SelectionMode.line,
                );
              },
              activator:
                  const SingleActivator(LogicalKeyboardKey.keyA, meta: true),
              title: "Select All",
            ),
            MenuSeparator(),
            MenuAction(
              callback: () {
                terminalNode.clear();
              },
              activator:
                  const SingleActivator(LogicalKeyboardKey.keyL, control: true),
              title: "Clear Buffer",
            ),
            MenuAction(
              callback: () {
                onSplit?.call(Axis.vertical);
                // tabsController.splitDown(terminalNode);
              },
              title: "Split Down",
              activator: splitDownMapping?.activator,
            ),
            MenuAction(
              callback: () {
                onSplit?.call(Axis.horizontal);
              },
              title: "Split Right",
              activator: splitRightMapping?.activator,
            ),
            MenuSeparator(),
            MenuAction(
              callback: () {
                terminalNode.dispose();
              },
              activator: closeTerminalMapping?.activator,
              title: "Close terminal",
            ),
          ],
        );
      },
    );
  }
}

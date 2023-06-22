import 'package:cheber_terminal/core/widgets/rx_consumer.dart';
import 'package:cheber_terminal/modules/mappings/controllers/mappings.controller.dart';
import 'package:cheber_terminal/modules/tabs/controllers/tabs.controller.dart';
import 'package:cheber_terminal/modules/terminal/models/terminal_node.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:super_context_menu/super_context_menu.dart';

class ContextMenuConnector extends RxConsumer {
  const ContextMenuConnector({
    required this.child,
    required this.terminalNode,
    this.onSplit,
    this.onClose,
    super.key,
  });
  final TerminalNode terminalNode;
  final Widget child;

  final Function(Axis axis)? onSplit;
  final Function()? onClose;

  @override
  Widget build(BuildContext context, watcher) {
    final mappingsController = watcher.controller<MappingsController>();

    return ContextMenuWidget(
      child: child,
      menuProvider: (_) {
        return Menu(
          children: [
            MenuAction(
              callback: () {},
              title: "Paste",
            ),
            MenuAction(
              callback: () {},
              title: "Select All",
            ),
            MenuSeparator(),
            MenuAction(
              callback: () {},
              title: "Clear Buffer",
            ),
            MenuAction(
              callback: () {
                onSplit?.call(Axis.vertical);
                // tabsController.splitDown(terminalNode);
              },
              title: "Split Down",
            ),
            MenuAction(
              callback: () {
                onSplit?.call(Axis.horizontal);
              },
              title: "Split Right",
              activator: const SingleActivator(
                LogicalKeyboardKey.backslash,
                meta: true,
                shift: true,
              ),
            ),
            MenuSeparator(),
            MenuAction(
              callback: () {
                onClose?.call();
                // tabsController.closeTab(tabsController.currentTab$.value!);
              },
              title: "Close terminal",
            ),
          ],
        );
      },
    );
  }
}

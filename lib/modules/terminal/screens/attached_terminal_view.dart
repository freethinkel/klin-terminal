import 'package:klin/core/widgets/rx_consumer.dart';
import 'package:klin/modules/settings/controllers/settings.controller.dart';
import 'package:klin/modules/terminal/components/terminal.dart';
import 'package:klin/modules/terminal/models/terminal_node.dart';

import 'package:flutter/material.dart';

class AttachedTerminal extends StatefulWidget {
  const AttachedTerminal({
    required this.terminalNode,
    super.key,
  });
  final TerminalNode terminalNode;

  @override
  State<AttachedTerminal> createState() => _AttachedTerminalState();
}

class _AttachedTerminalState extends State<AttachedTerminal> {
  @override
  void initState() {
    widget.terminalNode.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AttachedTerminalView(
      terminalNode: widget.terminalNode,
    );
  }
}

class AttachedTerminalView extends RxConsumer {
  const AttachedTerminalView({
    required this.terminalNode,
    super.key,
  });
  final TerminalNode terminalNode;

  @override
  Widget build(BuildContext context, watcher) {
    final settingsController = watcher.controller<SettingsController>();

    final fontSize = watcher.watch(settingsController.fontSize$);
    final fontFamily = watcher.watch(settingsController.fontFamily$);
    final lineHeight = watcher.watch(settingsController.lineHeight$);
    final opacity = watcher.watch(settingsController.opacity$);
    final padding = watcher.watch(settingsController.padding$);
    final verticalLineOffset =
        watcher.watch(settingsController.customVerticalLineOffset$);
    final enableCustomGlyphs =
        watcher.watch(settingsController.enableCustomGlyphs$) == true;

    return KlinTerminalView(
      terminal: terminalNode.terminal,
      controller: terminalNode.terminalController,
      focusNode: terminalNode.focusNode,
      padding: padding,
      opacity: opacity,
      fontFamily: fontFamily,
      fontSize: fontSize,
      lineHeight: lineHeight,
      enableCustomGlyphs: enableCustomGlyphs,
      verticalLineOffset: verticalLineOffset,
    );
  }
}

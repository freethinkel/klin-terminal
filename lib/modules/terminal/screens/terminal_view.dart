import 'dart:ui';

import 'package:cheber_terminal/core/widgets/rx_consumer.dart';
import 'package:cheber_terminal/modules/settings/controllers/settings.controller.dart';
import 'package:cheber_terminal/modules/theme/components/theme_connector.dart';
import 'package:flutter/material.dart';
import 'package:xterm/xterm.dart';

class TerminalInner extends RxConsumer {
  const TerminalInner({
    required this.terminal,
    this.focusNode,
    super.key,
  });
  final Terminal terminal;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context, StateWatcher watcher) {
    final settingsController = watcher.controller<SettingsController>();

    final fontSize = watcher.watch(settingsController.fontSize$);
    final fontFamily = watcher.watch(settingsController.fontFamily$);
    final lineHeight = watcher.watch(settingsController.lineHeight$);
    final opacity = watcher.watch(settingsController.opacity$);
    final padding = watcher.watch(settingsController.padding$);

    return TerminalView(
      terminal,
      scrollType: TerminalScrollType.perRow,
      cursorType: TerminalCursorType.block,
      autofocus: true,
      focusNode: focusNode,
      backgroundOpacity: opacity ?? 1,
      padding: EdgeInsets.all(padding?.toDouble() ?? 0),
      theme: AppTheme.of(context).terminalTheme,
      textStyle: TerminalStyle.fromTextStyle(
        TextStyle(
            fontFamily: fontFamily,
            fontSize: (fontSize ?? 14).toDouble(),
            height: lineHeight ?? 1,
            overflow: TextOverflow.visible,
            fontFeatures: const [
              FontFeature.historicalLigatures(),
              FontFeature("liga"),
              FontFeature("dlig")
            ]),
      ),
    );
  }
}

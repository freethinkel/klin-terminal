import 'dart:ui';

import 'package:klin/modules/mappings/controllers/mappings.controller.dart';
import 'package:klin/modules/settings/controllers/settings.controller.dart';
import 'package:klin/modules/terminal/components/terminal.dart';
import 'package:klin/modules/terminal/models/terminal_node.dart';

import 'package:flutter/material.dart';
import 'package:klin/modules/theme/controllers/theme.controller.dart';
import 'package:klin/shared/models/color.dart';
import 'package:rx_flow/rx_flow.dart';
import 'package:xterm/xterm.dart';

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
    final mappingController = watcher.controller<MappingController>();
    final themeController = watcher.controller<ThemeController>();

    final fontSize = watcher.watch(settingsController.fontSize$);
    final zoomLevel = watcher.watch(settingsController.zoomLevel$) ?? 1.0;
    final fontFamily = watcher.watch(settingsController.fontFamily$);
    final lineHeight = watcher.watch(settingsController.lineHeight$);
    final opacity = watcher.watch(settingsController.opacity$);
    final padding = watcher.watch(settingsController.padding$);
    final verticalLineOffset =
        watcher.watch(settingsController.customVerticalLineOffset$);
    final enableCustomGlyphs =
        watcher.watch(settingsController.enableCustomGlyphs$) == true;

    final cellBackgroundOpacity =
        watcher.watch(settingsController.cellBackgroundOpacity$) ?? 1.0;
    final transparentBackgroundCells =
        watcher.watch(settingsController.transparentBackgroundCells$) == true;
    final macOptionIsMeta =
        watcher.watch(mappingController.macOptionAsMeta$) == true;
    final glowEffectEnabled =
        watcher.watch(themeController.glowEffectEnabled$) == true;

    if (terminalNode.terminal.macOptionIsMeta != macOptionIsMeta) {
      terminalNode.terminal.macOptionIsMeta = macOptionIsMeta;
      terminalNode.terminal.inputHandler =
          defaultInputHandler(macOptionIsMeta: macOptionIsMeta);
    }

    return Stack(
      children: [
        KlinTerminalView(
          terminal: terminalNode.terminal,
          controller: terminalNode.terminalController,
          focusNode: terminalNode.focusNode,
          padding: padding,
          opacity: opacity,
          fontFamily: fontFamily,
          fontSize: fontSize!.toDouble() * zoomLevel,
          lineHeight: lineHeight,
          enableCustomGlyphs: enableCustomGlyphs,
          verticalLineOffset: verticalLineOffset,
          transparentBackgroundCells: transparentBackgroundCells,
          cellBackgroundOpacity: cellBackgroundOpacity,
        ),
        if (glowEffectEnabled)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: BackdropFilter(
              filter: ImageFilter.compose(
                outer: ColorFilter.matrix(
                    ColorFilterGenerator.saturationAdjustMatrix(
                  value: 0.5,
                )),
                inner: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              ),
              blendMode: BlendMode.screen,
              child: const SizedBox(),
            ),
          )
      ],
    );
  }
}

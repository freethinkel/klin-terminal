import 'dart:ui';
import 'package:klin/modules/theme/components/theme_connector.dart';
import 'package:flutter/material.dart';
import 'package:xterm/xterm.dart';

class KlinTerminalView extends StatelessWidget {
  const KlinTerminalView({
    required this.terminal,
    this.controller,
    this.fontSize,
    this.fontFamily,
    this.lineHeight,
    this.opacity,
    this.padding,
    this.verticalLineOffset,
    this.enableCustomGlyphs = true,
    this.transparentBackgroundCells = false,
    this.cellBackgroundOpacity = 1,
    this.focusNode,
    super.key,
  });
  final Terminal terminal;
  final TerminalController? controller;
  final FocusNode? focusNode;
  final double? fontSize;
  final String? fontFamily;
  final double? lineHeight;
  final double? opacity;
  final int? padding;
  final double? verticalLineOffset;
  final bool enableCustomGlyphs;
  final bool transparentBackgroundCells;
  final double cellBackgroundOpacity;

  @override
  Widget build(BuildContext context) {
    return TerminalView(
      terminal,
      controller: controller,
      scrollType: TerminalScrollType.perRow,
      cursorType: TerminalCursorType.block,
      autofocus: true,
      focusNode: focusNode,
      backgroundOpacity: opacity ?? 1,
      padding: EdgeInsets.all(padding?.toDouble() ?? 0),
      theme: AppTheme.of(context).terminalTheme,
      customGlyphs: enableCustomGlyphs,
      verticalLineOffset: verticalLineOffset ?? 0,
      transparentBackgroundCells: transparentBackgroundCells,
      cellBackgroundOpacity: cellBackgroundOpacity,
      textStyle: TerminalStyle.fromTextStyle(
        TextStyle(
          fontFamily: fontFamily,
          fontSize: (fontSize ?? 13).toDouble(),
          height: lineHeight ?? 1,
          fontFeatures: const [
            FontFeature.historicalLigatures(),
            FontFeature("liga"),
            FontFeature("dlig"),
          ],
        ),
      ),
    );
  }
}

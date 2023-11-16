import 'dart:ui';
import 'package:klin/modules/terminal/components/glow_effect.dart';
import 'package:klin/modules/terminal/components/shader_wrapper.dart';
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
    this.focusNode,
    super.key,
  });
  final Terminal terminal;
  final TerminalController? controller;
  final FocusNode? focusNode;
  final int? fontSize;
  final String? fontFamily;
  final double? lineHeight;
  final double? opacity;
  final int? padding;
  final double? verticalLineOffset;
  final bool enableCustomGlyphs;

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

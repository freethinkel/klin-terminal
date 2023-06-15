import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:cheber_terminal/core/widgets/controller_connector.dart';
import 'package:cheber_terminal/core/widgets/rx_builder.dart';
import 'package:cheber_terminal/modules/settings/controllers/settings.controller.dart';
import 'package:cheber_terminal/modules/theme/components/theme_connector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pty/flutter_pty.dart';
import 'package:xterm/xterm.dart';

class CheberTerminalView extends StatefulWidget {
  const CheberTerminalView({
    this.onChangeTitle,
    this.onExit,
    this.focusNode,
    super.key,
  });
  final Function(String)? onChangeTitle;
  final Function()? onExit;
  final FocusNode? focusNode;

  @override
  State<CheberTerminalView> createState() => _CheberTerminalViewState();
}

class _CheberTerminalViewState extends State<CheberTerminalView> {
  Terminal terminal = Terminal(maxLines: 10000);
  final terminalController = TerminalController();
  late final Pty pty;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.endOfFrame.then(
      (_) {
        if (mounted) _startPty();
      },
    );
  }

  void _startPty() {
    final shell = _platformShell;
    pty = Pty.start(
      shell.command,
      arguments: shell.args,
      columns: terminal.viewWidth,
      rows: terminal.viewHeight,
    );

    pty.output
        .cast<List<int>>()
        .transform(const Utf8Decoder())
        .listen(terminal.write);

    pty.exitCode.then((code) {
      terminal.write('the process exited with exit code $code');
      Future.delayed(Duration.zero).then((value) {
        widget.onExit?.call();
      });
    });

    terminal.onOutput = (data) {
      pty.write(const Utf8Encoder().convert(data));
    };

    terminal.onResize = (w, h, pw, ph) {
      pty.resize(h, w);
    };
    terminal.onTitleChange = widget.onChangeTitle;
  }

  @override
  Widget build(BuildContext context) {
    return ControllerConnector<SettingsController>(
      builder: (context, settingsController) => RxStateBuilder(
          state: settingsController.fontSize$,
          builder: (context, fontSize) {
            return RxStateBuilder(
                state: settingsController.lineHeight$,
                builder: (context, lineHeight) {
                  return RxStateBuilder(
                      state: settingsController.fontFamily$,
                      builder: (context, fontFamily) {
                        return RxStateBuilder(
                          state: settingsController.padding$,
                          builder: (context, padding) => RxStateBuilder(
                              state: settingsController.opacity$,
                              builder: (context, opacity) {
                                return TerminalView(
                                  terminal,
                                  scrollType: TerminalScrollType.perRow,
                                  cursorType: TerminalCursorType.block,
                                  autofocus: true,
                                  focusNode: widget.focusNode,
                                  backgroundOpacity: opacity ?? 1,
                                  padding:
                                      EdgeInsets.all(padding?.toDouble() ?? 0),
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
                              }),
                        );
                      });
                });
          }),
    );
  }
}

class _ShellCommand {
  final String command;

  final List<String> args;

  _ShellCommand(this.command, this.args);
}

_ShellCommand get _platformShell {
  if (Platform.isMacOS) {
    final user = Platform.environment['USER'];
    return _ShellCommand('login', ['-fp', user!]);
  }

  if (Platform.isWindows) {
    return _ShellCommand('cmd.exe', []);
  }

  final shell = Platform.environment['SHELL'] ?? 'sh';
  return _ShellCommand(shell, []);
}

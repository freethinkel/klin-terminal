import 'dart:convert';
import 'dart:io';
import 'package:cheber_terminal/modules/terminal/screens/terminal_view.dart';
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
      environment: Platform.environment,
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
    return TerminalInner(
      focusNode: widget.focusNode,
      terminal: terminal,
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
